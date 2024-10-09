import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/core/widgets/customtextfield.dart';
import 'package:fininite_riverpod/ui/login.dart';
import 'package:fininite_riverpod/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WidgetFormRegister extends StatefulWidget {
  const WidgetFormRegister({super.key});

  @override
  State<WidgetFormRegister> createState() => _WidgetFormRegisterState();
}

class _WidgetFormRegisterState extends State<WidgetFormRegister> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confPasswordController = TextEditingController();

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'email format must be valid';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be more than 6 characters';
    }
    return null;
  }

  String? _validateConfPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value.length < 6) {
      return 'Password must be more than 6 characters';
    }
    if (value != confPasswordController.text) {
      return 'Password must be the same';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            hintText: "Name",
            icon: Icons.person,
            controller: nameController,
            validator: _validateName,
          ),
          const Gap(15),
          CustomTextField(
            hintText: "Email",
            icon: Icons.mail,
            controller: emailController,
            validator: _validateEmail,
          ),
          const Gap(15),
          CustomTextField(
            hintText: "Password",
            icon: Icons.lock,
            isObs: true,
            controller: passwordController,
            validator: _validatePassword,
          ),
          const Gap(15),
          CustomTextField(
            hintText: "Confirm Password",
            icon: Icons.lock,
            isObs: true,
            controller: confPasswordController,
            validator: _validateConfPassword,
          ),
          const Gap(30),
          SizedBox(
            height: 48,
            width: deviceSize.width,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: blueColor,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Text(
                  "Register",
                  style: AppFonts.poppins(
                      fontSize: 16,
                      color: whiteColor,
                      fontWeight: FontWeight.bold),
                )),
          ),
          const Gap(50),
          Text(
            "Copyright@2024",
            style: AppFonts.poppins(
                fontSize: 12, color: whiteColor, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
