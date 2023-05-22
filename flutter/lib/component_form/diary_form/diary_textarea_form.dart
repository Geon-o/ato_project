import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryTextAreaForm extends StatefulWidget {
  const DiaryTextAreaForm({Key? key,
    this.titleController,
    this.contentController
  }) : super(key: key);

  final titleController;
  final contentController;

  @override
  State<DiaryTextAreaForm> createState() => _DiaryTextAreaFrom();
}

class _DiaryTextAreaFrom extends State<DiaryTextAreaForm> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.height;
    var contentTextAreaSize = 0;

    if(size <= 695) {
      contentTextAreaSize = 10;
    } else {
      contentTextAreaSize = 16;
    }

    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
            child: TextField(
              controller: widget.titleController,
              style: TextStyle(fontSize: 30.0),
              decoration: InputDecoration(
                  hintText: "제목",
                  hintStyle: TextStyle(fontSize: 30.0),
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
                  hintText: "내용",
                  hintStyle: TextStyle(fontSize: 17.5),
                  border: InputBorder.none),
            ),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
          ),
        ],
      ),
    );
  }
}
