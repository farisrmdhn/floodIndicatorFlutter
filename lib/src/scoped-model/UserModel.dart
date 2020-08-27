// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

// Detector Model
import '../models/User.dart';

// JSON Convert
import 'dart:convert';

class UserModel extends Model {
  User _user;
  bool _isLoading = false;
  
  bool get isLoading {
    return _isLoading;
  }

  User get user {
    return _user;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    String message;
    bool hasError = false;

    var url = 'http://192.168.43.22/floodIndicator/Users/userLogin/b6353c2d-1ddd-4f41-8920-edc9cc66dae8';
    var data = {'email': email, 'password': password};

    try {
      http.Response response = await http.post(url, body: json.encode(data));
       if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if(responseData["login"] == true) {
          String uType;
          if(responseData["user_type"] == "0") {
            uType = "Administrator";
          } else {
            uType = "User";
          }
          final User user = User(
            id: responseData["id"],
            name: responseData["name"],
            email: responseData["email"],
            phone: responseData["phone"],
            address: responseData["address"],
            picture: responseData["picture"],
            userType: uType,
          );
          message = "Sign in successfully";
          _user = user;
        } else {
          hasError = true;
          _user = null;
        }
      }
      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError
      };
    } catch (error) {
      print("Error (UserModel):" + error.toString());
      _isLoading = false;
      notifyListeners();

      return {
        'message': 'Failed to sign up successfully',
        'hasError': !hasError
      };
    }
  }

  void logout() {
    _user = null;
  }
}