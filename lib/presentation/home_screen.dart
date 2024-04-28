import 'package:fl_wework_movies/utils/asset_utils.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    geoCode = GeoCode();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
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
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  if (address != null)
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(MdiIcons.mapMarkerOutline),
                            Text(
                              "${address!.streetAddress}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Poppins",
                                  color: Color(0xFF282933)),
                            ),
                          ]),
                          const SizedBox(height: 2.0),
                          Text(
                              "${address!.city}, ${address!.region}, ${address!.countryName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Poppins",
                                  fontSize: 12.0,
                                  color: Color(0xFF656072))),
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
                Stack(
                  children: [
                    // Container(color: Colors.yellow,child: Text("Hello")),
                    CustomPaint(
                      foregroundPainter: CustomCardPainter(context: context),
                      // painter: CurvePainterPage2()
                      // ),
                    ),
                  ],
                ),

                // CustomPaint(
                //     painter: ClipperNavbar()
                // ),
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

class CustomCardPainter extends CustomPainter {
  final BuildContext context;
  CustomCardPainter({required this.context});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.grey.withOpacity(0.3);
    paint.style = PaintingStyle.fill;

    var path = Path();

    double scaleFactor = (MediaQuery.of(context).size.width - 2 * 16)/5;

    /// Square with round edges
    // path.lineTo(20,0);
    // path.lineTo(30,0);
    // path.quadraticBezierTo(40,0, 40,10);
    // // path.lineTo(40,10);
    // path.lineTo(40,30);
    // path.quadraticBezierTo(40,40,30,40);
    // path.lineTo(40,40);
    // path.lineTo(0,40);
    // // path.lineTo(20,20);

    path.moveTo(0, 10);
    /// Basic Custom Shape
    path.lineTo(0,10);
    path.lineTo(25,10);
    path.quadraticBezierTo(30,10,30,5);
    path.lineTo(30,5);
    path.quadraticBezierTo(30,0,35,0);
    path.lineTo(65,0);
    path.quadraticBezierTo(70,0,70,5);
    path.lineTo(70,15);
    path.quadraticBezierTo(70,20,65,20);
    path.quadraticBezierTo(60,20,60,25);
    path.lineTo(60,35);
    path.quadraticBezierTo(60,40,55,40);
    path.lineTo(5,40);
    path.quadraticBezierTo(0,40,0,35);
    path.lineTo(0,15);
    path.quadraticBezierTo(0,10,5,10);
    path.lineTo(5,10);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
