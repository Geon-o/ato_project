import 'package:ato/component_form/main_page_form/diary_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageForm extends StatefulWidget{
  const MainPageForm({Key? key}) : super(key: key);

  @override
  State<MainPageForm> createState() => _MainPageForm();
}

class _MainPageForm extends State<MainPageForm>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DiaryForm(),
            ],
          ),
        )
      ),
    );
  }
}