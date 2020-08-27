// Packages
import 'package:flutter/material.dart';

// Models
import 'package:FloodIndicator/src/models/Detector.dart';
import 'package:FloodIndicator/src/models/Input.dart';

class DetailsCard extends StatelessWidget {

  final Detector detector;

  final Input lastInput;

  DetailsCard({this.detector, this.lastInput});

  final TextStyle weatherDetailStyle = TextStyle(
    fontSize: 12.5
  );

  @override
  Widget build(BuildContext context) {
    String id = detector != null ? detector.id : "No Data";

    String wLevel = lastInput != null ? lastInput.waterLevel : "No Data";
    String weather = lastInput != null ? lastInput.weather : "No Data";
    String weatherDesc = lastInput != null ? lastInput.weatherDesc : "No Data";
    String pressure = lastInput != null ? lastInput.pressure : "No Data";
    String humidity = lastInput != null ? lastInput.humidity : "No Data";
    String temprature = lastInput != null ? lastInput.temprature : "No Data";
    String timestamp = lastInput != null ? lastInput.timestamp : "No Data";
    String windDir = lastInput != null ? lastInput.windDir : "No Data";
    String windSpeed = lastInput != null ? lastInput.windSpeed : "No Data";
    String cloudiness = lastInput != null ? lastInput.cloudiness : "No Data";

    return Card(
      elevation: 3,
      shadowColor: Colors.orange,
      child: Padding(
        padding: EdgeInsets.only(top:10, right: 10, left: 10, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  SizedBox(height: 2.5),
                  Container (
                    padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Text(
                      timestamp.toString(),
                      // overflow: TextOverflow.ellipsis ,
                      style: TextStyle(fontSize: 12.8, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    wLevel,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorPicker(lastInput.waterLevel),
                      fontSize: 50
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Column(
                    children: <Widget> [
                      SizedBox(height:10),
                      Image(
                        image: setImage(weather, timestamp),
                        height: 60,
                        width: 60,
                      ),
                      SizedBox(height:5),
                      Text(
                        weather,
                        overflow: TextOverflow.clip,
                        style: TextStyle(
                          fontSize:28,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(weatherDesc, style: TextStyle(fontSize: 13),),
                    ]
                  ),
                  SizedBox(width: 6.8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start ,
                    children: <Widget> [
                      SizedBox(height: 10),
                      Text("Temprature: $temprature \u2103", style: weatherDetailStyle,),
                      SizedBox(height: 4),
                      Text("Pressure: $pressure hPa", style: weatherDetailStyle,),
                      SizedBox(height: 4),
                      Text("Humidity: $humidity %", style: weatherDetailStyle,),
                      SizedBox(height: 4),
                      Text("Cloudiness: $cloudiness %", style: weatherDetailStyle,),
                      SizedBox(height: 4),
                      Text("Wind Speed $windSpeed m/s", style: weatherDetailStyle,),
                      SizedBox(height: 4),
                      Text("Wind Direction: $windDir \u2103", style: weatherDetailStyle,),
                    ]
                  ),
                ]
              ),
            ),
          ],
        ),
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

  AssetImage setImage(weather, timestamp) {
    var day = 'day';

    if(timestamp != "No Data") {
      DateTime datetime = DateTime.parse(timestamp);
      if(datetime.hour < 6 || datetime.hour >= 18) {
        day = 'night';
      }
    }

    if(weather == 'Clear'){
      return AssetImage('assets/images/weather/clear_$day.png');
    } else if(weather == 'Clouds') {
      return AssetImage('assets/images/weather/cloudy_$day.png');
    } else if(weather == 'Rain') {
      return AssetImage('assets/images/weather/rainy_$day.png');
    } else if(weather == 'Haze') {
      return AssetImage('assets/images/weather/haze_$day.png');
    } else {
      return AssetImage('assets/images/weather/storm_$day.png');
    }
  }
}