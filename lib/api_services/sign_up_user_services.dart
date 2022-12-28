import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/sign_up_model.dart';

class SignUpUserServices {
  static Future<bool?> signUpUser(Map<String, dynamic> reqbody) async {
    http.Response response = await http.post(
        Uri.parse('https://codelineinfotech.com/student_api/User/signup.php'),
        body: reqbody);
    var result = jsonDecode(response.body);
    log('==${jsonDecode(response.body)}');
    return result['status'];
  }
}
