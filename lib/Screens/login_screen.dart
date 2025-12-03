import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget
{
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
{
  IconData eye = Icons.remove_red_eye;

  var email = TextEditingController();
  var password = TextEditingController();

  var show = true;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter
          )
        ),
        child: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(width: 0.5),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ]
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 45,
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

                TextField(
                  controller: password,
                  obscureText: show,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(onPressed: () {
                        setState(() {
                            if (show) 
                            {
                              show = false;
                              eye = Icons.remove_red_eye_outlined;
                            }
                            else 
                            {
                              show = true;
                              eye = Icons.remove_red_eye;
                            }
                          }
                        );
                      }, icon: Icon(eye)),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  )
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(color: Colors.white70, fontSize: 15)
                  )
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await FirebaseAuth.instance.signInWithEmailAndPassword(
                                email: email.text.trim(),
                                password: password.text.trim()
                            );

                            User? user = FirebaseAuth.instance.currentUser;
                          }
                          catch (e){
                            print(e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                        child: const Text("Log In", style: TextStyle(fontSize: 22))
                      )
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          try{
                            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                              email: email.text.trim(),
                              password: password.text.trim(),
                            );
                          }
                          catch(e){
                            print(e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)
                          )
                        ),
                        child: const Text("Sign Up", style: TextStyle(fontSize: 22))
                      )
                    )
                  ]
                )
              ]
            )
          )
        )
      )
    );
  }
}
