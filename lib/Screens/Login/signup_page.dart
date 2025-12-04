import 'package:flutter/material.dart';
import 'package:project_collabx/Services/firebase_Authorization.dart';
import 'package:project_collabx/Utils/loading_screen.dart';

class SignUpPage extends StatefulWidget
{
    final VoidCallback onLogin;
    final VoidCallback onBack;
    const SignUpPage({super.key, required this.onLogin, required this.onBack});

    @override
    State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    with SingleTickerProviderStateMixin
{

    late AnimationController rotationalController;
    var name = TextEditingController();
    var email = TextEditingController();
    var password = TextEditingController();

    var showPass = true;
    var eyeIcon = Icons.remove_red_eye;

    @override
    void initState()
    {
        super.initState();
        rotationalController = AnimationController(
            vsync: this,
            duration: const Duration(seconds: 5)
        )..repeat();
    }

    @override
    void dispose()
    {
        email.dispose();
        name.dispose();
        password.dispose();
        rotationalController.dispose();
        super.dispose();
    }

    void handleSignUp() async
    {
      showLoading(context);
        String? result = await signUp(
            name.text,
            email.text.trim(),
            password.text.trim()
        );

        if (!mounted) return;

        Navigator.pop(context);
        if (result == "emailSent")
        {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    title: Text("Verify Email"),
                    content: Text("We have sent a verification link to your email. Please verify before logging in."),
                    actions: [
                        TextButton(
                            onPressed: ()
                            {
                                Navigator.pop(context);
                                widget.onLogin();
                            },
                            child: Text("OK")
                        )
                    ]
                )
            );
        }
        else if (result == "SomethingWentWrong"){
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                  title: Text("Something Went Wrong"),
                  content: Text("user is null"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text("OK")
                    )
                  ]
              )
          );
        }
        else
        {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    title: Text("Something Went Wrong"),
                    content: Text(result!),
                    actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("OK")
                        )
                    ]
                )
            );
        }
    }

    @override
    Widget build(BuildContext context)
    {
        return Stack(
            children: [Padding(
                    padding: const EdgeInsets.all(32),
                    child: ListView(
                        children: [
                            const SizedBox(height: 200),
                            const Text("Sign Up",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 5),
                            const Text("Please fill the details and create account",
                                textAlign: TextAlign.center),
                            const SizedBox(height: 25),
                            TextField(controller: name,
                                decoration: InputDecoration(labelText: "Name")),
                            const SizedBox(height: 15),
                            TextField(controller: email,
                                decoration: InputDecoration(labelText: "Email")),
                            const SizedBox(height: 15),
                            TextField(controller: password,
                                obscureText: showPass,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    suffixIcon: IconButton(
                                        onPressed: ()
                                        {
                                            if (showPass)
                                            {
                                                showPass = false;
                                                eyeIcon = Icons.remove_red_eye_outlined;
                                                setState(()
                                                    {
                                                    }
                                                );
                                            }
                                            else
                                            {
                                                showPass = true;
                                                eyeIcon = Icons.remove_red_eye;
                                                setState(()
                                                    {
                                                    }
                                                );
                                            }
                                        },
                                        icon: Icon(eyeIcon))
                                )
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(onPressed: ()
                                    {
                                    }, child: Text("Forgot Password"))),
                            const SizedBox(height: 10),
                            ElevatedButton(
                                onPressed: handleSignUp,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1D4E89),
                                    minimumSize: Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                                ),
                                child: const Text("Sign Up", style: TextStyle(fontSize: 20, color: Colors.white))
                            ),
                            const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    const Text("Already have an account? "),
                                    GestureDetector(
                                        onTap: widget.onLogin,
                                        child: Text(
                                            "Log In",
                                            style: TextStyle(
                                                color: Color(0xFF1D4E89),
                                                fontWeight: FontWeight.bold)
                                        )
                                    )
                                ]
                            )
                        ]
                    )
                ),

                Positioned(
                    top: 80,
                    left: MediaQuery.of(context).size.width / 2 - 55,
                    child: RotationTransition(
                        turns: rotationalController,
                        child: const Icon(
                            Icons.ac_unit,
                            size: 110,
                            color: Color(0xFF1D4E89)
                        )
                    )
                ),

                Positioned(
                    top: 30,
                    left: 15,
                    child: IconButton(
                        onPressed: widget.onBack,
                        icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(0xFF1D4E89),
                            size: 26
                        )
                    )
                )
            ]
        );
    }
}
