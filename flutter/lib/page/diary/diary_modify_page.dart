import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/component_form/diary_form/diary_modify_form.dart';
import 'package:ato/component_form/diary_form/diary_write_form.dart';
import 'package:ato/page/diary/diary_read_page.dart';
import 'package:ato/page/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryModifyPage extends StatefulWidget {
  var diaryNo;
  var date;
  var weather;
  var condition;
  var title;
  var content;

  DiaryModifyPage(
      {Key? key,
      required this.diaryNo,
      required this.date,
      required this.weather,
      required this.condition,
      required this.title,
      required this.content})
      : super(key: key);

  @override
  State<DiaryModifyPage> createState() => _DiaryModifyPage();
}

class _DiaryModifyPage extends State<DiaryModifyPage> {
  final _fromKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void _showSaveDiarySnackBar(BuildContext context, String snackBarText) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
        SnackBar(
          margin: EdgeInsets.only(bottom: 65.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
          ),
          elevation: 0.0,
          backgroundColor: Colors.grey.withOpacity(0.3),
          content: Text(snackBarText, style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
              textAlign: TextAlign.center),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 3),
        )
    );
  }

  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(
            "확인⚠",
            style: TextStyle(color: Colors.lightBlueAccent),
          ),
          content: Text("정말 취소하시겠어요?"),
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
                  Navigator.pop(context);
                  Navigator.of(context).pop();
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 80, 20, 80),
          height: MediaQuery.of(context).size.height / 1.25,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              border: Border.all(width: 2.6, color: Colors.black),
              borderRadius: BorderRadius.all(Radius.circular(18.4))),
          child: Form(
            key: _fromKey,
            child: Column(
              children: [
                DiaryModifyForm(
                  date: widget.date,
                  weather: widget.weather,
                  condition: widget.condition,
                  title: widget.title,
                  content: widget.content,
                  titleController: titleController,
                  contentController: contentController,
                ),
                Container(
                  padding: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            _showDialog(context);
                          },
                          child: Text(
                            "취소",
                            style: TextStyle(
                              fontSize: 19.0, color: Colors.black),
                          ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                      ),
                      SizedBox(width: 50,),
                      OutlinedButton(
                          onPressed: () {
                            var request = SpringDiaryApi().modify(DiaryModifyRequest(
                            widget.diaryNo,
                            titleController.text,
                            contentController.text
                            ));

                            request.then((value) {
                              if (value.success == true) {
                                _showSaveDiarySnackBar(context, "수정하였습니다.");
                                Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                              }
                              if (value.success == false){
                                _showSaveDiarySnackBar(context, "시스템 오류로 수정되지 않았습니다.");
                              }
                            });
                          },
                          child: Text(
                            "저장",
                            style: TextStyle(fontSize: 19.0, color: Colors.black),
                          ),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
