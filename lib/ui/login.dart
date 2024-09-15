import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/widgetformlogin.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [primaryColor, secondaryColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Lets sign you in",
                    style: AppFonts.poppins(
                        fontSize: 24,
                        color: whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Welcome back. You've been missed",
                    textAlign: TextAlign.center,
                    style: AppFonts.poppins(
                        fontSize: 14,
                        color: whiteColor,
                        fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(height: 40),
                  WidgetFormLogin(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
