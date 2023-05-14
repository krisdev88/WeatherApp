import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/SplashScreen.dart';

import 'main.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({super.key});

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  Future<void> navigateAfterPermissionScreen() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if ((permission == LocationPermission.always ||
            permission == LocationPermission.whileInUse) &&
        context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                color: Color(0xffffffff),
                gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.centerLeft,
                  colors: [Color(0xff6671e5), Color(0xff4852d9)],
                )),
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage('icons/hand-wave.png'),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  'Hejka',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  'Aplikacja ${Strings.appTitle} potrzebuje\ndo działania przybliżonej lokalizacji urządzenia',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 15,
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.only(top: 12.0, bottom: 12.0),
                    ),
                  ),
                  onPressed: navigateAfterPermissionScreen,
                  child: const Text(
                    'Zgoda!',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
