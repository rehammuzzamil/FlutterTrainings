import 'dart:convert';

import 'package:assignment4/model/City.dart';
import 'package:assignment4/model/WeatherResponse.dart';
import 'package:assignment4/widget/WeatherDetailsWidget.dart';
import 'package:http/http.dart' as http;

const String DEGREE_SYMBOL = '\u2103';
const String OPEN_WEATHER_API_KEY = "11f0da468a7b1cacf0e33336f670594b";
const String BASE_URL = "api.openweathermap.org";
const String ENDPOINT = "/data/2.5/weather";

class WeatherDataService {
  List<City> cityList = List();

  WeatherDataService() {
    initCityItems();
  }

  void initCityItems() {
    cityList.add(City(DEFAULT_DROPDOWN_VALUE));
    cityList.add(City("Karachi"));
    cityList.add(City("Lahore"));
    cityList.add(City("Islamabad"));
    cityList.add(City("Quetta"));
    cityList.add(City("Peshawar"));
  }

  Future<WeatherResponse> loadCityDetails(City city) async {
    Map<String, String> queryParam = {
      'q': city.cityName,
      'appid': OPEN_WEATHER_API_KEY
    };
    var uri = Uri.http(BASE_URL, ENDPOINT, queryParam);

    final response = await http.get(uri);
    print(response);
    if (response.statusCode == 200) {
      return WeatherResponse.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      WeatherResponse weatherResponseError = new WeatherResponse();
      weatherResponseError.description ="Error occurred while fetching temperature";
//      throw Exception('Failed to load weather details');
      return weatherResponseError;

    }
  }

}
