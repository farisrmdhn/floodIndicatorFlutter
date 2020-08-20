// Packages
import 'package:flutter/material.dart';

// Widget
import '../widgets/NotificationTile.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

// TODO - All Notifications Function

class _NotificationsPageState extends State<NotificationsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),

            _buildList(),
          ],
        ),
      ),
    );
  }

  Widget _buildList() {
    return Container(
      height: MediaQuery.of(context).size.height * 70 / 100,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return NotificationTile(
            type: 1,
            detectorName: "Ciliwung Ancol"
          );
        },
      ),
    );
  }

}