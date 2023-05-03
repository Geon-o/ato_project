import 'package:ato/test/test_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiaryForm extends StatefulWidget {
  const DiaryForm({Key? key}) : super(key: key);

  @override
  State<DiaryForm> createState() => _DiaryForm();
}

class _DiaryForm extends State<DiaryForm> {
  List<Object> testList = [
    {"title": "제목1", "content": "내용1"},
    {"title": "제목1", "content": "내용1"},
    {"title": "제목1", "content": "내용1"},
  ];


  @override
  Widget build(BuildContext context) {
    return testList.isNotEmpty ? ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: testList.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: GestureDetector(
              child: Card(
                shape:
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  height: 480,
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Text("23.05.03"),
                                  Text("날씨 좋음"),
                                ],
                              ),
                            ),
                            Container(
                              child: Text("배터리 3칸"),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 0.0,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                      Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/test/spring boot.png',),fit: BoxFit.fill)),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "제목",
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                        child: Text(
                          "내용이 들어갈 자리인데 이런저런 애기 이렇궁 저렇궁 이런저런 이야기가 왔다갔다하고 뭐 저런이야기 이런이야기 다들어감",
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TestPage()));
              },
            ),
          );
        }
    ) : Container(
      height: MediaQuery
          .of(context)
          .size
          .height,
      width: MediaQuery
          .of(context)
          .size
          .width,
      child: Center(
        child: Text(
            "선물을 남겨보세요!"
        ),
      ),
    );
  }
}
