import 'package:flutter/material.dart';
import 'package:task/pages/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.black26,
      ),
      home: const Splash(),
    );
  }
}

// Future<void> init() async {

// }
