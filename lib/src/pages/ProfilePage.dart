// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

// Widgets
import '../widgets/CustomListTile.dart';

// Permissions
import '../permissions/PermissionsService.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotification = false;
  bool turnOnLocation = false;

  @override void initState() {
    super.initState();
    if(PermissionsService().hasLocationPermission() == true) {
      turnOnLocation = true;
    }
  }
  
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
              _buildProfileRow(),
              SizedBox(height: 30),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
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
                      ScopedModelDescendant<MainModel>(
                        builder: (BuildContext context, Widget child, MainModel model) {
                          return GestureDetector(
                            onTap: () {
                              model.logout();
                              Navigator.of(context).pushReplacementNamed("/");
                            },
                            child: CustomListTile(
                              icon: Icons.exit_to_app,
                              text: "Logout",
                            ),
                          );
                        } 
                      ),
                    ]                
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Permissions",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
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
                      Divider(height: 5, color: Colors.grey,),
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
                              PermissionsService().requestLocationPermission(
                                onPermissionDenied: () {
                                  print('Permission has been denied');
                                  turnOnLocation = false;
                                }
                              );
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

  Widget _buildProfileRow() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 4,
                    offset: Offset(1, 4),
                    color: Colors.black38
                  )
                ],
                image: DecorationImage(image: NetworkImage(model.user.picture))
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.user.name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 5),
                Container (
                  padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 3),
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(
                    model.user.userType, 
                    overflow: TextOverflow.ellipsis ,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  model.user.email,
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  model.user.phone,
                  style: TextStyle(
                    color: Colors.grey
                  ),
                ),
                SizedBox(height: 10),
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
        );
      }
    );
  }
}