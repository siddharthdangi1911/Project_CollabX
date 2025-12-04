import 'package:flutter/material.dart';
import 'package:project_collabx/Screens/user_Screen.dart';
import 'package:project_collabx/Services/firebase_authorization.dart';
import 'package:project_collabx/Utils/loading_screen.dart';
import 'package:project_collabx/Utils/page_route.dart';


class LoginPage extends StatefulWidget
{
    final VoidCallback onSignup;
    final VoidCallback onBack;
    const LoginPage({super.key, required this.onSignup, required this.onBack});

    @override
    State<StatefulWidget> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>
    with  SingleTickerProviderStateMixin
{
    late AnimationController rotationController;
    var email = TextEditingController();
    var password = TextEditingController();
    var showPass = true;
    var eyeIcon = Icons.remove_red_eye;

    @override
    void initState()
    {
        super.initState();
        rotationController = AnimationController(
            vsync: this,
            duration: Duration(seconds: 5)
        )..repeat();
    }

    @override
    void dispose()
    {
        email.dispose();
        password.dispose();
        rotationController.dispose();
        super.dispose();
    }

    void handleForgetPassword() async
    {
        showLoading(context);
        String? result = await forgetPassword(email.text.trim());
        if (!mounted) return;
        Navigator.pop(context);
        if (result == "success") 
        {
            showDialog(
                context: context,
                builder: (_) => AlertDialog(
                    title: Text("Forget Password"),
                    content: Text("We have sent a reset password link to your email. Please reset password before logging in."),
                    actions: [
                        TextButton(
                            onPressed: ()
                            {
                                Navigator.pop(context);
                                email.clear();
                            },
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

    void handleLogIn() async
    {
        String? result = await logIn(
            email.text.trim(),
            password.text.trim()
        );

        if (!mounted) return;
        if (result == "success")
        {
            nextPage(context, UserScreen());
        }
        else if (result == "notVerified")
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
                                email.clear();
                                password.clear();
                            },
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
            children: [
                Padding(
                    padding: const EdgeInsets.all(32),
                    child: ListView(
                        children: [
                            const SizedBox(height: 200),
                            const Text(
                                "Log In",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                            ),
                            const SizedBox(height: 5),

                            const Text(
                                "Please login to continue using our app",
                                textAlign: TextAlign.center
                            ),
                            const SizedBox(height: 25),

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
                                        }, icon: Icon(eyeIcon))
                                )
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                    onPressed: handleForgetPassword,
                                    child: const Text("Forgot Password"))
                            ),
                            const SizedBox(height: 10),

                            ElevatedButton(
                                onPressed: handleLogIn,
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF1D4E89),
                                    minimumSize: const Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12))
                                ),
                                child: const Text("Log In", style: TextStyle(fontSize: 20, color: Colors.white))
                            ),

                            const SizedBox(height: 10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    const Text("Don't have an account? "),
                                    GestureDetector(
                                        onTap: widget.onSignup,
                                        child: const Text(
                                            "Sign Up",
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
                        turns: rotationController,
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
