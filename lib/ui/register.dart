import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/widgets/widgetformregister.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: whiteColor,
            )),
      ),
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
                    "Join us for free",
                    style: AppFonts.poppins(
                        fontSize: 24,
                        color: whiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Find the best movie of your choice",
                    textAlign: TextAlign.center,
                    style: AppFonts.poppins(
                        fontSize: 14,
                        color: whiteColor,
                        fontWeight: FontWeight.w200),
                  ),
                  const SizedBox(height: 40),
                  WidgetFormRegister(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
