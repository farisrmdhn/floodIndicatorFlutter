// Packages
import 'package:flutter/material.dart';

// ScopedModel - Main Model
import 'package:FloodIndicator/src/scoped-model/MainModel.dart';

class EditProfileScreen extends StatefulWidget {
  final MainModel model;

  EditProfileScreen({this.model});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  bool _toogleVisibility = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget _buildEmailTextField(){
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Your email or username',
        hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        hintText: 'Password',
        hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toogleVisibility = !_toogleVisibility;
            });
          },
          icon: _toogleVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
        ),
      ),
      obscureText: _toogleVisibility,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Image(
                    image: AssetImage('assets/images/logo.png')
                  ),
                  height: 120,
                ),
                SizedBox(height: 20,),
                Text("Sign In", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                SizedBox(height: 20,),
                Card(
                  elevation: 5,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        _buildEmailTextField(),
                        SizedBox(height: 10),
                        _buildPasswordTextField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24,),
                Divider(height: 25, color: Colors.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Forgot your password?",
                      style: TextStyle(
                        color: Color(0xFFBDC2CB),
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                      },
                      child: Text(
                        "Click here",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ) ,
        );
  }
}