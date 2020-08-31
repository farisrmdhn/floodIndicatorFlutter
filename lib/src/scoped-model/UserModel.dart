// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

// Detector Model
import '../models/User.dart';

// JSON Convert
import 'dart:convert';

class UserModel extends Model {
  // User _user;
  User _user = User(
    id: "U-003",
    name: "Mark Cuban",
    email: "mark@gmail.com",
    phone: "0817654321",
    address: "St. Mavericks 6C/F3, Dallas, TX",
    picture: "http://192.168.43.22/floodIndicator/assets/images/profile/myAvatar.png",
    userType: "User",
  );
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

  Future<Map<String, dynamic>> editProfile(String name, String phone, String address) async {
    _isLoading = true;
    notifyListeners();

    String message;
    bool hasError = false;

    var url = 'http://192.168.43.22/floodIndicator/Users/editProfile/b6353c2d-1ddd-4f41-8920-edc9cc66dae8';
    var data = {'id': _user.id, 'name': name, 'phone': phone, 'address': address};
    try {
      http.Response response = await http.post(url, body: json.encode(data));
       if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if(responseData["success"] == true) {
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
          message = "Profile updated successfully";
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

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    _isLoading = true;
    notifyListeners();

    String message;
    bool hasError = false;

    var url = 'http://192.168.43.22/floodIndicator/Users/forgotPassword/b6353c2d-1ddd-4f41-8920-edc9cc66dae8';
    var data = {'email': email};

    try {
      http.Response response = await http.post(url, body: json.encode(data));
       if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        if(responseData["success"] == true) {
          message = "Success";
        } else {
          message = "Failed";
          hasError = true;
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

  Future<Map<String, dynamic>> changePassword(String oldPassword, String newPassword, String confirmPassword) async {
    _isLoading = true;
    notifyListeners();

    String message;
    bool hasError = false;

    if(newPassword.length < 6) {
      _isLoading = false;
      notifyListeners();
      return {
        'message': "Your new password must be 6 character or more",
        'hasError': true
      };
    }else if(newPassword != confirmPassword) {
      _isLoading = false;
      notifyListeners();
      return {
        'message': "Your password confirmation did not match your new password",
        'hasError': true
      };
    }

    oldPassword =  md5.convert(utf8.encode(oldPassword)).toString();
    newPassword =  md5.convert(utf8.encode(newPassword)).toString();

    var url = 'http://192.168.43.22/floodIndicator/Users/changePassword/b6353c2d-1ddd-4f41-8920-edc9cc66dae8';
    var data = {'id': _user.id, 'old_password': oldPassword, 'new_password': newPassword};
    try {
      http.Response response = await http.post(url, body: json.encode(data));
       if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        print(response.body);
        if(responseData["success"] == true) {
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
          message = "Password changed successfully";
          _user = user;
        } else {
          message = responseData['message'];
          hasError = true;
          _user = _user;
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
        'message': 'Failed to Change Password successfully',
        'hasError': !hasError
      };
    }
  }
}