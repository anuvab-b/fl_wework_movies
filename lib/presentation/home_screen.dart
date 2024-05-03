import 'package:carousel_slider/carousel_slider.dart';
import 'package:fl_wework_movies/bloc/now_playing/now_playing_bloc.dart';
import 'package:fl_wework_movies/bloc/top_rated/top_rated_bloc.dart' as top;
import 'package:fl_wework_movies/domain/tmdb_movie_response_model.dart';
import 'package:fl_wework_movies/presentation/now_playing_view.dart';
import 'package:fl_wework_movies/presentation/top_rated_view.dart';
import 'package:fl_wework_movies/presentation/widgets/custom_card_clipper.dart';
import 'package:fl_wework_movies/presentation/widgets/text.dart';
import 'package:fl_wework_movies/utils/asset_utils.dart';
import 'package:fl_wework_movies/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int bottomIndex = -1;

  @override
  void initState() {
    bottomIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeContent(),
        const SizedBox(),
        const SizedBox(),
      ][bottomIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(color: Colors.black87),
        unselectedLabelStyle:
            const TextStyle(color: Colors.black87, fontWeight: FontWeight.w400),
        onTap: (int index) {
          setState(() {
            bottomIndex = index;
          });
        },
        currentIndex: bottomIndex,
        items: [
          BottomNavigationBarItem(
            label: "We Movies",
            activeIcon: Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.black87),
                child: Image.asset(
                  icWeWorkShort,
                  height: 24,
                  width: 24,
                  color: Colors.white,
                )),
            icon: Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    color: Colors.black87),
                child: Image.asset(
                  icWeWorkShort,
                  height: 16,
                  width: 16,
                  color: Colors.white,
                )),
          ),
          const BottomNavigationBarItem(
            label: "Explore",
            activeIcon: Icon(Icons.map_rounded),
            icon: Icon(Icons.map_outlined),
          ),
          const BottomNavigationBarItem(
            label: "Upcoming",
            activeIcon: Icon(Icons.calendar_month),
            icon: Icon(Icons.calendar_month_outlined),
          )
        ],
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  Position? position;
  late GeoCode geoCode;
  Address? address;
  late double scaleFactor;

  late NowPlayingBloc nowPlayingBloc;
  late top.TopRatedBloc topRatedBloc;
  late TextEditingController searchController;
  int selectedPageIndex = 0;
  int bannerPageIndex = 0;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    geoCode = GeoCode();
    nowPlayingBloc = BlocProvider.of<NowPlayingBloc>(context);
    topRatedBloc = BlocProvider.of<top.TopRatedBloc>(context);
    nowPlayingBloc.add(OnNowPlayingInit());
    topRatedBloc.add(top.OnTopRatedInit());
    scaleFactor =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width /
            8;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      debugPrint("ScaleFactor : $scaleFactor");
      position = await _determinePosition();
      if (position != null) {
        try {
          address = await geoCode.reverseGeocoding(
              latitude: position!.latitude, longitude: position!.longitude);
        } catch (e) {
          debugPrint(e.toString());
        }
      }
      setState(() {});
    });
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RefreshIndicator(
      onRefresh: () async {
        nowPlayingBloc.add(OnNowPlayingInit());
        topRatedBloc.add(top.OnTopRatedInit());
      },
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
                    padding: const EdgeInsets.all(2.0),
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
              const SizedBox(height: 24.0),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0)),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8.0),
                    Flexible(
                        child: TextFormField(
                      controller: searchController,
                      onChanged: (_) {
                        nowPlayingBloc.add(OnSearchMovieTextChange(text: _));
                        topRatedBloc.add(top.OnSearchMovieTextChange(text: _));
                      },
                      cursorColor: Colors.grey,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search Movies by name...",
                          hintStyle: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500)),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 24.0),
              Stack(
                children: [
                  Positioned(
                    top: scaleFactor / 3,
                    left: 16.0,
                    child: CommonText(
                        title: AppDateUtils.formatDateTime(DateTime.now(),
                                outputFormat: "MMMM do yyyy")
                            .toUpperCase(),
                        fontWeight: FontWeight.w700,
                        color: Colors.black87.withOpacity(0.75),
                        fontSize: 14.0),
                  ),
                  SizedBox(
                    child: ClipPath(
                      clipper: CustomCardClipper(scaleFactor: scaleFactor),
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 16.0),
                          width: MediaQuery.of(context).size.width,
                          height: scaleFactor * 3.0,
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
                              SizedBox(height: scaleFactor * 0.9),
                              const CommonText(
                                  title: "We Movies",
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600),
                              const SizedBox(height: 4.0),
                              BlocBuilder<NowPlayingBloc, NowPlayingState>(
                                  builder: (context, state) {
                                return CommonText(
                                    title:
                                        "${state.filterNowPlayingList.length} movies are loaded in now playing",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black38,
                                    fontSize: 12.0);
                              })
                            ],
                          )),
                    ),
                  ),
                ],
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
                    return state.filterNowPlayingList.isNotEmpty
                        ? Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: scaleFactor * 6.0,
                                child: CarouselSlider.builder(
                                    carouselController: CarouselController(),
                                    options: CarouselOptions(
                                        padEnds: true,
                                        autoPlay: false,
                                        // enlargeCenterPage: true,
                                        aspectRatio: 1.0,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            selectedPageIndex = index;
                                            bannerPageIndex = index;
                                            if (state.filterNowPlayingList
                                                    .length ==
                                                1) {
                                            } else if (state
                                                    .filterNowPlayingList
                                                    .length <
                                                3) {
                                              selectedPageIndex = index;
                                            } else if (state
                                                    .filterNowPlayingList
                                                    .length >=
                                                3) {
                                              if (bannerPageIndex ==
                                                  state.filterNowPlayingList
                                                          .length -
                                                      1) {
                                                selectedPageIndex = 2;
                                              } else if (bannerPageIndex >= 1 &&
                                                  bannerPageIndex <
                                                      state.filterNowPlayingList
                                                              .length -
                                                          1) {
                                                selectedPageIndex = 1;
                                              } else {
                                                selectedPageIndex =
                                                    bannerPageIndex;
                                              }
                                            }
                                          });
                                        }),
                                    itemCount:
                                        state.filterNowPlayingList.length,
                                    itemBuilder: (ctx, index, realIndex) {
                                      NowPlaying movie =
                                          state.filterNowPlayingList[index];
                                      return Container(
                                          margin:
                                              const EdgeInsets.only(right: 16),
                                          child: NowPlayingView(
                                              movie: movie,
                                              scaleFactor: scaleFactor));
                                    }),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                    state.filterNowPlayingList.length > 3
                                        ? 3
                                        : state.filterNowPlayingList.length,
                                    (int index) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: index == selectedPageIndex
                                          ? 40.0
                                          : 8.0,
                                      height: index == selectedPageIndex
                                          ? 24.0
                                          : 8.0,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          // shape: BoxShape.circle,
                                          color: index == selectedPageIndex
                                              ? Colors.black87
                                              : Colors.grey),
                                      child: index == selectedPageIndex
                                          ? CommonText(
                                              title:
                                                  "${bannerPageIndex + 1}/${state.filterNowPlayingList.length}",
                                              color: Colors.white,
                                              fontSize: 10.0)
                                          : const SizedBox(),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          )
                        : Center(
                            child: Column(
                            children: [
                              SvgPicture.asset(icNoResult,
                                  height: 240, width: 240),
                              const SizedBox(height: 8.0),
                              CommonText(
                                  title:
                                      "No results found for '${searchController.text}'",
                                  fontSize: 16.0,
                                  color: Colors.black54)
                            ],
                          ));
                  } else if (state is NowPlayingError) {
                    return Text(state.errorMessage);
                  } else {
                    return const Center(child: CupertinoActivityIndicator());
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
              BlocBuilder<top.TopRatedBloc, top.TopRatedState>(
                builder: (context, state) {
                  if (state is top.TopRatedSuccess) {
                    return state.filterTopRatedList.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.filterTopRatedList.length,
                            itemBuilder: (ctx, index) {
                              TopRated movie = state.filterTopRatedList[index];
                              return TopRatedView(movie: movie);
                            })
                        : Center(
                            child: Column(
                            children: [
                              SvgPicture.asset(icNoResult,
                                  height: 240, width: 240),
                              const SizedBox(height: 8.0),
                              CommonText(
                                  title:
                                      "No results found for '${searchController.text}'",
                                  fontSize: 16.0,
                                  color: Colors.black54)
                            ],
                          ));
                  } else if (state is top.TopRatedError) {
                    return Text(state.errorMessage);
                  } else {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
