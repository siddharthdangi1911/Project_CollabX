import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../Screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp
      (
        title: 'Namer App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData
          (
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          ),
        home: LoginScreen(),
      );
  }
}