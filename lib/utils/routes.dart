import 'package:fl_wework_movies/presentation/error_screen.dart';
import 'package:fl_wework_movies/presentation/home_screen.dart';
import 'package:fl_wework_movies/presentation/splash_screen.dart';
import 'package:fl_wework_movies/utils/route_names.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case RouteNames.home:
        return SlideRightRoute(widget: const HomeScreen());
      default:
        return MaterialPageRoute(builder: (context) => const ErrorScreen());
    }
  }
}

class MyPageRouteBuilder extends PageRouteBuilder {
  final RouteSettings routeSettings;

  MyPageRouteBuilder(
      {Key? key, required this.routeSettings, required super.pageBuilder});

  PageRouteBuilder build(BuildContext context) {
    return PageRouteBuilder(
        settings: routeSettings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: super.pageBuilder,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        });
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  SlideRightRoute({required this.widget})
      : super(pageBuilder: (BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return widget;
  }, transitionsBuilder: (BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  });
}