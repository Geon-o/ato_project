import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryModifyForm extends StatefulWidget{
  var date;
  var weather;
  var condition;
  var title;
  var content;

  final titleController;
  final contentController;

  DiaryModifyForm({Key? key,
    required this.date,
    required this.weather,
    required this.condition,
    required this.title,
    required this.content,

    this.titleController,
    this.contentController
  }) : super(key: key);

  @override
  State<DiaryModifyForm> createState() => _DiaryModifyForm();
}

class _DiaryModifyForm extends State<DiaryModifyForm>{


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var contentTextAreaSize = 0;

    setState(() {
      if(size <= 695) {
        debugPrint("잘됨");
        contentTextAreaSize = 10;
      } else {
        debugPrint("잘안됨");
        contentTextAreaSize = 16;
      }
    });

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Column(
                  children: [
                    Text(widget.date.substring(0,4),
                    style: TextStyle(
                      fontSize: 22.4, fontWeight: FontWeight.bold
                    ),),
                    Text(widget.date.substring(5,10))
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/weather_images/${widget.weather}'
                    )
                  )
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: 15),
                width: 55.0,
                height: 55.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/condition_image/${widget.condition}'
                    )
                  )
                ),
              )
            ],
          ),
          Divider(thickness: 3, color: Colors.black,),
          Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: widget.titleController,
                    style: TextStyle(fontSize: 30.0),
                    decoration: InputDecoration(
                        hintText: widget.title,
                        hintStyle: TextStyle(fontSize: 30.0, color: Colors.black),
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
                    controller: widget.contentController,
                    maxLines: contentTextAreaSize,
                    style: TextStyle(fontSize: 17.5),
                    decoration: InputDecoration(
                        hintText: widget.content,
                        hintStyle: TextStyle(fontSize: 17.5, color: Colors.black),
                        border: InputBorder.none),
                  ),
                  decoration: BoxDecoration(
                      border:
                      Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}