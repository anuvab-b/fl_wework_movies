import 'package:dartz/dartz.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';

abstract class IMovieRepository{
  Future<Either<String,TmdbMovieResponseModel>> fetchTopRatedMovies();
  Future<Either<String,TmdbMovieResponseModel>> fetchNowPlayingMovies();
}