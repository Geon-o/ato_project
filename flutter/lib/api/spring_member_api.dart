
import 'dart:convert';

import 'package:ato/api/ip_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class SpringMemberApi {
  static var registerMemberResponse;
  static const storage = FlutterSecureStorage();
  static bool authenticationValue = false;

  registerMemberApi() async {

    debugPrint("registerMemberApi");
    try {
      registerMemberResponse = await http.post(
        Uri.http(IpInfo.httpUri, '/member/register')
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    if(registerMemberResponse.statusCode == 200){
      debugPrint("통신 성공");

      var memberId = jsonDecode(utf8.decode(registerMemberResponse.bodyBytes));
      debugPrint("memberId: " + memberId.toString());

      await storage.deleteAll();
      await storage.write(key: 'memberId', value: memberId.toString());
      String? idValue = await storage.read(key: 'memberId');
    }
  }
}