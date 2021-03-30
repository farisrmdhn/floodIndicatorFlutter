// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// Widgets
import '../widgets/DetectorTile.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  String _title = "Dashboard";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  _title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 180),
                ScopedModelDescendant<MainModel>(
                  builder: (BuildContext context, Widget child, MainModel model) {
                    return  GestureDetector(
                      onTap: () {
                        print("Refreshing Dashboard...");
                        model.fetchDetectors();
                        model.fetchInputs();
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
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Text(
                  'Water Level : ',
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
                SizedBox(width: 5,),
                _showAVGWaterLevel(),
              ],
            ),
            SizedBox(height: 5),
            Row(
              children: <Widget>[
                Text(
                  'Last Updated on ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                _showLastUpdated(),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Latest Input',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            _showDetectorCards(),
          ]
        )
      )
    );
  }

  Widget _showAVGWaterLevel() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Text(
          'No Data',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),
        );
        if (model.isLoading) {
          content = Text(
            'Loading...',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          );
        } else if(!model.isLoading && model.averageWLevel != "") {
          content = Text(
            model.averageWLevel,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: colorPicker(model.averageWLevel)
            ),
          );
        }
        return content;
      }
    );
  }

  Widget _showLastUpdated() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Text(
          'No Data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey
          ),
        );
        if (model.isLoading) {
          content = Text(
            'Loading...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          );
        } else if(!model.isLoading && model.lastUpdated != "") {
          content = Text(
            model.lastUpdated,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return content;
      }
    );
  }

  Widget _showDetectorCards() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Text(
          'No Data',
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
        } else if(!model.isLoading && model.detectors.length > 0 && model.inputs.length > 0) {
          content = _detectorBuilder(model);
        }
        return content;
      }
    );
  }

  Widget _detectorBuilder (MainModel model){
    return Container(
      height: MediaQuery.of(context).size.height * 57 / 100,
      child: ListView.builder(
        itemCount: model.detectors.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/details', arguments: model.detectors[index].id);
            },
            child: DetectorTile(
              id: model.detectors[index].id,
              name: model.detectors[index].name,
              latitude: model.detectors[index].latitude,
              longitude: model.detectors[index].longitude,
              lastInput: model.inputs.lastWhere((element) => element.detectorId == model.detectors[index].id, orElse: () => null),
            ),
          );
        },
      ),
    );
  }

  MaterialColor colorPicker(wLevel) {
    if(wLevel == 'SAFE') {
      return Colors.green;
    } else if(wLevel == 'WARNING') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}