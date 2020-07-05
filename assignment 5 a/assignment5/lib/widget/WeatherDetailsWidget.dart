import 'package:assignment4/model/City.dart';
import 'package:assignment4/model/WeatherResponse.dart';
import 'package:assignment4/service/WeatherDataService.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:assignment4/Themes.dart';
import 'package:http/http.dart' as http;
const String DEFAULT_DROPDOWN_VALUE = "Select City";


WeatherDataService weatherDataService;

class WeatherDetailsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    weatherDataService = WeatherDataService();
    return WeatherDetailsState();
  }
}

class WeatherDetailsState extends State<WeatherDetailsWidget> {
  WeatherResponse weatherResponse = WeatherResponse();
  String dropDownValue = DEFAULT_DROPDOWN_VALUE;

  ProgressDialog pr;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather Prediction App", textDirection: TextDirection.ltr),
        ),
        body: Stack(
          children: <Widget>[citySelectionWidget(), weatherDetailsWidget()],
        ));
  }

  Widget citySelectionWidget() {
    return
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      DropdownButton<String>(
        value: dropDownValue,
        icon: Icon(Icons.keyboard_arrow_down),
        iconSize: 16,
        elevation: 16,
        style: TextStyle(color: Colors.black),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (value) => onDropDownValueChanged(value),
        items: City.getCityNameList(weatherDataService.cityList)
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                child: Text(
                  value,
                  style: TextStyle(fontSize: 18),
                ),
              ));
        }).toList(),
      )
    ]);
  }

  Widget weatherDetailsWidget() {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(
                  weatherResponse.temperature!="" ?  weatherResponse.temperature + ' °F' : "-",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherResponse.minTemp!="" &&  weatherResponse.maxTemp!=""
                    ? weatherResponse.minTemp + '°F ' + '- ' + weatherResponse.maxTemp + '°F' : "",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20, color: Colors.black87))),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherResponse.description,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherResponse.city,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black87))),
            Padding(
                padding: EdgeInsets.all(4),
                child: Text(weatherResponse.country,
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.black87))),
          ],
        ));
  }

  void onDropDownValueChanged(String dropdownValue) {
    setState(() {
      dropDownValue = dropdownValue;
    });

    var cityItem = City.getCityItemFromName(weatherDataService.cityList, dropdownValue);
    http.Client client = Client();
    if (cityItem != null) {
      showProgressDialog();
      var response = loadCityDetails(cityItem,client);
      response.then((weatherData) => setWeatherDetails(weatherData),
          onError: (error) => {
//        setWeatherDetails(WeatherResponse())
          showError()
      });
    } else {
      setWeatherDetails(WeatherResponse());
    }
  }

  void setWeatherDetails(WeatherResponse weatherResponseBody) {
    setState(() {
      hideProgressDialog();
      weatherResponse = weatherResponseBody;
    });
  }

  void showError() {
    WeatherResponse weatherResponseError = new WeatherResponse();
    weatherResponseError.description = "Error occurred while fetching temperature";
    setState(() {
      weatherResponse = weatherResponseError;
    });
  }

  void showProgressDialog() {
    if (pr == null) {
      pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: true);
    }

    pr.show();
  }

  void hideProgressDialog() {
    if (pr != null) {
      pr.hide();
    }
  }
}
