// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

// ScopedModel - Main Model
import 'package:FloodIndicator/src/scoped-model/MainModel.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final MainModel model;

  ForgotPasswordScreen({this.model});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  TextEditingController emailController = TextEditingController();

  Widget _buildEmailTextField(){
    return TextFormField(
      controller: emailController,
      decoration: InputDecoration(
        hintText: 'Enter your email here',
        hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 85),
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
              Text("Reset your password", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 10,),
              Card(
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Text("Send password reset request via email. Please enter your email below:", style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
                      SizedBox(height: 20,),
                      _buildEmailTextField(),
                      SizedBox(height: 20,),
                      _buildSendButton(),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24,),
              Divider(height: 25, color: Colors.grey,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Back to login",
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
        ),
        ]
      ) ,
    );
  }

  Widget _buildSendButton() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            showLoadingIndicator(context, "Sending to your email...");
            onSubmit(model.forgotPassword);
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
                'Send Request',
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

  Future<void> _showAlertDialog(bool sent) async {
    String title = "Request Sent";
    String message = "Your password reset request has been sent. Please check your email.";
    if(sent == false) {
      title = "Request Failed";
      message = "Your password reset request has failed. Please check the entered email";
    }
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
                if(sent == false) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.of(context).pushReplacementNamed("/");
                }
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

  void onSubmit(Function forgotPassword) {
    forgotPassword(emailController.text).then((final response) {
      if (!response['hasError']) {
          Navigator.of(context).pop();
          _showAlertDialog(true);
        } else {
          Navigator.of(context).pop();
          _showAlertDialog(false);
        }
    });
  }
}