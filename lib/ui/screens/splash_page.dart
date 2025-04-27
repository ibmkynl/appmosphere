import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    _moveHomePage(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset("assets/icon/icon.png", fit: BoxFit.cover, height: 300.h, width: 300.w)),
    );
  }

  Future<void> _moveHomePage(context) async {
    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pushReplacement(HomePage.route());
  }
}
