import 'package:http/http.dart' as http;

import '../model/get_signup_model.dart';

class GetSignUpUserServices {
  static Future<Getsignupmodel?> getSignUpUser() async {
    http.Response response = await http.get(Uri.parse(
        "https://codelineinfotech.com/student_api/User/allusers.php"));

    var result = getsignupmodelFromJson(response.body);
    return result;
  }
}
