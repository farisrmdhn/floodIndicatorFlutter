// Packages
import 'package:flutter/material.dart';

class NotificationTile extends StatelessWidget {

  final int type;
  final String detectorName;
  final String timestamp;

  NotificationTile({this.type, this.detectorName, this.timestamp});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(timestamp, style: TextStyle(fontSize: 12),),
        ListTile(
          title: type == 1 ? Text('Water level : Danger on $detectorName') : Text('Input Error on $detectorName'),
          trailing: type == 1 ? Icon(Icons.warning,color: Colors.red) : Icon(Icons.error,color: Colors.orange)
        ),
        Divider()
      ]
    );
  }
}