import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/constants/asset_location.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //svg image
              SvgPicture.asset(
                instagramLogo,
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(
                height: 64,
              ),
              //email
              TextFieldInput(
                controller: _emailController,
                hint: "Enter your email",
                keyboardType: TextInputType.emailAddress,
                isPassword: false,
              ),
              const SizedBox(
                height: 24,
              ),
              //password
              TextFieldInput(
                controller: _passwordController,
                hint: "Enter your password",
                keyboardType: TextInputType.emailAddress,
                isPassword: true,
              ),
              const SizedBox(
                height: 24,
              ),
              //login button
              InkWell(
                onTap: () {
                  debugPrint("Log in");
                },
                child: Container(
                  child: const Text("Log in"),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: const ShapeDecoration(
                      color: blueColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Flexible(
                child: Container(),
                flex: 2,
              ),
              //sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: const Text("Don't have an account? ")),
                  GestureDetector(
                    onTap: () {
                      debugPrint("Sign up");
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: const Text(
                          "Sign Up.",
                          style: TextStyle(
                              color: blueColor, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
