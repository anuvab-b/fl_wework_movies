import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class MovieDao{
  @Query("SELECT * FROM NowPlaying")
  Future<List<NowPlaying>> getAllNowPlayingMovies();
  @Query("SELECT * FROM TopRated")
  Future<List<TopRated>> getAllTopRatedMovies();
  @insert
  Future<void> insertNowPlayingMovies(List<NowPlaying> movies);
  @insert
  Future<void> insertTopRatedMovies(List<TopRated> movies);

  @Query("DELETE FROM NowPlaying")
  Future<void> deleteAllNowPlayingMovies();
  @Query("DELETE FROM TopRated")
  Future<void> deleteAllTopRatedMovies();
}