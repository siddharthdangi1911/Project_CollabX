import 'package:flutter/material.dart';
import 'Login/login_page.dart';
import 'Login/welcome_page.dart';
import 'Login/signup_page.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          return PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3,
            itemBuilder: (context, index) {
              double pageOffset = 0;
              if (_pageController.hasClients && _pageController.page != null) {
                pageOffset = _pageController.page! - index;
              }

              final double verticalOffset = -(pageOffset * 300);
              final double opacity = (1 - pageOffset.abs()).clamp(0.0, 1.0);

              return Transform.translate(
                offset: Offset(0, verticalOffset),
                child: Opacity(
                  opacity: opacity,
                  child: _getPage(index),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return WelcomePage(onNextButton: () => _goTo(1), onNextText: () => _goTo(2),);
      case 1:
        return SignUpPage(onLogin: () => _goTo(2), onBack: () => _goTo(0));
      default:
        return LoginPage(onSignup: () => _goTo(1), onBack: () => _goTo(0),);
    }
  }

  void _goTo(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
    );
  }
}
