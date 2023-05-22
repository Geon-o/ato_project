import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/component_form/diary_form/diary_button/diary_button_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DiaryReadForm extends StatefulWidget {
  var currentDiaryNo;
  DiaryReadForm({Key? key, required this.currentDiaryNo}) : super(key: key);

  @override
  State<DiaryReadForm> createState() => _DiaryReadPage();
}

class _DiaryReadPage extends State<DiaryReadForm> {

  late Future<RequestDiaryInfo> diaryData;

  @override
  void initState() {
    super.initState();

    diaryData = SpringDiaryApi().read(widget.currentDiaryNo);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<RequestDiaryInfo>(
        future: diaryData,
        builder: (context, snapshot) {
          if (snapshot.hasData){
            RequestDiaryInfo diaryInfo = snapshot.data!;

            var weatherState = diaryInfo.weather;
            String weatherImg = "";

            switch (weatherState) {
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

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Column(
                        children: [
                          Text(
                            diaryInfo.date.substring(0,4),
                            style:
                            TextStyle(fontSize: 22.4, fontWeight: FontWeight.bold),
                          ),
                          Text(diaryInfo.date.substring(5,10))
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/weather_images/${weatherImg}'))),
                    ),
                    Spacer(),
                    Container(
                      margin: EdgeInsets.only(right: 15),
                      height: 55.0,
                      width: 55.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/condition_image/${diaryInfo.conditionStatus}'))),
                    ),
                  ],
                ),
                Divider(
                  thickness: 3,
                  color: Colors.black,
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    diaryInfo.title,
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    )),
                Container(
                  width: 500.0,
                  height: 400.0,
                  margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
                  padding: EdgeInsets.only(top: 15),
                  child: SingleChildScrollView(
                    child: Text(diaryInfo.content,
                      style: TextStyle(
                          fontSize: 17.5
                      ),),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    )),
                DiaryButtonForm(currentDiaryNo: diaryInfo.diaryNo,)
              ],
            );
          } else if (snapshot.hasError) {
            return Text("Error");
          }
          return CircularProgressIndicator();
        }
    );

  }
}
