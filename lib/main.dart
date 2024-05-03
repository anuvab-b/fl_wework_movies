import 'package:fl_wework_movies/bloc/now_playing/now_playing_bloc.dart';
import 'package:fl_wework_movies/bloc/splash/splash_bloc.dart';
import 'package:fl_wework_movies/bloc/top_rated/top_rated_bloc.dart';
import 'package:fl_wework_movies/domain/i_movie_repository.dart';
import 'package:fl_wework_movies/service_locator.dart';
import 'package:fl_wework_movies/utils/route_names.dart';
import 'package:fl_wework_movies/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<SplashBloc>(
            create: (BuildContext context) => SplashBloc()),
          BlocProvider<TopRatedBloc>(
              create: (BuildContext context) => TopRatedBloc(getIt.get<IMovieRepository>())),
          BlocProvider<NowPlayingBloc>(
              create: (BuildContext context) => NowPlayingBloc(getIt.get<IMovieRepository>())),
          // BlocProvider<SplashBloc>(
          //     create: (BuildContext context) => HomeBloc())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'WeWork Movies',
            theme: ThemeData(primarySwatch: Colors.blue),
            initialRoute: RouteNames.splash,
            onGenerateRoute: Routes.generateRoute));
  }
}
