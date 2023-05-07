# Weather and Air Quality App
This app can take your current GPS location and show the weather and air quality.

Application built on the basis of the course "Flutter and Dart - creating mobile applications in practice" by Arkadiusz Wrzos

## Application Details:

- Architecture: [FLutter SDK](https://docs.flutter.dev/)
- API: [WeatherAPI](https://openweathermap.org/) and [AirQualityAPI](https://aqicn.org/api/)
- Platform: Android

## Features
- Sync with current location
- WeatherScreen shows the current wind speed, cloud status, amount of rain, temperature, barometric pressure
- AirScreen shows the measurement station, particulate matter PM2,5 and PM10

## How to Run

1. Create an account at [WeatherAPI](https://www.weatherapi.com).
2. Create an account at [AirQualityAPI](https://aqicn.org/api/).
3. Then get your API keys
4. Clone the repo
   ```sh
   git clone https://github.com/krisdev88/WeatherApp.git
   ```
5. Install all the packages by typing
   ```sh
   flutter pub get
   ```
6. Create an .env file in the root folder of the project

7. Navigate to **lib/.env** and paste your API keys to the relevant variables
   ```
   WEATHER_API_KEY=Paste Your WeatherAPI Key Here
   AIR_API_KEY=Paste Your AirAPI Key Here
   ```
8. Run the app using flutter run

## License

Distributed under the MIT License.
