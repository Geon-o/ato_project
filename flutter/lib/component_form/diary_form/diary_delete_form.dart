import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/page/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DiaryDeleteForm extends StatefulWidget {
  var currentDiaryNo;

  DiaryDeleteForm({Key? key, required this.currentDiaryNo}) : super(key: key);

  @override
  State<DiaryDeleteForm> createState() => _DiaryDeleteForm();
}

class _DiaryDeleteForm extends State<DiaryDeleteForm> {

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
                  setState(() {
                    _requestDeleteDiary();
                  });
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
    return IconButton(
        onPressed: () {
          _showDialog(context);
        },
        icon: Icon(
          Icons.close,
          size: 25.0,
        ));
  }
}