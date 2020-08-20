// Packages
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {

  final int type;
  final String detectorName;

  NotificationTile({this.type, this.detectorName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: type == 1 ? Text('Water level : Danger on $detectorName') : Text('Input Error on $detectorName'),
          trailing: Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
        ),
        Divider()
      ]
    );
  }
}