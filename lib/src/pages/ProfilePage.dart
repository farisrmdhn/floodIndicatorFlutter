// Packages
import 'package:flutter/material.dart';

// Widgets
import '../widgets/CustomListTile.dart';

// TODO - Permissions
// Permissions
// import '../permissions/PermissionsService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Profile',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(1, 4),
                          color: Colors.black38
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Faris Ramadhan",
                        style: TextStyle(
                          fontSize: 18,

                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "+628119207543",
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 25,
                        width:70,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.pinkAccent
                          ),
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Center(
                          child: Text(
                            "Edit",
                            style: TextStyle(
                              color: Colors.pinkAccent,
                              fontSize: 18
                            ),
                          ),
                        ),

                      ),
            

                    ],
                  )
                ],
              ),
              SizedBox(height: 30),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    children: <Widget> [
                      CustomListTile(
                        icon: Icons.lock,
                        text: "Change Password",
                      ),
                      Divider(height: 10, color: Colors.grey,),
                    ]                
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Permissions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: Column(
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Notification",
                            style: TextStyle(
                              fontSize: 16,
                              
                            ),
                          ),
                          Switch(value: turnOnNotification, onChanged: (bool value){
                            setState(() {
                              turnOnNotification = value;
                            });
                          }),
                        ],
                      ),
                      Divider(height: 10, color: Colors.grey,),
                      
                    ]
                  ),
                ),
              ),
              Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 4),
                  child: Column(
                    children: <Widget> [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Location",
                            style: TextStyle(
                              fontSize: 16,
                              
                            ),
                          ),
                          Switch(value: turnOnLocation, onChanged: (bool value){
                            setState(() {
                              turnOnLocation = value;
                              // TODO - Permissions
                              // PermissionsService().requestLocationPermission(
                              //   onPermissionDenied: () {
                              //     print('Permission has been denied');
                              //   }
                              // );
                            });
                          }),
                        ],
                      ),
                    ]
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}