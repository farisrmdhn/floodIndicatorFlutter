// Packages
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

// Pages
import '../pages/DetailsPage.dart';
import '../pages/MapsPage.dart';
import '../pages/DetectorNotificationsPage.dart';

class DetailsScreen extends StatefulWidget {
  final String id;
  final MainModel model;

  DetailsScreen({this.id, this.model});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  // Pages Init
  DetailsPage detailsPage;
  MapsPage mapsPage;
  DetectorNotificationsPage detectorNotificationsPage;
  Widget currentPage;

  // Custom Navbar
  static TextStyle selectedNavStyle = TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pinkAccent);
  static TextStyle defaultNavStyle = TextStyle(fontSize: 24);
  TextStyle detailsNavStyle = selectedNavStyle;
  TextStyle mapsNavStyle = defaultNavStyle;
  TextStyle notificationsNavStyle = defaultNavStyle;

  @override
  void initState() {
    super.initState();
    // Create an instance of all pages accesible by upper navigation bar
    detailsPage = DetailsPage();
    mapsPage = MapsPage(id: widget.id,);
    detectorNotificationsPage = DetectorNotificationsPage();

    // Default Page
    currentPage = detailsPage;

    print("Detector ${widget.id} details screen");

    // Fetching Detectors and Inputs from Web
    widget.model.fetchDetectorById(widget.id);
    widget.model.fetchInputById(widget.id);
    widget.model.fetchInputsMonthlyHistory(widget.id, DateTime.now().add(new Duration(days: -30)), DateTime.now());
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          height: 50,
          width:MediaQuery.of(context).size.width * 90 / 100,
          decoration: BoxDecoration(
            color: Colors.pinkAccent,
            borderRadius: BorderRadius.circular(25)
          ),
          child: Center(
            child: Text(
              "Back",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                _showName(),
                _showRefreshBtn(),
              ]
            ),
            Row(
              children: <Widget> [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      detailsNavStyle = selectedNavStyle;
                      mapsNavStyle = defaultNavStyle;
                      notificationsNavStyle = defaultNavStyle;
                      currentPage = detailsPage;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Details',
                      style: detailsNavStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      detailsNavStyle = defaultNavStyle;
                      mapsNavStyle = selectedNavStyle;
                      notificationsNavStyle = defaultNavStyle;
                      currentPage = mapsPage;
                    });
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text(
                      'Maps',
                      style: mapsNavStyle,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      detailsNavStyle = defaultNavStyle;
                      mapsNavStyle = defaultNavStyle;
                      notificationsNavStyle = selectedNavStyle;
                      currentPage = detectorNotificationsPage;
                    });},
                  child: Text(
                    'Notifications',
                    style: notificationsNavStyle,
                  ),
                ),
                Spacer(),
              ]
            ),
            SizedBox(height: 10),
            currentPage,
          ],
        ),
      ),
    );
  }

  Widget _showName() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 42.0, bottom: 10),
              child: Text(
                "No Data",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        if (model.isLoading) {
          content = Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 42.0, bottom: 10),
              child: Text(
                "Loading..",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        } else if(!model.isLoading && model.detectorById.name != null) {
          content = Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 42.0, bottom: 10),
              child: Text(
                model.detectorById.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          );
        }
        return content;
      }
    );
  }

  Widget _showRefreshBtn() {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        Widget content = Padding(
          padding: const EdgeInsets.only(right: 12, bottom: 10),
          child: GestureDetector(
            child: Icon(
              Icons.refresh, 
              color: Colors.pinkAccent, 
              size: 30, 
            )
          ),
        );
        if(!model.isLoading && model.detectorById.name != "") {
          content = Padding(
            padding: const EdgeInsets.only(right: 12, bottom: 10),
            child: GestureDetector(
              onTap: () {
                model.fetchDetectorById(widget.id);
              },
              child: Icon(
                Icons.refresh, 
                color: Colors.pinkAccent, 
                size: 30, 
              )
            ),
          );
        }
        return content;
      }
    );
  }
}