import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/infrastructure/movie_repository.dart';
import 'package:fl_wework_movies/network/network.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static init() {
    getIt.registerSingleton<ApiHelper>(ApiHelper());
    getIt.registerSingleton<IMovieRepository>(
        MovieRepository(apiHelper: getIt.get<ApiHelper>()));
  }
}
