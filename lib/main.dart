import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';  // Import GetStorage
import 'package:note_app/dark_light.dart';
import 'package:note_app/home_page.dart';

void main() async {
  // Initialize GetStorage before the app runs
  await GetStorage.init();
  runApp(SamsungNotes());
}

class SamsungNotes extends StatelessWidget {
  const SamsungNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkMode,  // Your dark theme
      home: HomePage(),
    );
  }
}
