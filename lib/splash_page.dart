import 'dart:async';

import 'package:flutter/material.dart';
import 'donor_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'user_type.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _loadWidegt();
  }

  _loadWidegt() {
    return Timer(Duration(seconds: 5), checkFirst);
  }

  Future checkFirst() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen == false) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DonorScreen()));
    } else {
      prefs.setBool('seen', true);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => UserType()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/mosanad.jpeg',
            fit: BoxFit.cover,
          ), // Replace with your cover image path
        ],
      ),
    );

    // Your content goes here, for example, the logo or any other elements
    // Replace with your logo path
  }
}
