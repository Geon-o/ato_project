import 'package:ato/component_form/app_bar/bottom_bar.dart';
import 'package:ato/component_form/main_page_form/main_page_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPage();
}

class _MainPage extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BottomBar(),
      ),
    );
  }
}