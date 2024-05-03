import 'package:fl_wework_movies/bloc/now_playing/now_playing_bloc.dart';
import 'package:fl_wework_movies/bloc/top_rated/top_rated_bloc.dart';
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:fl_wework_movies/presentation/now_playing_view.dart';
import 'package:fl_wework_movies/presentation/top_rated_view.dart';
import 'package:fl_wework_movies/presentation/widgets/custom_card_clipper.dart';
import 'package:fl_wework_movies/presentation/widgets/text.dart';
import 'package:fl_wework_movies/utils/asset_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? position;
  late GeoCode geoCode;
  Address? address;
  late double scaleFactor = 50.0;
  late NowPlayingBloc nowPlayingBloc;
  late TopRatedBloc topRatedBloc;

  @override
  void initState() {
    super.initState();
    geoCode = GeoCode();
    nowPlayingBloc = BlocProvider.of<NowPlayingBloc>(context);
    topRatedBloc = BlocProvider.of<TopRatedBloc>(context);
    nowPlayingBloc.add(OnNowPlayingInit());
    topRatedBloc.add(OnTopRatedInit());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      scaleFactor = (MediaQuery.of(context).size.width - 2 * 16) / 7;
      position = await _determinePosition();
      if (position != null) {
        // address = await geoCode.reverseGeocoding(
        //     latitude: position!.latitude, longitude: position!.longitude);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFFAE96AA),
                Colors.white,
              ],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  if (address != null)
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(MdiIcons.mapMarkerOutline),
                            CommonText(
                                title: "${address!.streetAddress}",
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF282933)),
                          ]),
                          const SizedBox(height: 2.0),
                          CommonText(
                              title:
                                  "${address!.city}, ${address!.region}, ${address!.countryName}",
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: const Color(0xFF656072)),
                        ],
                      ),
                    ),
                  const SizedBox(height: 4.0),
                  Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.white),
                      child:
                          Image.asset(icWeWorkShort, width: 48.0, height: 48.0))
                ]),
                // Center(
                //   child: CustomPaint(
                //     foregroundPainter: CustomCardPainter(context: context),
                //   ),
                // ),
                const SizedBox(height: 16.0),
                ClipPath(
                  clipper: CustomCardClipper(scaleFactor: scaleFactor),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16.0),
                      width: 500,
                      height: 500,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [Color(0xFF8a808c), Color(0xFFa897a3)],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: scaleFactor * 1.0),
                          const CommonText(title: "We Movies", fontSize: 16.0),
                          const SizedBox(height: 4.0),
                          const CommonText(
                              title: "n movies are loaded in now playing",
                              fontWeight: FontWeight.w400),
                        ],
                      )),
                ),
                Row(
                  children: const [
                    CommonText(title: "NOW PLAYING"),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: Divider(
                            endIndent: 0.0, thickness: 1.0, color: Colors.grey))
                  ],
                ),
                BlocBuilder<NowPlayingBloc, NowPlayingState>(
                  builder: (context, state) {
                    if (state is NowPlayingSuccess) {
                      return SizedBox(
                        height: 320,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.nowPlayingList.length,
                            itemBuilder: (ctx, index) {
                              NowPlaying movie = state.nowPlayingList[index];
                              return Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  child: NowPlayingView(movie: movie,scaleFactor: scaleFactor));
                            }),
                      );
                    } else if (state is NowPlayingError) {
                      return Text(state.errorMessage);
                    } else {
                      return const CupertinoActivityIndicator();
                    }
                  },
                ),
                Row(
                  children: const [
                    CommonText(title: "TOP RATED"),
                    SizedBox(width: 12.0),
                    Expanded(
                        child: Divider(
                            endIndent: 0.0, thickness: 1.0, color: Colors.grey))
                  ],
                ),
                const SizedBox(height: 16.0),
                BlocBuilder<TopRatedBloc, TopRatedState>(
                  builder: (context, state) {
                    if (state is TopRatedSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: state.topRatedList.length,
                          itemBuilder: (ctx, index) {
                            TopRated movie = state.topRatedList[index];
                            return TopRatedView(movie: movie);
                          });
                    } else if (state is TopRatedError) {
                      return Text(state.errorMessage);
                    } else {
                      return const CupertinoActivityIndicator();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<Position?> _determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // Test if location services are enabled.
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        // Location services are not enabled don't continue
        // accessing the position and request users of the
        // App to enable the location services.
        throw 'Location services are disabled.';
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, next time you could try
          // requesting permissions again (this is also where
          // Android's shouldShowRequestPermissionRationale
          // returned true. According to Android guidelines
          // your App should show an explanatory UI now.
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        throw Exception(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      // When we reach here, permissions are granted and we can
      // continue accessing the position of the device.
      return await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
