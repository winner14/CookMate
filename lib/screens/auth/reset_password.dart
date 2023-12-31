import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/constants.dart';
import 'package:mini_project/widgets/button/button.dart';
import 'package:mini_project/widgets/text/cm_text.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final emailController = TextEditingController();
  String email = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const CMText(
          text: 'Password Reset',
          color: myTextColorDark,
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: height * .65,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? myBgColorDark
                      : myBgColorLight,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // const CMText(
                    //   text: 'Enter your email address',
                    //   fontSize: 20,
                    // ),
                    Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Container(
                          width: width * .95,
                          height: 60,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? myFgColorDark
                                    : myFgColorLight,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            // validator: (email) => email!.isEmpty
                            //     ? 'Please enter your email'
                            //     : !email.contains('@')
                            //         ? 'Please enter a valid email'
                            //         : null,
                            decoration: InputDecoration(
                              labelStyle: const TextStyle(
                                  color: Color(0xA0000000), fontSize: 18),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: mySecondaryColor,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(15),
                                  left: Radius.circular(15),
                                ),
                              ),
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(15),
                                  left: Radius.circular(15),
                                ),
                              ),
                              iconColor: mySecondaryColor,
                              label: CMText(
                                text: 'Enter your email',
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? myTextColorDark
                                    : myTextColorLight,
                              ),
                              hintText: 'user@email.com',
                              hintStyle: TextStyle(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? myTextColorDark
                                    : myTextColorLight,
                              ),
                              prefixIcon: Icon(
                                Icons.email,
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? myTextColorDark
                                    : myTextColorLight,
                              ),
                              suffixIcon: emailController.text.isEmpty
                                  ? const SizedBox(
                                      width: 0,
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        email = '';
                                        emailController.clear();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.black45,
                                      ),
                                    ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                email = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    // const CMText(
                    //   text: 'A password reset link will be sent to your email',
                    //   fontSize: 16,
                    //   color: Colors.black54,
                    // ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: CMButton(
                        text: 'Send',
                        textSize: 20,
                        onPressed: () {
                          resetPassword();
                        },
                        width: width * .95,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future resetPassword() async {
    final formIsValid = _formKey.currentState!.validate();
    if (!formIsValid) {
      return showSnackbarWithoutAction(
          context, Colors.red, 'Please enter a valid email');
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Password reset link sent to $email. \nCheck your email inbox or spams'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      showSnackbar(
          context,
          Theme.of(context).brightness == Brightness.dark
              ? myPrimaryColorDark
              : myPrimaryColorLight,
          e.message.toString());
    }
  }
}
