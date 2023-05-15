import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryTextAreaForm extends StatefulWidget {
  const DiaryTextAreaForm({Key? key}) : super(key: key);

  @override
  State<DiaryTextAreaForm> createState() => _DiaryTextAreaFrom();
}

class _DiaryTextAreaFrom extends State<DiaryTextAreaForm> {
  Future<dynamic> _showDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text("확인⚠", style: TextStyle(
                color: Colors.lightBlueAccent
              ),),
              content: Text("정말 취소하시겠어요?"),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white60)
                  ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "취소",
                      style: TextStyle(color: Colors.black54),
                    )),
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white60)
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.of(context).pop();
                    },
                    child: Text("확인",
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
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
              style: TextStyle(fontSize: 30.0),
              decoration: InputDecoration(
                  hintText: "제목",
                  hintStyle: TextStyle(fontSize: 30.0),
                  border: InputBorder.none),
            ),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
          ),
          Container(
            width: 500.0,
            margin: EdgeInsets.fromLTRB(15, 0, 10, 10),
            child: TextField(
              maxLines: 16,
              style: TextStyle(fontSize: 17.5),
              decoration: InputDecoration(
                  hintText: "내용",
                  hintStyle: TextStyle(fontSize: 17.5),
                  border: InputBorder.none),
            ),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
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
                  onPressed: () {},
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
    );
  }
}
