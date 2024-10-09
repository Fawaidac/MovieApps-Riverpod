import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/core/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: darkColor,
            child: Icon(
              Icons.keyboard_arrow_left,
              color: whiteColor,
            ),
          ),
        ),
        title: Text(
          "Your Profile",
          style: AppFonts.poppins(
              fontSize: 16, color: whiteColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("images/killua.jpg"),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Achmad Fawa'id",
                style: AppFonts.poppins(
                    fontSize: 18,
                    color: whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "fwdachmd@gmail.com",
                style: AppFonts.poppins(
                    fontSize: 14,
                    color: whiteColor,
                    fontWeight: FontWeight.w300),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.transparent,
                  border: Border.all(
                    color: whiteColor,
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    CustomTextField(hintText: "Name", icon: Icons.person)
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
