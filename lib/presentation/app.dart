import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home/screen/home_screen.dart';

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  bool isLightTheme = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News',
      theme: ThemeData(
        fontFamily: GoogleFonts.poppins().fontFamily,
        brightness: isLightTheme ? Brightness.light : Brightness.dark,
      ),
      home: HomeScreen(
        onThemeChanged: (bool value) {
          setState(() {
            isLightTheme = value;
          });
        },
      ),
    );
  }
}
