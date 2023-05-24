import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/component_form/diary_form/diary_delete_form.dart';
import 'package:ato/page/diary/diary_read_page.dart';
import 'package:ato/utility/diary/diary_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowDiaryForm extends StatefulWidget {
  final List<DiaryList> diaryList;
  final bool isLoading;
  final int memberId;
  final ScrollController scrollController;

  ShowDiaryForm(
      {Key? key,
      required this.diaryList,
      required this.isLoading,
      required this.memberId,
        required this.scrollController
      })
      : super(key: key);

  @override
  State<ShowDiaryForm> createState() => _DiaryForm();
}

class _DiaryForm extends State<ShowDiaryForm> {

  late ScrollController _scrollController;
  bool loadingValue = false;

  @override
  void initState() {
    super.initState();

    _scrollController = widget.scrollController;
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _scrollController.addListener(_scrollListener);
    });
  }

  _scrollListener() async {
    if (!_scrollController.hasClients) return;

    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      if (!mounted) return;

      setState(() {
        loadingValue = true;
      });

      var diaryCount = widget.diaryList.length;
      print(widget.diaryList[diaryCount - 1].diaryNo);

      List<RequestDiaryInfo> nextDiaryList = await SpringDiaryApi().nextDiary(
          widget.memberId, widget.diaryList[diaryCount - 1].diaryNo, 5);

      for (var i = 0; i < nextDiaryList.length; i++) {
        widget.diaryList.add(DiaryList(
            title: nextDiaryList[i].title,
            content: nextDiaryList[i].content,
            conditionStatus: nextDiaryList[i].conditionStatus,
            weather: nextDiaryList[i].weather,
            date: nextDiaryList[i].date,
            diaryNo: nextDiaryList[i].diaryNo));
      }

      Future.delayed(Duration(seconds: 2), () {
        if (!mounted) return;

        setState(() {
          loadingValue = false;
        });
      });
    }
  }
  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : widget.diaryList != null && widget.diaryList.isNotEmpty
            ? Column(children: [
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.diaryList.length,
                    itemBuilder: (BuildContext context, int index) {
                      var weatherState = widget.diaryList[index].weather;
                      String weatherImg = "";

                      switch (weatherState) {
                        case 'Thunderstorm':
                          weatherImg = 'thunderstrom.png';
                          break;
                        case 'Drizzle':
                          weatherImg = 'rain.png';
                          break;
                        case 'Rain':
                          weatherImg = 'rain.png';
                          break;
                        case 'Snow':
                          weatherImg = 'snow.png';
                          break;
                        case 'Atomsphere':
                          weatherImg = 'atomshpere.png';
                          break;
                        case 'Clear':
                          weatherImg = 'clear.png';
                          break;
                        case 'Clouds':
                          weatherImg = 'cloud.png';
                          break;
                      }

                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: GestureDetector(
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              widget.diaryList[index].date
                                                  .substring(0, 4),
                                              style: TextStyle(
                                                  fontSize: 22.4,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(widget.diaryList[index].date
                                                .substring(5, 10)),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/weather_images/${weatherImg}'))),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: 55.0,
                                          width: 55.0,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/condition_image/${widget.diaryList[index].conditionStatus}'))),
                                        ),
                                        DiaryDeleteForm(
                                          currentDiaryNo:
                                              widget.diaryList[index].diaryNo,
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(10.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      widget.diaryList[index].title,
                                      style: TextStyle(fontSize: 25.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                    padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
                                    child: Text(
                                      widget.diaryList[index].content,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: TextStyle(fontSize: 15.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DiaryReadPage(
                                        currentDiaryNo:
                                            widget.diaryList[index].diaryNo)));
                          },
                        ),
                      );
                    }),
                if (loadingValue)
                  Container(
                    child: CircularProgressIndicator(),
                  )
              ])
            : Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20.0),
                      width: 145,
                      height: 145,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'assets/mainpage_image/notebook.png'))),
                    ),
                    Text(
                      "작성된 일기가 없어요",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "일기를 작성해주세요!",
                      style: TextStyle(fontSize: 17.5),
                    )
                  ],
                ),
              );
  }
}
