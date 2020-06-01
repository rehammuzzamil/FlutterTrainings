
const String DEFAULT_VALUE = "";

class WeatherResponse{
  String temperature;
  String minTemp;
  String maxTemp;
  String description ;
  String city;
  String country;

  WeatherResponse(){
    temperature = DEFAULT_VALUE;
    minTemp = DEFAULT_VALUE;
    maxTemp = DEFAULT_VALUE;
    description = DEFAULT_VALUE;
    city = DEFAULT_VALUE;
    country = DEFAULT_VALUE;
  }

  WeatherResponse.fromJson(Map<String, dynamic> json)
      : temperature = (json['main']['temp']).toString(),
        minTemp = (json['main']['temp_min']).toString(),
        maxTemp = (json['main']['temp_max']).toString(),
        description = json['weather'][0]['description'],
        city = json['name'],
        country = json['sys']['country'];

//  WeatherData.weatherDetails(this.temperature, this.temperatureRange,
//      this.status,
//      this.cityName, this.country);


}