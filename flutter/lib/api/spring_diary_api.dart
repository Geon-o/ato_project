import 'dart:convert';

import 'package:ato/api/ip_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class SpringDiaryApi {

  register(DiaryRegisterRequest request) async {
    var body = json.encode(request);

    var response = await http.post(
      Uri.http(IpInfo.httpUri, '/diary/register'),
      headers: {"Content-Type" : "application/json"},
      body: body,
    );

    debugPrint(request.memberId);
    debugPrint(request.date);
    debugPrint(request.weather);
    debugPrint(request.condition);
    debugPrint(request.title);
    debugPrint(request.content);

    if(response.statusCode == 200){
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

  DiaryRegisterRequest(
      this.memberId,
      this.date,
      this.weather,
      this.condition,
      this.title,
      this.content
      );

  Map<String, dynamic> toJson() => {
    'memberId' : memberId,
    'date' : date,
    'weather' : weather,
    'condition' : condition,
    'title' : title,
    'content' : content
  };
}