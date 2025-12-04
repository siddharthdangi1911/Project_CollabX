import 'package:flutter/material.dart';

class UserScreen extends StatefulWidget{
  const UserScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("User Screen", style: TextStyle(fontSize: 30),),
      ),
    );
  }
  
}