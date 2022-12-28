import 'dart:async';

import 'package:flutter/material.dart';
import 'package:post_ui/view/sign_up_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'demo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userName;
  @override
  void initState() {
    getusername().whenComplete(
      () => Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => userName == null ? SignUpScreen() : Demo(),
          ),
        ),
      ),
    );
    super.initState();
  }

  Future getusername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('username');
    setState(() {
      userName = email;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('WELCOME TO EDU',
                  style: TextStyle(
                    fontSize: width * 0.04,
                  )),
              SizedBox(
                height: height * 0.03,
              ),
              Image.asset(
                  height: height * 0.4,
                  'assets/images/online-registration-sign-up-concept-young-people-signing-login-to-account-user-interface-secure-password-modern-vector-194944767.jpg'),
              SizedBox(
                height: height * 0.2,
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              //   child: Column(
              //     children: [
              //       MaterialButton(
              //         color: Colors.deepPurple,
              //         onPressed: () {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => LoginScreen(),
              //               ));
              //         },
              //         height: height * 0.08,
              //         minWidth: double.infinity,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(width * 0.1),
              //         ),
              //         child: Text("LOGIN",
              //             style: TextStyle(
              //                 letterSpacing: 1,
              //                 color: Colors.white,
              //                 fontSize: width * 0.05,
              //                 fontWeight: FontWeight.bold)),
              //       ),
              //       SizedBox(
              //         height: height * 0.03,
              //       ),
              //       MaterialButton(
              //         color: Colors.deepPurpleAccent.shade100,
              //         onPressed: () {
              //           Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (context) => SignUpScreen(),
              //               ));
              //         },
              //         height: height * 0.08,
              //         minWidth: double.infinity,
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(width * 0.1),
              //         ),
              //         child: Text("SIGN UP",
              //             style: TextStyle(
              //                 letterSpacing: 1,
              //                 color: Colors.white,
              //                 fontSize: width * 0.05,
              //                 fontWeight: FontWeight.bold)),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
