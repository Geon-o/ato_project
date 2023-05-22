import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/component_form/diary_form/diary_delete_form.dart';
import 'package:ato/page/diary/condition/condition_page.dart';
import 'package:ato/page/diary/diary_read_page.dart';
import 'package:ato/utility/diary/diary_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ShowDiaryForm extends StatefulWidget {
  const ShowDiaryForm({Key? key}) : super(key: key);

  @override
  State<ShowDiaryForm> createState() => _DiaryForm();
}

class _DiaryForm extends State<ShowDiaryForm> {

  var diary_lists;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    requestDiaryList();
  }

  requestDiaryList() async {
    const storage = FlutterSecureStorage();
    String? idValue = await storage.read(key: "memberId");
    int memberId = int.parse(idValue!);

    List<RequestDiaryInfo> diaryList =
        await SpringDiaryApi().diaryList(memberId, 5);
    diary_list.clear();

    for (var i = 0; i < diaryList.length; i++) {
      diary_list.add(DiaryList(
          title: diaryList[i].title,
          content: diaryList[i].content,
          conditionStatus: diaryList[i].conditionStatus,
          weather: diaryList[i].weather,
          date: diaryList[i].date,
          diaryNo: diaryList[i].diaryNo));
    }
    diary_lists = diary_list;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : diary_lists != null && diary_lists.isNotEmpty
            ? ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: diary_lists.length,
                itemBuilder: (BuildContext context, int index) {
                  var weatherState = diary_lists[index].weather;
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

                  return Container(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: GestureDetector(
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          diary_lists[index]
                                              .date
                                              .substring(0, 4),
                                          style: TextStyle(
                                              fontSize: 22.4,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(diary_lists[index]
                                            .date
                                            .substring(5, 10)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/weather_images/${weatherImg}'))),
                                    ),
                                    Spacer(),
                                    Container(
                                      height: 55.0,
                                      width: 55.0,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/condition_image/${diary_lists[index].conditionStatus}'))),
                                    ),
                                    DiaryDeleteForm(currentDiaryNo: diary_lists[index].diaryNo,)
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Container(
                                margin: EdgeInsets.all(10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  diary_lists[index].title,
                                  style: TextStyle(fontSize: 25.0),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                padding: EdgeInsets.fromLTRB(10,0,5,0),
                                child: Text(
                                  diary_lists[index].content,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DiaryReadPage(currentDiaryNo: diary_lists[index].diaryNo)));
                      },
                    ),
                  );
                })
            : Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.0),
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/mainpage_image/notebook.png'))),
                    ),
                    Text(
                      "작성된 일기가 없어요",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0,),
                    Text("일기를 작성해주세요!",
                    style: TextStyle(
                      fontSize: 17.5
                    ),)
                  ],
                ),
              );
  }
}
