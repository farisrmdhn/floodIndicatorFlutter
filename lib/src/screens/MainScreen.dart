// Packages
import 'package:flutter/material.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

// Pages
import '../pages/DashboardPage.dart';
import '../pages/NotificationsPage.dart';
import '../pages/ProfilePage.dart';

class MainScreen extends StatefulWidget {
  final MainModel model;

  MainScreen({this.model});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  
  // Index for switching between tabs
  int currentTabIndex = 0;

  // Pages Init (Pages in MainScreen)
  DashboardPage dashboardPage;
  NotificationsPage notificationsPage;
  ProfilePage profilePage;

  // Init a list that contains all pages in this screen
  List<Widget> pages;

  // For containing page that shows
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    // Create an instance of all pages accesible by bottom navigation bar
    dashboardPage = DashboardPage();
    notificationsPage = NotificationsPage();
    profilePage = ProfilePage();

    // Put the pages to the list
    pages = [dashboardPage, notificationsPage, profilePage];

    // Default Page
    currentPage = dashboardPage;

    // Fetching Detectors and Inputs from Web
    widget.model.fetchDetectors();
    widget.model.fetchInputs();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index){
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem> [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: new Stack(
              children: <Widget>[
                new Icon(Icons.notifications),
                new Positioned(
                  right: 0,
                  child: new Container(
                    padding: EdgeInsets.all(1),
                    decoration: new BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: new Text(
                      "1",
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
            title: Text("Notifications")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile")
          ),
        ]
      ),
      body: currentPage,
    );
  }
}