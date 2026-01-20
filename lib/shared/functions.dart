import 'package:flutter/material.dart';

void toggleDrawer(GlobalKey<ScaffoldState> scaffoldKey) {
  if (scaffoldKey.currentState?.isDrawerOpen ?? false) {
    scaffoldKey.currentState?.openEndDrawer();
  } else {
    scaffoldKey.currentState?.openDrawer();
  }
}