import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:trashure_motion/ui/halaman_utama/halaman_utama.dart';
import 'package:trashure_motion/ui/login/login_page.dart';
import 'package:trashure_motion/ui/daftar/signup_page.dart';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/signUP': (BuildContext context) => new SignupPage(),
        '/signIN': (BuildContext context) => new LoginPage(),
        '/jos': (BuildContext context) => new HalamanUtama(),
      },
    );
  }
}
