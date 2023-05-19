import 'package:ato/component_form/diary_form/condition_form/condition_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConditionForm extends StatefulWidget{
  const ConditionForm({Key? key}) : super(key: key);

  @override
  State<ConditionForm> createState() => _ConditionForm();
}

class _ConditionForm extends State<ConditionForm>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Text("오늘 하루는 어땠어?", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21.0,
                  color: Colors.blueGrey
              ),),
            SizedBox(height: 20,),
            ConditionButton(condition_state: "좋아", condition_image_index: 0),
            SizedBox(height: 30,),
            ConditionButton(condition_state: "그냥그래", condition_image_index: 1),
            SizedBox(height: 30,),
            ConditionButton(condition_state: "별루", condition_image_index: 2),
          ],
        ),
      ),
    );
  }
}