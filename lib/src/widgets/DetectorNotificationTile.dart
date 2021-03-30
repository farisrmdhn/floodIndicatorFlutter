// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

class DetectorNotificationTile extends StatefulWidget {
  final int type;
  final String id;
  final String detectorId;
  final String timestamp;
  final String isNew;

  DetectorNotificationTile({this.type, this.id, this.detectorId, this.timestamp, this.isNew});

  @override
  _DetectorNotificationTileState createState() => _DetectorNotificationTileState();
}

class _DetectorNotificationTileState extends State<DetectorNotificationTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shadowColor: Colors.grey,
      margin: EdgeInsets.only(bottom: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(widget.type == 1 ? Icons.warning : Icons.error, color: widget.type == 1 ? Colors.red : Colors.orange,),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.timestamp, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 5,),
                    Text(
                      widget.type == 1 ? 'Water level : Danger' : 'Input Error',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.isNew == "true" ? buildBtnOK() : buildBtnDelete(),
          ],
        ),
      ),
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

  void onSubmitOK(Function updateNotification) {
    updateNotification(widget.id, widget.detectorId).then((final response) {
      if (!response['hasError']) {
          // Navigator.of(context).pop();
          _showAlertDialog(response['message']);
        } else {
          // Navigator.of(context).pop();
          _showAlertDialog(response['message']);
        }
    });
  }

  void onSubmitDelete(Function deleteNotification) {
    deleteNotification(widget.id, widget.detectorId).then((final response) {
      if (!response['hasError']) {
          // Navigator.of(context).pop();
          _showAlertDialog(response['message']);
        } else {
          // Navigator.of(context).pop();
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
          title: Text('Action failed'),
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

  Widget buildBtnOK() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            // showLoadingIndicator(context, "Loading...");
            onSubmitOK(model.updateNotification);
          },
          child: Container(
            height: 30,
            width:50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text(
                "OK",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildBtnDelete() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            // showLoadingIndicator(context, "Loading...");
            onSubmitDelete(model.deleteNotification);
          },
          child: Container(
            height: 30,
            width:90,
            decoration: BoxDecoration(
              color:Colors.red,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Center(
              child: Text(
                "DELETE",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18
                ),
              ),
            ),
          ),
        );
      },
    );
  } 
}