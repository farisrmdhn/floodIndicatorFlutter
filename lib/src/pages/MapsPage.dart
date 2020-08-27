// ASYNC Programming
import 'dart:async';

// Packages
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

// Scoped Model - Main Model
import '../scoped-model/MainModel.dart';

class MapsPage extends StatefulWidget {

  final String id;

  MapsPage({this.id});

  @override
  _MapsPageState createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  Completer<GoogleMapController> _controller = Completer();

  Set<Marker> _markers(String name, String lat, String lng) {
    return {
      Marker(
        markerId: MarkerId(widget.id), 
        position: LatLng(double.parse(lat), double.parse(lng)),
        infoWindow: InfoWindow(
          title: widget.id,
          snippet: name
        ),
        icon: BitmapDescriptor.defaultMarker
      )
    };
  }

  CameraPosition _cameraPosition(String lat, String lng) {
    return CameraPosition(
      target: LatLng(double.parse(lat), double.parse(lng)),
      zoom: 15,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    if (!_controller.isCompleted) {
      _controller.complete(controller);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 490,
      child: _showMaps()
    );
  }

  Widget _showMaps() {
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
              SizedBox(height: 40),
              Center(
                child: CircularProgressIndicator(),
              ),
              SizedBox(height: 10),
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
        } else if(!model.isLoading && model.detectorById != null && model.inputById != null) {
          content = GoogleMap(
            initialCameraPosition: _cameraPosition(model.detectorById.latitude, model.detectorById.longitude),
            onMapCreated: _onMapCreated,
            markers: _markers(model.detectorById.name, model.detectorById.latitude, model.detectorById.longitude),
          );
        }
        return content;
      }
    );
  }
}