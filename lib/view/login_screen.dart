import 'package:flutter/material.dart';
import 'package:post_ui/api_services/login_user_services.dart';
import 'package:post_ui/model/login_model.dart';
import 'package:post_ui/view/demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: isloading == true
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Text('LOGIN',
                        style: TextStyle(
                          fontSize: width * 0.04,
                        )),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Image.asset(
                        height: height * 0.4,
                        'assets/images/online-registration-sign-up-concept-young-woman-signing-login-to-account-smartphone-app-user-interface-secure-password-194944775.jpg'),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                      child: Form(
                        key: formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextFormField(
                              controller: username,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the Username.';
                                }
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Color(0xff4d0099),
                                    fontSize: width * 0.0450,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Username',
                                fillColor: Color(0xffe6ccff),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            TextFormField(
                              controller: password,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter the Password.';
                                }
                              },
                              decoration: InputDecoration(
                                hintStyle: TextStyle(
                                    color: Color(0xff4d0099),
                                    fontSize: width * 0.0450,
                                    fontWeight: FontWeight.bold),
                                hintText: 'Password',
                                fillColor: Color(0xffe6ccff),
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            MaterialButton(
                              color: Color(0xff4d0099),
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  setState(
                                    () {
                                      isloading = true;
                                    },
                                  );
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  LoginModel model = LoginModel();
                                  model.username = username.text;
                                  model.password = password.text;

                                  bool? status =
                                      await LoginUserServices.loginuser(
                                          model.toJson());
                                  if (isloading == true) {
                                    prefs.setString('username', username.text);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Demo(),
                                        ));
                                  } else {
                                    setState(
                                      () {
                                        isloading = false;
                                      },
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text("Invalid username."),
                                      ),
                                    );
                                  }
                                }
                              },
                              height: height * 0.08,
                              minWidth: double.infinity,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(width * 0.1),
                              ),
                              child: Text("LOGIN",
                                  style: TextStyle(
                                      letterSpacing: 1,
                                      color: Colors.white,
                                      fontSize: width * 0.05,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      "Already have an Account ? Sign in",
                      style: TextStyle(
                          fontSize: width * 0.04, color: Color(0xff4d0099)),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
