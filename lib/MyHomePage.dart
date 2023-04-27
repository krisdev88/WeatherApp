import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/SplashScreen.dart';

import '/AirScreen.dart';
import '/WeatherScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.weather, this.air});

  final Weather? weather;
  final AirQuality? air;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentIndex = 0;
  var screens;

  @override
  void initState() {
    screens = <Widget>[
      AirScreen(air: widget.air),
      WeatherScreen(weather: widget.weather),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black45,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 35,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('icons/house.png'),
            label: 'Powietrze',
            activeIcon: Image.asset('icons/house-checked.png'),
          ),
          BottomNavigationBarItem(
            icon: Image.asset('icons/cloud.png'),
            label: 'Pogoda',
            activeIcon: Image.asset('icons/cloud-checked.png'),
          ),
        ],
      ),
    );
  }
}
