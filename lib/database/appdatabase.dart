import 'package:fl_wework_movies/domain/movie_dao.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:floor/floor.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'appdatabase.g.dart';
@Database(version: 1, entities: [NowPlaying,TopRated])
abstract class AppDatabase extends FloorDatabase{
  MovieDao get movieDao;
}