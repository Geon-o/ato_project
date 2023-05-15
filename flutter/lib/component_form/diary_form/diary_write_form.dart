import 'package:ato/component_form/diary_form/diary_info_topbar_form.dart';
import 'package:ato/component_form/diary_form/diary_textarea_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryWriteForm extends StatefulWidget {
  var userCondition;
  DiaryWriteForm({Key? key, required this.userCondition}) : super(key: key);

  @override
  State<DiaryWriteForm> createState() => _DiaryWriteForm();
}

class _DiaryWriteForm extends State<DiaryWriteForm>{

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 80, 20, 80),
      height: MediaQuery.of(context).size.height / 1.25
      ,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(width: 2.6, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(18.4))),
      child: Column(
        children: [
          DiaryInfoTopBarForm(condition: widget.userCondition),
          Divider(thickness: 3, color: Colors.black,),
          DiaryTextAreaForm()
        ],
      ),
    );
  }
}