import 'package:dartz/dartz.dart';
import 'package:fl_wework_movies/database/appdatabase.dart';
import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:fl_wework_movies/network/network.dart';
import 'package:fl_wework_movies/utils/api_endpoints.dart';
import 'package:fl_wework_movies/utils/secrets.dart';
import 'package:flutter/material.dart';

class MovieRepository extends IMovieRepository {
  ApiHelper apiHelper;

  MovieRepository({required this.apiHelper});

  @override
  Future<Either<String, List<NowPlaying>>> fetchNowPlayingMovies() async {
    try {
      final database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final movieDao = database.movieDao;
      final List<NowPlaying> nowPlaying =
          await movieDao.getAllNowPlayingMovies();
      TmdbNowPlayingMovieResponseModel nowPlayingModel;
      String url = "${ApiEndpoints.tmdbBaseUrl}movie/now_playing";
      String token = Secrets.tmdbToken;
      var res = await apiHelper.request(
          url: url,
          headers: {"Authorization": "Bearer $token"},
          method: HTTPMETHOD.GET);

      if (nowPlaying.isNotEmpty) {
        debugPrint("Returning NowPlaying Cache");
        return right(nowPlaying);
      } else if (nowPlaying.isEmpty) {
        var res = await apiHelper.request(
            url: url,
            headers: {"Authorization": "Bearer $token"},
            method: HTTPMETHOD.GET);
        if (res.statusCode == 200) {
          debugPrint("Returning NowPlaying Remote");
          nowPlayingModel = TmdbNowPlayingMovieResponseModel.fromJson(res.data);
          movieDao.insertNowPlayingMovies(nowPlayingModel.results);
          return right(nowPlayingModel.results);
        } else {
          return left(res.message);
        }
      } else {
        return right([]);
      }
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TopRated>>> fetchTopRatedMovies() async {
    try {
      final database =
          await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final movieDao = database.movieDao;
      final List<TopRated> topRatedMovies =
          await movieDao.getAllTopRatedMovies();
      TmdbTopRatedMovieResponseModel topRatedModel;
      String url = "${ApiEndpoints.tmdbBaseUrl}movie/top_rated";
      String token = Secrets.tmdbToken;

      if (topRatedMovies.isNotEmpty) {
        debugPrint("Returning TopRated Cache");
        return right(topRatedMovies);
      } else if (topRatedMovies.isEmpty) {
        var res = await apiHelper.request(
            url: url,
            headers: {"Authorization": "Bearer $token"},
            method: HTTPMETHOD.GET);
        if (res.statusCode == 200) {
          debugPrint("Returning TopRated Remote");
          topRatedModel = TmdbTopRatedMovieResponseModel.fromJson(res.data);
          movieDao.insertTopRatedMovies(topRatedModel.results);
          return right(topRatedModel.results);
        } else {
          return left(res.message);
        }
      } else {
        return right([]);
      }
    } catch (e) {
      return left(e.toString());
    }
  }
}
