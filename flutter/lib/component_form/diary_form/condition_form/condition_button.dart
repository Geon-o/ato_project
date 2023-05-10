import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConditionButton extends StatefulWidget {
  var condition_state;
  var condition_image_index;

  ConditionButton(
      {Key? key,
        required this.condition_state,
        required this.condition_image_index,
      })
      : super(key: key);

  @override
  State<ConditionButton> createState() => _ConditionButton();
}

class _ConditionButton extends State<ConditionButton> {
  List _condition_image = [
    'good_condition.png',
    'soso_condition.png',
    'bad_condition.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            IconButton(
              icon: Image.asset(
                  'assets/condition_image/${_condition_image[widget.condition_image_index]}'),
              onPressed: null,
              iconSize: 130.0,
            ),
            Text(
              "${widget.condition_state}",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,),
            )
          ],
        )
    );
  }
}
