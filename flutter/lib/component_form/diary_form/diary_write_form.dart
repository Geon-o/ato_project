import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/component_form/diary_form/diary_info_topbar_form.dart';
import 'package:ato/component_form/diary_form/diary_textarea_form.dart';
import 'package:ato/page/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DiaryWriteForm extends StatefulWidget {
  var userCondition;

  DiaryWriteForm({Key? key, required this.userCondition}) : super(key: key);

  @override
  State<DiaryWriteForm> createState() => _DiaryWriteForm();
}

class _DiaryWriteForm extends State<DiaryWriteForm> {
  final _fromKey = GlobalKey<FormState>();
  final dateController = TextEditingController();
  final weatherController = TextEditingController();
  final conditionController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  String? idValue;

  @override
  void dispose() {
    dateController.dispose();
    weatherController.dispose();
    conditionController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  void initState(){
    super.initState();

    _getMemberId();
  }

  void _getMemberId() async {
    const storage = FlutterSecureStorage();
    idValue = await storage.read(key: "memberId");
  }

  void _showSaveDiarySnackBar(BuildContext context, String snackBarText) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
      scaffoldMessenger.showSnackBar(
        SnackBar(
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
          behavior: SnackBarBehavior.fixed,
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
    return Container(
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
            DiaryInfoTopBarForm(
              condition: widget.userCondition,
              dateController: dateController,
              weatherController: weatherController,
              conditionController: conditionController,
            ),
            Divider(
              thickness: 3,
              color: Colors.black,
            ),
            DiaryTextAreaForm(
              titleController: titleController,
              contentController: contentController,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _showDialog(context);
                    },
                    child: Text(
                      "취소",
                      style: TextStyle(fontSize: 19.0, color: Colors.black),
                    ),
                    style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ),
                  SizedBox(width: 50),
                  OutlinedButton(
                    onPressed: () {
                      var responseStatus = SpringDiaryApi().register(DiaryRegisterRequest(
                          idValue!,
                          dateController.text,
                          weatherController.text,
                          conditionController.text,
                          titleController.text,
                          contentController.text));

                      responseStatus.then((value) {
                        if(value.success == true) {
                          _showSaveDiarySnackBar(context, "일기가 잘 저장되었습니다.");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                        }
                        if (value.success == false) {
                          _showSaveDiarySnackBar(context, "시스템 오류로 저장되지 않았습니다.");
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
                            borderRadius: BorderRadius.circular(10))),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
