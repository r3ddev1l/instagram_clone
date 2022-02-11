import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:instagram_clone/screens/sign_up_screen/sign_up_screen.dart';
import 'package:instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'instagram-clone',
    options: kIsWeb || Platform.isAndroid
        ? const FirebaseOptions(
            apiKey: "AIzaSyBH83DesJG1Y_UXf7nOJgtrWLVDQaizHD8",
            appId: "1:1037854655614:web:0994da687ab4a071f7c42f",
            messagingSenderId: "1037854655614",
            projectId: "instagram-clone-85f00",
            storageBucket: "instagram-clone-85f00.appspot.com",
          )
        : null,
  );

  await FirebaseAppCheck.instance.activate();
  String? token = await FirebaseAppCheck.instance.getToken();
  print('1111111111111111111111111');
  print(token);
  print('1111111111111111111111111');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Instagram Clone',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
        ),
        home: const SignUpScreen()
        //  const ResponsiveLayout(
        //   webScreenLayout: WebScreenLayout(),
        //   mobileScreenLayout: MobileScreenLayout(),
        // ),
        );
  }
}
