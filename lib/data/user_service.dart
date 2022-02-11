import 'dart:convert';
import 'package:http_get_samples/model/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class UserService{
  final Uri url = Uri.parse('https://reqres.in/api/users?page=2');

  Future<UserModel?> fetchUsers() async{
    var res = await http.get(url);
    if(res.statusCode == 200){
      var jsonBody = UserModel.fromJson(jsonDecode(res.body));
      return jsonBody;
    }
    else{
      print('İstek başarısız oldu => ${res.statusCode}');
    }
  }
}