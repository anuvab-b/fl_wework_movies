import 'package:fl_wework_movies/bloc/splash/splash_bloc.dart';
import 'package:fl_wework_movies/utils/asset_utils.dart';
import 'package:fl_wework_movies/utils/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    final SplashBloc splashBloc = BlocProvider.of<SplashBloc>(context);
    splashBloc.add(OnNavigateFromSplash());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<SplashBloc, SplashState>(listener: (context, state) {
      if (state is SplashSuccess) {
        Navigator.pushNamedAndRemoveUntil(
            context, RouteNames.home, (Route<dynamic> route) => false);
      } else if (state is SplashError) {}
    }, builder: (context, state) {
      if (state is SplashInit) {
        return Stack(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                      height: 160,
                      width: 160,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100.0),
                          border: Border.all(color: Colors.black))),
                ),
                const SpinKitRing(
                    color: Colors.black, lineWidth: 2.0, size: 160.0),
              ],
            ),
            Center(child: SvgPicture.asset(icWeWorkLogo)),
          ],
        );
      }
      return Container();
    }));
  }
}
