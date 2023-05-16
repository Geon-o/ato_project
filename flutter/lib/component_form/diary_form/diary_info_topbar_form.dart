import 'package:ato/api/weather_data.dart';
import 'package:ato/component_form/diary_form/current_position.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiaryInfoTopBarForm extends StatefulWidget {
  DiaryInfoTopBarForm({Key? key,
    required this.condition,
    required this.dateController,
    required this.weatherController,
    required this.conditionController,
  }) : super(key: key);

  var condition;
  final TextEditingController dateController;
  final TextEditingController weatherController;
  final TextEditingController conditionController;

  @override
  State<DiaryInfoTopBarForm> createState() => _DiaryWriteForm();
}

class _DiaryWriteForm extends State<DiaryInfoTopBarForm> {
  static DateTime now = DateTime.now();
  static DateFormat formatConversion = DateFormat('yyyy.MM.dd');
  String conversionDate = formatConversion.format(now);

  double latitude = 0;
  double longitude = 0;

  static String weatherImg = '';

  Future<String> _getWeatherData() async {
    CurrentPosition location = CurrentPosition();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    WeatherDataApi weatherDataApi = WeatherDataApi();
    Map<String, dynamic> weatherData = await weatherDataApi.getWeatherData(
        lat: latitude.toString(), lon: longitude.toString());

    String weather = weatherData['weather'][0]['main'];

    switch (weather) {
      case 'Thunderstorm':
        weatherImg = 'thunderstrom.png';
        break;
      case 'Drizzle':
        weatherImg = 'rain.png';
        break;
      case 'Rain':
        weatherImg = 'rain.png';
        break;
      case 'Snow':
        weatherImg = 'snow.png';
        break;
      case 'Atomsphere':
        weatherImg = 'atomshpere.png';
        break;
      case 'Clear':
        weatherImg = 'clear.png';
        break;
      case 'Clouds':
        weatherImg = 'cloud.png';
        break;
    }

    return weather;
  }

  @override
  void initState(){
    super.initState();
    widget.dateController.text = conversionDate;
    _getWeatherData().then((weather) {
      widget.weatherController.text = weather;
    });
    widget.conditionController.text = widget.condition;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: Column(
              children: [
                Text(
                  conversionDate.substring(0,4),
                  style: TextStyle(fontSize: 22.4, fontWeight: FontWeight.bold),
                ),
                Text(conversionDate.substring(5,10)),
              ],
            ),
          ),
          Container(
            child: FutureBuilder<String>(
              future: _getWeatherData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/weather_images/${weatherImg}'))),
                    );
                  } else {
                    return Center(
                      child: Text('날씨정보없음'),
                    );
                  }
                } else {
                  return Container(
                      margin: EdgeInsets.fromLTRB(15, 5, 5, 5),
                      height: 15.0,
                      width: 15.0,
                      child: Center(
                        child: CircularProgressIndicator(
                            color: Colors.lightBlueAccent),
                      ));
                }
              },
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
            height: 55.0,
            width: 55.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'assets/condition_image/${widget.condition}'))),
          )
        ],
      ),
    );
  }
}
