import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_collabx/Screens/user_screen.dart';
import 'Screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CollabX',
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final user = FirebaseAuth.instance.currentUser;

          if (user == null) {
            return const AuthScreen();
          }

          if (!user.emailVerified) {
            FirebaseAuth.instance.signOut();
            return const AuthScreen();
          }

          return const UserScreen();
        },
      ),
    );
  }
}