// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

// Widget
import '../widgets/NotificationTile.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget> [
             Row(
              children: <Widget>[
                Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 155),
                ScopedModelDescendant<MainModel>(
                  builder: (BuildContext context, Widget child, MainModel model) {
                    return  GestureDetector(
                      onTap: () {
                        print("Refreshing Notification Page...");
                        model.fetchNotifications();
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.refresh, color: Colors.pinkAccent, size: 30,),
                        ],
                      ),
                    );
                  }
                )
              ],
            ),
            SizedBox(height: 10),
            _showNotifications(),
          ],
        ),
      ),
    );
  }

  Widget _showNotifications() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Text(
          'Empty',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.grey
            
          ),
        );
        if (model.isLoading) { 
          content = Column(
            children: <Widget>[
              SizedBox(height: 50),
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 25),
              Text(
                'Loading ...',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey
                ),
              )
            ],
          );
        } else if(!model.isLoading && model.notifications.length > 0) {
          content = _buildList(model);
        }
        return content;
      }
    );
  }

  Widget _buildList(MainModel model) {
    return Container(
      height: MediaQuery.of(context).size.height * 70 / 100,
      child: ListView.builder(
        itemCount: model.notifications.length,
        itemBuilder: (BuildContext context, int index) {
          var detectorName = model.detectors.lastWhere((element) => element.id == model.notifications[index].detectorId, orElse: () => null).name;
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/details', arguments: model.notifications[index].detectorId);
            },
            child: NotificationTile(
              type: model.notifications[index].type,
              detectorName: detectorName,
              timestamp: model.notifications[index].timestamp
            ),
          );
        },
      ),
    );
  }

}