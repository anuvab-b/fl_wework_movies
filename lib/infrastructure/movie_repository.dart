import 'package:dartz/dartz.dart';
import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:fl_wework_movies/network/network.dart';
import 'package:fl_wework_movies/utils/api_endpoints.dart';
import 'package:fl_wework_movies/utils/secrets.dart';

class MovieRepository extends IMovieRepository{
  ApiHelper apiHelper;
  MovieRepository({required this.apiHelper});
  @override
  Future<Either<String, TmdbMovieResponseModel>> fetchNowPlayingMovies() async {
    TmdbMovieResponseModel nowPlayingModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/now_playing";
    String token = Secrets.tmdbToken;

    try {
      var res = await apiHelper.request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        nowPlayingModel = TmdbMovieResponseModel.fromJson(res.data);
        return right(nowPlayingModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, TmdbMovieResponseModel>> fetchTopRatedMovies() async {
    TmdbMovieResponseModel topRatedModel;
    String url = "${ApiEndpoints.tmdbBaseUrl}movie/top_rated";
    String token = Secrets.tmdbToken;
    try {
      var res = await apiHelper.request(url: url, headers: {
        "Authorization": "Bearer $token"
      }, method: HTTPMETHOD.GET);
      if (res.statusCode == 200) {
        topRatedModel = TmdbMovieResponseModel.fromJson(res.data);
        return right(topRatedModel);
      }
      else {
        return left(res.message);
      }
    }
    catch(e){
      return left(e.toString());
    }
  }
}