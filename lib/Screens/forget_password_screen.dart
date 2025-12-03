import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgetPasswordScreen extends StatefulWidget
{
    const ForgetPasswordScreen({super.key});

    @override
    State<StatefulWidget> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetPasswordScreen>
{
    var email = TextEditingController();

    @override
    Widget build(BuildContext context)
    {
        return Scaffold(
            body: Stack(
                children: [
                    Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.black, Colors.blueGrey],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter
                            )
                        )
                    ),

                    SafeArea(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.only(left: 10, top: 10),
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        shape: BoxShape.circle
                                    ),
                                    child: const Icon(
                                        Icons.arrow_back,
                                        color: Colors.blueGrey,
                                        size: 32
                                    )
                                )
                            )
                        )
                    ),

                    Center(
                        child: Container(
                            width: 350,
                            padding: const EdgeInsets.all(22),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(18),
                                border: Border.all(width: 0.5),
                                boxShadow: const[
                                    BoxShadow(color: Colors.black26, blurRadius: 10, spreadRadius: 2)
                                ]
                            ),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                    const Text(
                                        "Forget Password",
                                        style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red
                                        )
                                    ),
                                    const SizedBox(height: 30),

                                    TextField(
                                        controller: email,
                                        decoration: InputDecoration(
                                            labelText: "Email",
                                            prefixIcon: const Icon(Icons.email),
                                            filled: true,
                                            fillColor: Colors.white,
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(16)
                                            )
                                        )
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                        onPressed: ()
                                        {
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(25)
                                            )
                                        ),
                                        child: const Text("Log In", style: TextStyle(fontSize: 22))
                                    )
                                ]
                            )
                        )
                    )
                ]
            )
        );
    }
}
