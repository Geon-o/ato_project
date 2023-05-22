import 'package:ato/component_form/diary_form/diary_read_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryReadPage extends StatefulWidget {
  var currentDiaryNo;
  DiaryReadPage({Key? key, required this.currentDiaryNo}) : super(key: key);

  @override
  State<DiaryReadPage> createState() => _DiaryReadPage();
}

class _DiaryReadPage extends State<DiaryReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.fromLTRB(20, 30, 20, 80),
        height: MediaQuery.of(context).size.height / 1.25,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(width: 2.6, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(18.4))),
        child: Column(
          children: [
            DiaryReadForm(currentDiaryNo: widget.currentDiaryNo),
          ],
        ),
      ),
    ));
  }
}
