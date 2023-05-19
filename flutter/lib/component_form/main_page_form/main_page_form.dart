import 'package:ato/component_form/main_page_form/show_diary_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPageForm extends StatefulWidget {
  const MainPageForm({Key? key}) : super(key: key);

  @override
  State<MainPageForm> createState() => _MainPageForm();
}

class _MainPageForm extends State<MainPageForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.lightBlue.shade50,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  ShowDiaryForm(),
                ],
              ),
            ),
          )),
    );
  }
}
