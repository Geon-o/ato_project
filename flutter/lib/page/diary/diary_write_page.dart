import 'package:ato/component_form/diary_form/diary_info_topbar_form.dart';
import 'package:ato/component_form/diary_form/diary_write_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryWritePage extends StatefulWidget {
  var condition;

  DiaryWritePage({Key? key, required this.condition}) : super(key: key);

  @override
  State<DiaryWritePage> createState() => _DiaryWritePage();
}

class _DiaryWritePage extends State<DiaryWritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: DiaryWriteForm(userCondition: widget.condition,
          )
      )
    );
  }
}
