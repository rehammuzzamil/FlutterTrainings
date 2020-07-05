import 'package:assignment4/model/City.dart';
import 'package:assignment4/service/WeatherDataService.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:assignment4/model/WeatherResponse.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

main() {
  group('fetchPost', () {
    test('returns a Post if the http call completes successfully', () async {
      final client = MockClient();
      City city = City("Karachi");

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client.get('http://api.openweathermap.org/data/2.5/weather?q=karachi&appid=11f0da468a7b1cacf0e33336f670594b'))
          .thenAnswer((_) async => http.Response('{"coord": {"lat": 1.0, "lon": 2.0}, "main": {"temp": 20, "temp_min": 15, "temp_max": 25 }}', 200));
      expect(await loadCityDetails(city, client), isA<WeatherResponse>());
    });
  });
}