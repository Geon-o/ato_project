import 'dart:convert';

import 'package:ato/api/ip_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SpringDiaryApi {
  Future<DiaryRegisterResponse> register(DiaryRegisterRequest request) async {
    var body = json.encode(request);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/diary/register'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    debugPrint(request.memberId);
    debugPrint(request.date);
    debugPrint(request.weather);
    debugPrint(request.condition);
    debugPrint(request.title);
    debugPrint(request.content);

    if (response.statusCode == 200) {
      debugPrint("통신성공");
      return DiaryRegisterResponse(true);
    } else {
      debugPrint("통신 실패");
      return DiaryRegisterResponse(false);
    }
  }

  Future<List<RequestDiaryInfo>> diaryList(
      int memberId, int diaryCountSize) async {
    var body = {'memberId': memberId, 'diaryCountSize': diaryCountSize};

    var jsonBody = json.encode(body);

    var response = await http.post(Uri.http(IpInfo.httpUri, '/diary/list'),
        headers: {"Content-Type": "application/json"}, body: jsonBody);

    if (response.statusCode == 200) {
      debugPrint("통신 완료");
      var data = jsonDecode(utf8.decode(response.bodyBytes)) as List;

      List<RequestDiaryInfo> diaryList =
          data.map((list) => RequestDiaryInfo.fromJson(list)).toList();
      debugPrint(diaryList.toString());

      return diaryList;
    } else {
      throw Exception("diaryList() 에러발생");
    }
  }

  Future<RequestDiaryInfo> read(int diaryNo) async {
    var response = await http.get(Uri.http(IpInfo.httpUri, '/diary/read/$diaryNo'),
      headers: {'Content-Type' : "application/json"});

    if(response.statusCode == 200) {
      debugPrint("통신 성공");
      var data = jsonDecode(utf8.decode(response.bodyBytes));

      RequestDiaryInfo diaryData = RequestDiaryInfo.fromJson(data);

      return diaryData;
    } else {
      throw Exception("read() 에러 발생");
    }
  }

  delete(DiaryDeleteRequest request) async {
    var body = json.encode(request);

    var response = await http.delete(
      Uri.http(IpInfo.httpUri, '/diary/delete'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200) {
      debugPrint("통신성공");
    } else {
      debugPrint("통신 실패");
    }
  }
}

class DiaryRegisterRequest {
  String memberId;
  String date;
  String weather;
  String condition;
  String title;
  String content;

  DiaryRegisterRequest(this.memberId, this.date, this.weather, this.condition,
      this.title, this.content);

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'date': date,
        'weather': weather,
        'condition': condition,
        'title': title,
        'content': content
      };
}

class DiaryDeleteRequest {
  int memberId;
  int diaryNo;

  DiaryDeleteRequest(
      this.memberId,
      this.diaryNo
      );

  Map<String, dynamic> toJson() => {
    'memberId' : memberId,
    'diaryNo' : diaryNo
  };
}

class RequestDiaryInfo {
  int diaryNo;
  String title;
  String content;
  String conditionStatus;
  String weather;
  String date;

  RequestDiaryInfo({
    required this.diaryNo,
    required this.title,
    required this.content,
    required this.conditionStatus,
    required this.weather,
    required this.date,
  });

  factory RequestDiaryInfo.fromJson(Map<String, dynamic> json) {
    return RequestDiaryInfo(
        diaryNo: json['diaryNo'],
        title: json['title'],
        content: json['content'],
        conditionStatus: json['conditionStatus'],
        weather: json['weather'],
        date: json['date']
    );
  }
}

class DiaryRegisterResponse {
  bool? success;

  DiaryRegisterResponse(this.success);
}
