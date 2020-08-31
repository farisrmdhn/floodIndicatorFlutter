// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

// ScopedModel - Main Model
import 'package:FloodIndicator/src/scoped-model/MainModel.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool _toogleVisibility = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Widget _buildEmailTextField(){
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Enter your email here',
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
                _buildSignInBtn(),
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
                        Navigator.of(context).pushNamed("/forgotPassword");
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

  Widget _buildSignInBtn() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () { 
            showLoadingIndicator(context, "Signing in...");
            onSubmit(model.login);
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 80 / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.pinkAccent
            ),
            child: Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Email / Password is not correct')
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

  void onSubmit(Function login) {
    login(emailController.text, passwordController.text).then((final response) {
      if (!response['hasError']) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/main");
        } else {
          Navigator.of(context).pop();
          _showAlertDialog();
        }
    });
  }
}