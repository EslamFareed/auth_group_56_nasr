import 'package:auth_group_56_nasr/core/helpers/navigation_helper.dart';
import 'package:auth_group_56_nasr/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      NavigationHelper.goOff(context, HomeScreen());
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => HomeScreen(),
      //   ),
      // );
    });

    return const Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
