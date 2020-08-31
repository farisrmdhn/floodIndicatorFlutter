// Packages
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';

// ScopedModel - Main Model
import 'package:FloodIndicator/src/scoped-model/MainModel.dart';

class ChangePasswordScreen extends StatefulWidget {
  final MainModel model;

  ChangePasswordScreen({this.model});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {

  bool _toogleVisibility1 = true;
  bool _toogleVisibility2 = true;
  bool _toogleVisibility3 = true;

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 30,),
            Center(child: Text("Change your password", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            SizedBox(height: 30,),
            _buildOldTextField(),
            SizedBox(height: 10,),
            _buildNewTextField(),
            SizedBox(height: 10,),
            _buildConfirmTextField(),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 40 / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(width: 2, color: Colors.pinkAccent)
                    ),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.pinkAccent,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: () {
                    showLoadingIndicator(context, "Changing your password...");
                    onSubmit(widget.model.changePassword);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 40 / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.pinkAccent
                    ),
                    child: Center(
                      child: Text(
                        'Change',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOldTextField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Old Password",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,
        ),
        Container(
          width: 400,
          child: TextFormField(
            controller: oldPassword,
            decoration: InputDecoration(
              hintText: "Please input your password here",
              hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _toogleVisibility1 = !_toogleVisibility1;
                  });
                },
                icon: _toogleVisibility1 ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
              ),
            ),
            obscureText: _toogleVisibility1,
          ),
        ),
      ],
    );
  }

  Widget _buildNewTextField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "New Password",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,
        ),
        Container(
          width: 400,
          child: TextFormField(
            controller: newPassword,
            decoration: InputDecoration(
              hintText: "New password",
              hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _toogleVisibility2 = !_toogleVisibility2;
                  });
                },
                icon: _toogleVisibility2 ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
              ),
            ),
            obscureText: _toogleVisibility2,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmTextField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Confirm Password",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,
        ),
        Container(
          width: 400,
          child: TextFormField(
            controller: confirmPassword,
            validator: (val){
              if(val.isEmpty)
                    return 'Empty';
              if(val != newPassword.text)
                    return 'Not Match';
              return null;
            },
            decoration: InputDecoration(
              hintText: "Please re-enter your new password here",
              hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _toogleVisibility3 = !_toogleVisibility3;
                  });
                },
                icon: _toogleVisibility3 ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
              ),
            ),
            obscureText: _toogleVisibility3,
          ),
        ),
      ],
    );
  }

  Future<void> showLoadingIndicator(BuildContext context, String message) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(),
              SizedBox(
                width: 10.0,
              ),
              Text("$message"),
            ],
          ),
        );
      }
    );
  }

  void onSubmit(Function changePassword) {
    changePassword(oldPassword.text, newPassword.text, confirmPassword.text).then((final response) {
      if (!response['hasError']) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/main");
        } else {
          Navigator.of(context).pop();
          _showAlertDialog(response['message']);
        }
    });
  }

  Future<void> _showAlertDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message)
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}