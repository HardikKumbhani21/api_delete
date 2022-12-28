import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:post_ui/api_services/sign_up_user_services.dart';
import 'package:post_ui/model/sign_up_model.dart';
import 'package:post_ui/view/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final formkey = GlobalKey<FormState>();
  bool isloading = false;

  ImagePicker picker = ImagePicker();
  File? image;

  void getImageFromCamera() async {
    final pickedimage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedimage != null) {
      setState(() {
        image = File(pickedimage.path);
      });
    }
  }

  Future<String?> uploadUserImage() async {
    dio.FormData formData = dio.FormData.fromMap(
      {'avatar': await dio.MultipartFile.fromFile(image!.path)},
    );
    dio.Response response = await dio.Dio().post(
        'https://codelineinfotech.com/student_api/User/user_avatar_upload.php',
        data: formData);

    if (response.data['url'] != null) {
      return response.data['url'];
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.03,
              ),
              Text('SIGNUP',
                  style: TextStyle(
                    fontSize: width * 0.04,
                  )),
              SizedBox(
                height: height * 0.03,
              ),
              GestureDetector(
                onTap: () {
                  getImageFromCamera();
                },
                child: Container(
                    height: height * 0.180,
                    width: height * 0.180,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff4d0099),
                      ),
                    ),
                    child: ClipOval(
                      child: image == null
                          ? Icon(Icons.camera)
                          : Image.file(
                              image!,
                              fit: BoxFit.cover,
                            ),
                    )),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.05),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: firstname,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Firstname.';
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Color(0xff4d0099),
                              fontSize: width * 0.0450,
                              fontWeight: FontWeight.bold),
                          hintText: 'FirstName',
                          fillColor: Color(0xffe6ccff),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      TextFormField(
                        controller: lastname,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter the Lastname.';
                          }
                        },
                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Color(0xff4d0099),
                              fontSize: width * 0.0450,
                              fontWeight: FontWeight.bold),
                          hintText: 'LastName',
                          fillColor: Color(0xffe6ccff),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
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
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
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
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
                            borderSide: BorderSide.none,
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.1),
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
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            final imageurl = await uploadUserImage();
                            SignUpModel model = SignUpModel();
                            model.firstName = firstname.text;
                            model.lastName = lastname.text;
                            model.username = username.text;
                            model.password = password.text;
                            model.avatar = imageurl;

                            bool? status = await SignUpUserServices.signUpUser(
                                model.toJson());
                            if (status == false) {
                              setState(() {
                                isloading = false;
                              });
                              prefs.setString('username', username.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(" User Already exist"),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ));
                            }
                          }
                        },
                        height: height * 0.08,
                        minWidth: double.infinity,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width * 0.1),
                        ),
                        child: Text("SIGN UP",
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
                "Already have an Account ? Sign Up",
                style:
                    TextStyle(fontSize: width * 0.04, color: Color(0xff4d0099)),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                "or",
                style:
                    TextStyle(fontSize: width * 0.04, color: Color(0xff4d0099)),
              ),
              SizedBox(
                height: height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: height * 0.07,
                    width: height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff4d0099),
                      ),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/facebook (2) (1).png',
                          height: height * 0.05),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Container(
                    height: height * 0.07,
                    width: height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff4d0099),
                      ),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/twitter (1).png',
                          height: height * 0.05),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.03,
                  ),
                  Container(
                    height: height * 0.07,
                    width: height * 0.07,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xff4d0099),
                      ),
                    ),
                    child: Center(
                      child: Image.asset('assets/images/google-plus.png',
                          height: height * 0.05),
                    ),
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
