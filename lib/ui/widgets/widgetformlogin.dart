import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/core/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

class WidgetFormLogin extends StatefulWidget {
  const WidgetFormLogin({super.key});

  @override
  State<WidgetFormLogin> createState() => _WidgetFormLoginState();
}

class _WidgetFormLoginState extends State<WidgetFormLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Masukkan email yang valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 6) {
      return 'Password harus lebih dari 6 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              hintText: "Email",
              icon: Icons.mail,
              controller: emailController,
              validator: _validateEmail,
            ),
            const SizedBox(
              height: 15,
            ),
            CustomTextField(
              hintText: "Password",
              icon: Icons.lock,
              isObs: true,
              controller: passwordController,
              validator: _validatePassword,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Radius 10
                      ),
                      shadowColor: Colors.transparent),
                  child: Text(
                    "Login",
                    style: AppFonts.poppins(
                        fontSize: 16,
                        color: whiteColor,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ));
  }
}
