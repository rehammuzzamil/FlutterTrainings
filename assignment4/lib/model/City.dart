class City{
  String cityName;

  City(this.cityName);

  static List<String> getCityNameList(List<City> cities){
    var cityName = List<String>();
    cities.forEach((city) => cityName.add(city.cityName));

    return cityName;
  }

  static City getCityItemFromName(List<City> cities, String cityName){
    return cities.firstWhere((city) => city.cityName == cityName);
  }


}