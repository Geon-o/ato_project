import 'package:ato/api/spring_member_api.dart';
import 'package:ato/page/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() async {
  const storage = FlutterSecureStorage();

  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isFirstRun = prefs.getBool('is_first_run') ?? true;
  if (isFirstRun) {
    await SpringMemberApi().registerMemberApi();
    await prefs.setBool('is_first_run', false);
  }
  String? idValue = await storage.read(key: 'memberId');
  debugPrint("현재 사용자 아이디: " + idValue!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainPage(),
      ),
    );
  }
}
