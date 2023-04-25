import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather/weather.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weather_app/MyHomePage.dart';

import '/PermissionScreen.dart';
import 'main.dart';

final weatherApiKey = dotenv.env['WEATHER_API_KEY'];

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
                  image: AssetImage('icons/cloud-sun.png'),
                ),
                const Padding(padding: EdgeInsets.only(top: 15.0)),
                Text(
                  Strings.appTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 42.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 5.0)),
                Text(
                  'Aplikacja do nomonitoring \n czystości powietrza',
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
            bottom: 35,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                'Pobieram dane...',
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    if (permissionDenied()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const PermissionScreen()));
    } else {
      // SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
      executeOnceAfterBuild();
      // });
    }
  }

  bool permissionDenied() {
    return false;
  }

  Future executeOnceAfterBuild() async {
    WeatherFactory wf =
        WeatherFactory(weatherApiKey.toString(), language: Language.POLISH);
    Weather w = await wf.currentWeatherByCityName('Warszawa');
    log(w.toJson().toString());
    Navigator.push((context),
        MaterialPageRoute(builder: (context) => MyHomePage(weather: w)));
  }
}
