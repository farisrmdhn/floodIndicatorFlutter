// Packages
import 'package:flutter/material.dart';

// Models
import '../models/Input.dart';

class DetectorTile extends StatelessWidget {

  final String id;
  final String name;
  final String latitude;
  final String longitude;
  final Input lastInput;

  DetectorTile({ this.id, this.name, this.latitude, this.longitude, this.lastInput});

  @override
  Widget build(BuildContext context) {
    String weather = lastInput != null ? lastInput.weather : "No Data";
    String humidity = lastInput != null ? lastInput.humidity : "No Data";
    String temprature = lastInput != null ? lastInput.temprature : "No Data";
    String timestamp = lastInput != null ? lastInput.timestamp : "No Data";
    String day = 'day';
    String image = 'assets/images/weather/storm_day.png';

    // TODO - Implement image selector with a function
    if(timestamp != "No Data") {
      DateTime datetime = DateTime.parse(timestamp);
      if(datetime.hour < 6 || datetime.hour >= 18) {
        day = 'night';
      }
    }
    

    if(weather == 'Clear'){
      image = 'assets/images/weather/clear_$day.png';
    } else if(weather == 'Clouds') {
      image = 'assets/images/weather/cloudy_$day.png';
    } else if(weather == 'Rain') {
      image = 'assets/images/weather/rainy_$day.png';
    } else if(weather == 'Haze') {
      image = 'assets/images/weather/haze_$day.png';
    } else {
      image = 'assets/images/weather/storm_$day.png';
    }

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Card(
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container (
                        child: Text(
                          name, 
                          overflow: TextOverflow.ellipsis ,
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 20
                          ),
                        )
                      ),
                      SizedBox(width: 5),
                      Container (
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Text(
                          id, 
                          overflow: TextOverflow.ellipsis ,
                          style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Container (
                    padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(
                      "Last Updated: $timestamp", 
                      overflow: TextOverflow.ellipsis ,
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container (
                    padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
                    child: Text(
                      "Location : $latitude, $longitude", 
                      overflow: TextOverflow.ellipsis ,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 5),
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage(image),
                              height: 60,
                              width: 60,
                            ),
                            SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Temprature: $temprature \u2103"),
                                Text("Humidity: $humidity %"),
                                Text('Weather: $weather', style: TextStyle(fontWeight: FontWeight.bold),),
                              ] 
                            ),
                            Container(
                              constraints: BoxConstraints(minWidth: 120),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(height: 27.5),
                                  Text(
                                    lastInput.waterLevel, 
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: colorPicker(lastInput.waterLevel),
                                      fontSize: 24
                                    ),
                                  ),
                                ] 
                              ),
                            ),
                          ],
                        )
                      ),
                    ]
                  ),
                ],
              ),
            ],
          ),
        )
      )
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