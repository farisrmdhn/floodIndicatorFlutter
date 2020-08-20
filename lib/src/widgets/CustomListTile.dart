import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {

  final IconData icon;

  final String text;

  CustomListTile({
    this.icon, this.text
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.grey,),
          SizedBox(width: 15),
          Text(text, style: TextStyle(fontSize: 16),)
        ],
      ),
    );
  }
}