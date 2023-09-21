import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  void navigateTo(Widget widget) {
    Navigator.push(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void navigateToReplacement(Widget widget) {
    Navigator.pushReplacement(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  void navigateToAndFinish(Widget widget) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );
  }
}

extension ThemeExtension on BuildContext {
  TextTheme get theme => Theme.of(this).textTheme;
}