import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class DeleteUserServices {
  static Future deleteuser(Map<String, dynamic> reqbody) async {
    http.Response response = await http.post(
        Uri.parse(
            'https://codelineinfotech.com/student_api/User/user_avatar_upload.php'),
        body: reqbody);

    var result = jsonDecode(response.body);
    log('==${jsonDecode(response.body)}');
    return result;
  }
}
