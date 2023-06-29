import 'package:flutter/material.dart';

import '../../app/constants/ui_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: CircularProgressIndicator(
            color: kDark,
          ),
        ),
      ),
    );
  }
}
