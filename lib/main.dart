import 'package:fl_wework_movies/presentation/home_screen.dart';
import 'package:fl_wework_movies/utils/route_names.dart';
import 'package:fl_wework_movies/utils/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WeWork Movies',
      theme: ThemeData(
       primarySwatch: Colors.blue),
      initialRoute: RouteNames.splash,
      onGenerateRoute: Routes.generateRoute
    );
  }
}
