import 'package:flutter/material.dart';
import '../../Utils/login_logo_animation.dart';

class WelcomePage extends StatefulWidget {
  final VoidCallback onNextButton;
  final VoidCallback onNextText;
  const WelcomePage({super.key, required this.onNextButton, required this.onNextText});

  @override
  State<StatefulWidget> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  bool startMoveUp = false;
  final Duration move = Duration(milliseconds: 500);

  void triggerNextButton() async {
    setState(() => startMoveUp = true);
    await Future.delayed(const Duration(milliseconds: 400));
    widget.onNextButton();
  }
  void triggerNextText() async {
    setState(() => startMoveUp = true);
    await Future.delayed(const Duration(milliseconds: 400));
    widget.onNextText();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 450),
              const Text(
                "Welcome To CollabX",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Create an account and access our facilities",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: triggerNextButton,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1D4E89),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Get Started", style: TextStyle(fontSize: 20, color: Colors.white),),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do you have an account? "),
                  GestureDetector(
                    onTap: triggerNextText,
                    child: const Text(
                      "Log In",
                      style: TextStyle(
                          color: Color(0xFF1D4E89), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        LoginLogoAnimation(
            icon: Icon(
              Icons.ac_unit,
              size: 200,
              color: Color(0xFF1D4E89),
            ),
            startMoveUp: startMoveUp,
            upDuration: move,
            rotationDuration: Duration(seconds: 5),
            scaleDuration: move,
          maxPos: 300,
          minPos: 112,
          minScale: 1.0,
          maxScale: 0.55,
        ),
      ],
    );
  }
}
