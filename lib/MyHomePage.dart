import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

import '/AirScreen.dart';
import '/WeatherScreen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.weather});

  final Weather? weather;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var currentIndex = 1;
  var screens;

  @override
  void initState() {
    screens = <Widget>[
      const AirScreen(),
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
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.masks_outlined), label: 'Powietrze'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cloud_outlined), label: 'Pogoda'),
        ],
      ),
    );
  }
}
