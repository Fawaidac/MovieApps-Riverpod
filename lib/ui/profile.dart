import 'package:fininite_riverpod/core/provider/db_provider.dart';
import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/core/widgets/customtextfield.dart';
import 'package:fininite_riverpod/ui/home.dart';
import 'package:fininite_riverpod/ui/login.dart';
import 'package:fininite_riverpod/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authController = ref.watch(authControllerProvider);
    final user = authController.getDataUser();
    final deviceSize = context.deviceSize;

    final nameController = TextEditingController(text: user?.username);
    final emailController = TextEditingController(text: user?.email);

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
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
              const CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage("images/killua.jpg"),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${user?.username}',
                style: AppFonts.poppins(
                    fontSize: 18,
                    color: whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                '${user?.email}',
                style: AppFonts.poppins(
                    fontSize: 14,
                    color: whiteColor,
                    fontWeight: FontWeight.w300),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 50),
                width: deviceSize.width,
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
                    CustomTextField(
                      hintText: "Name",
                      icon: Icons.person,
                      controller: nameController,
                    ),
                    const Gap(15),
                    CustomTextField(
                      hintText: "Email",
                      icon: Icons.mail,
                      controller: emailController,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 48,
                      width: deviceSize.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          await authController.updateUserData(
                            nameController.text,
                            emailController.text,
                          );
                          Fluttertoast.showToast(msg: "Profile Updated");
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blueColor,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: whiteColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "Save",
                          style: AppFonts.poppins(
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 48,
                      width: deviceSize.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          await authController.logout();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()),
                          );
                          Fluttertoast.showToast(msg: "Logout Successfully");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blueColor,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: whiteColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "LogOut",
                          style: AppFonts.poppins(
                            fontSize: 16,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
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
