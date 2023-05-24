import 'package:ato/api/spring_diary_api.dart';
import 'package:ato/component_form/main_page_form/show_diary_form.dart';
import 'package:ato/utility/diary/diary_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainPageForm extends StatefulWidget {
  const MainPageForm({Key? key}) : super(key: key);

  @override
  State<MainPageForm> createState() => _MainPageForm();
}

class _MainPageForm extends State<MainPageForm> {
  int memberId = 0;
  var diary_lists;
  bool isLoading = true;
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    requestDiaryList();
  }

  requestDiaryList() async {
    const storage = FlutterSecureStorage();
    String? idValue = await storage.read(key: "memberId");
    memberId = int.parse(idValue!);

    List<RequestDiaryInfo> diaryList =
        await SpringDiaryApi().diaryList(memberId, 5);

    if (mounted) {
      diary_list.clear();

      for (var i = 0; i < diaryList.length; i++) {
        diary_list.add(DiaryList(
            title: diaryList[i].title,
            content: diaryList[i].content,
            conditionStatus: diaryList[i].conditionStatus,
            weather: diaryList[i].weather,
            date: diaryList[i].date,
            diaryNo: diaryList[i].diaryNo));

        print(diary_list[i].diaryNo);
      }
      diary_lists = diary_list;

      setState(() {
        print("1" + diary_list.toString());
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.lightBlue.shade50,
          child: Center(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  ShowDiaryForm(
                    diaryList: diary_list,
                    isLoading: isLoading,
                    memberId: memberId,
                    scrollController: _scrollController,
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
