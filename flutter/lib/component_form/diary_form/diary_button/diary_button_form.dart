import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/page/diary/diary_modify_page.dart';
import 'package:ato/page/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DiaryButtonForm extends StatefulWidget {

  var currentDiaryNo;
  var date;
  var weather;
  var condition;
  var title;
  var content;

  DiaryButtonForm({Key? key,
    required this.currentDiaryNo,
    required this.date,
    required this.weather,
    required this.condition,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  State<DiaryButtonForm> createState() => _DiaryButtonForm();
}

class _DiaryButtonForm extends State<DiaryButtonForm> {

  _requestDeleteDiary() async {
    const storage = FlutterSecureStorage();
    String? idValue = await storage.read(key: "memberId");
    int memberId = int.parse(idValue!);

    SpringDiaryApi().delete(DiaryDeleteRequest(memberId, widget.currentDiaryNo));
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            "확인⚠",
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          content: Text("정말 삭제하시겠어요?"),
          actions: [
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.white60)),
                onPressed: () => Navigator.pop(context),
                child: Text(
                  "취소",
                  style: TextStyle(color: Colors.black54),
                )),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(Colors.white60)),
                onPressed: () {
                  _requestDeleteDiary();
                  Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                },
                child: Text(
                  "확인",
                  style: TextStyle(color: Colors.black54),
                )),
          ],
          elevation: 5.0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>
                  DiaryModifyPage(
                    diaryNo: widget.currentDiaryNo,
                    date: widget.date,
                    weather: widget.weather,
                    condition: widget.condition,
                    title: widget.title,
                    content: widget.content,
                  ),));
            },
            child: Text(
              "수정",
              style: TextStyle(fontSize: 19.0, color: Colors.black),
            ),
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
          SizedBox(width: 50,),
          OutlinedButton(
            onPressed: () {
              _showDialog(context);
            },
            child: Text(
              "삭제",
              style: TextStyle(fontSize: 19.0, color: Colors.black),
            ),
            style: OutlinedButton.styleFrom(
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                )
            ),
          ),
        ],
      ) ,
    );
  }
}