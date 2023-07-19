import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/constants.dart';
import 'package:mini_project/main.dart';
import 'package:mini_project/screens/auth/reset_password.dart';
import 'package:mini_project/screens/auth/register/register.dart';
import 'package:mini_project/widgets/button/button.dart';
import 'package:mini_project/widgets/text/cm_text.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final navigatorKey = GlobalKey<NavigatorState>();

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  String email = '';
  String password = '';
  bool hidePassword = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: myPrimaryColor,
          image: DecorationImage(
              image: AssetImage('assets/images/topBg.png'),
              repeat: ImageRepeat.repeat,
              opacity: .35),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child:
                      Image(image: AssetImage('assets/images/login_pic.png')),
                ),
                Container(
                  width: double.infinity,
                  height: height * .6,
                  decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? myBgColorLight
                          : myBgColorDark,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: CMText(
                          text: 'Login',
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: SizedBox(
                                width: width * .95,
                                height: 60,
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email!.isEmpty
                                      ? 'Please enter your email'
                                      : !email.contains('@')
                                          ? 'Please enter a valid email'
                                          : null,
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
                                      // borderSide: BorderSide(color: borderColor, width: borderWidth),
                                    ),
                                    iconColor: mySecondaryColor,
                                    labelText: 'Email',
                                    hintText: 'user@email.com',
                                    prefixIcon: const Icon(
                                      Icons.email,
                                      color: Colors.black45,
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
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: SizedBox(
                                width: width * .95,
                                height: 60,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: hidePassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (password) => password!.isEmpty
                                      ? 'Please enter your password'
                                      : password.length < 6
                                          ? 'Password must be at least 6 characters'
                                          : null,
                                  // keyboardType: TextInputType.visiblePassword,
                                  textInputAction: TextInputAction.done,
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
                                      // borderSide: BorderSide(color: borderColor, width: borderWidth),
                                    ),
                                    iconColor: mySecondaryColor,
                                    labelText: 'Password',
                                    hintText: '********',
                                    prefixIcon: const Icon(
                                      Icons.lock,
                                      color: Colors.black45,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePassword = !hidePassword;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove_red_eye,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      password = value;
                                    });
                                  },
                                  // onSubmitted: (value) {
                                  //   signInWithEmailAndPassword();
                                  // },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => nextScreen(context, const ResetPassword()),
                        child: const SizedBox(
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 3.0),
                            child: CMText(
                              text: "Forgot password?",
                              color: Colors.red,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: CMButton(
                          text: 'Continue',
                          textSize: 22,
                          textColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? mySecondaryTextColor
                                  : myPrimaryTextColor,
                          color: emailController.text.isEmpty ||
                                  passwordController.text.isEmpty
                              ? myBgColorLight
                              : mySecondaryColor,
                          width: width * 0.95,
                          borderColor: mySecondaryColor,
                          borderWidth: 2,
                          onPressed: () {
                            // nextScreen(context, const Home());
                            loginWithEmailAndPassword();
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.0),
                        child: CMText(
                          text: 'OR',
                          fontSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: CMButton(
                          text: 'Sign in with GOOGLE',
                          width: width * 0.95,
                          borderColor: mySecondaryColor,
                          borderWidth: 2,
                          onPressed: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CMText(text: "Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                nextScreen(context, const Register());
                              },
                              child: const CMText(
                                text: 'Register now',
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future loginWithEmailAndPassword() async {
    final formIsValid = _formKey.currentState!.validate();
    if (!formIsValid) {
      return;
    }

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // nextScreen(context, const Home());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar(context, Colors.green, 'No user found for that email.');
        nextScreen(context, const Login());
      } else if (e.code == 'wrong-password') {
        showSnackbar(
            context, Colors.green, 'Wrong password provided for that user.');
      }
    } catch (e) {
      showSnackbar(context, Colors.green, e.toString());
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
