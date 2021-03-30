// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

// Widgets
import '../widgets/DetectorNotificationTile.dart';

class DetectorNotificationsPage extends StatefulWidget {
  @override
  _DetectorNotificationsPageState createState() => _DetectorNotificationsPageState();
}

class _DetectorNotificationsPageState extends State<DetectorNotificationsPage> {
   @override
  Widget build(BuildContext context) {
    return _showNotifications();
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
        } else if(!model.isLoading && model.notificationsById.length > 0) {
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
        itemCount: model.notificationsById.length,
        itemBuilder: (BuildContext context, int index) {
          return DetectorNotificationTile(
            type: model.notificationsById[index].type,
            id: model.notificationsById[index].id,
            detectorId: model.notificationsById[index].detectorId,
            timestamp: model.notificationsById[index].timestamp,
            isNew: model.notificationsById[index].isNew,
          );
        },
      ),
    );
  }
}