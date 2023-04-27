import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather.dart';
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

    var lat = 51.761090;
    var lon = 19.486489;
    var keyword = 'geo:$lat;$lon';
    String _endpoint = 'https://api.waqi.info/feed/';
    var key = dotenv.env['AIR_API_KEY'];
    String url = '$_endpoint$keyword/?token=$key';

    http.Response response = await http.get(Uri.parse(url));
    log(response.body.toString());

    Map<String, dynamic> jsonBody = json.decode(response.body);
    AirQuality aq = AirQuality(jsonBody);

    Navigator.push(
        (context),
        MaterialPageRoute(
            builder: (context) => MyHomePage(weather: w, air: aq)));
  }
}

class AirQuality {
  bool isGood = false;
  bool isBad = false;
  String quality = '';
  String advice = '';
  int aqi = 0;
  int pm25 = 0;
  int pm10 = 0;
  String station = '';

  AirQuality(Map<String, dynamic> jsonBody) {
    aqi = int.tryParse(jsonBody['data']['aqi'].toString()) ?? -1;
    pm25 = int.tryParse(jsonBody['data']['iaqi']['pm25'].toString()) ?? -1;
    pm10 = int.tryParse(jsonBody['data']['iaqi']['pm10'].toString()) ?? -1;
    station = jsonBody['data']['city']['name'].toString();
    setupLevel(aqi);
  }

  void setupLevel(int aqi) {
    if (aqi <= 100) {
      quality = 'Bardzo dobra';
      advice = 'Skorzystaj z dobrego poweitrza i wyjdź na spacer';
      isGood = true;
    } else if (aqi <= 150) {
      quality = 'Nie za dobra';
      advice = 'Jeżeli możesz zostań w domu, załatwiaj sprawy online';
      isBad = true;
    } else {
      quality = 'Bardzo zła!';
      advice = 'Zdecydowanie zostań w domu i załatwiaj sprawy online!';
    }
  }
}
