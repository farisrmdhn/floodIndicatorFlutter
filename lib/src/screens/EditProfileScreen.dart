// Packages
import 'package:flutter/material.dart'; 
import 'package:flutter/services.dart';

// ScopedModel - Main Model
import 'package:FloodIndicator/src/scoped-model/MainModel.dart';

class EditProfileScreen extends StatefulWidget {
  final MainModel model;

  EditProfileScreen({this.model});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30,),
            Center(child: Text("Edit Profile", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
            SizedBox(height: 30,),
            _buildNameTextField(),
            _buildPhoneTextField(),
            _buildAddressTextField(),
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
                    showLoadingIndicator(context, "Updating your profile...");
                    onSubmit(widget.model.editProfile);
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
                        'Confirm',
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
      ) ,
    );
  }

  Widget _buildNameTextField(){
    return Row(
      children: [
        Text(
          "Name",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,
        ),
        SizedBox(width: 40),
        Container(
          width: 300,
          child: TextFormField(
            controller: nameController..text = widget.model.user.name,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneTextField(){
    return Row(
      children: [
        Text(
          "Phone",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,
        ),
        SizedBox(width: 32),
        Container(
          width: 300,
          child: TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
            ],
            controller: phoneController..text = widget.model.user.phone,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressTextField(){
    return Row(
      children: [
        Text(
          "Address",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold) ,
        ),
        SizedBox(width: 20),
        Container(
          width: 300,
          child: TextFormField(
            maxLines: 2,
            controller: addressController..text = widget.model.user.address,
            decoration: InputDecoration(
              hintStyle: TextStyle(color: Color(0xFFBDC2CB), fontSize: 18),
            ),
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

  void onSubmit(Function editProfile) {
    editProfile(nameController.text, phoneController.text, addressController.text).then((final response) {
      if (!response['hasError']) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/main");
        } else {
          Navigator.of(context).pop();
          _showAlertDialog();
        }
    });
  }

  Future<void> _showAlertDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Unable to update your profile')
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