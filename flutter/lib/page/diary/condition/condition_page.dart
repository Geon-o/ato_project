import 'package:ato/component_form/diary_form/condition_form/condition_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConditionPage extends StatefulWidget{
  const ConditionPage({Key? key}) : super(key: key);

  @override
  State<ConditionPage> createState() => _ConditionPage();
}

class _ConditionPage extends State<ConditionPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ConditionForm(),
      ),
    );
  }
}