import 'package:flutter/material.dart';
import 'package:mini_project/constants.dart';
import 'package:mini_project/screens/auth/login/login.dart';
import 'package:mini_project/widgets/button/button.dart';
import 'package:mini_project/widgets/text/cm_text.dart';

class Intro extends StatelessWidget {
  const Intro({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? myPrimaryColorDark
              : myPrimaryColorLight,
          image: DecorationImage(
            image: Theme.of(context).brightness == Brightness.dark
                ? const AssetImage('assets/images/topBgDark.png')
                : const AssetImage('assets/images/topBg.png'),
            repeat: ImageRepeat.repeat,
            opacity:
                Theme.of(context).brightness == Brightness.dark ? .15 : .35,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                children: [
                  Image(image: AssetImage('assets/images/intro_pic.png'))
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const CMText(
                    text: 'Stress Free Cooking For Everyone',
                    color: myTextColorDark,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: CMText(
                      text:
                          'Find a wide range of recipes made just for you. Just input your ingredients and start cooking.',
                      color: myTextColorDark,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CMButton(
                    text: 'Get started',
                    onPressed: () {
                      nextScreen(context, const Login());
                    },
                    color: mySecondaryColor,
                    width: width * .9,
                    textSize: 26,
                    fontWeight: FontWeight.w500,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
