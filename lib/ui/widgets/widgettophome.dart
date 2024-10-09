import 'package:fininite_riverpod/core/themes/colors.dart';
import 'package:fininite_riverpod/core/themes/fonts.dart';
import 'package:fininite_riverpod/ui/profile.dart';
import 'package:flutter/material.dart';

class WidgetTopHome extends StatelessWidget {
  const WidgetTopHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Welcome",
                style: AppFonts.poppins(
                    fontSize: 20,
                    color: whiteColor,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Watch your favorite movies here",
                style: AppFonts.poppins(
                    fontSize: 14,
                    color: whiteColor,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ));
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/killua.jpg'),
          ),
        )
      ],
    );
  }
}
