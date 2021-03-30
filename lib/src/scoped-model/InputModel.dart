// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

// Detector Model
import '../models/Input.dart';

// JSON Convert
import 'dart:convert';

class InputModel extends Model {
  Input _inputById;
  List<Input> _inputs = [];
  List<Input> _inputsById = [];

  String _averageWLevel = "";
  String _lastUpdated = "";
  
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }

  Input get inputById {
    return _inputById;
  }
  
  List<Input> get inputs {
    return List.from(_inputs);
  }
  
  List<Input> get inputsById {
    return List.from(_inputsById);
  }

  String get averageWLevel {
    return _averageWLevel;
  }

  String get lastUpdated {
    return _lastUpdated;
  }

  void fetchInputs() async{
    _isLoading = true;
    
    notifyListeners();
    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/pages/getLatestInput/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Input> fetchedInputList = [];

        List<dynamic> responseData = jsonDecode(response.body);

        responseData[1]?.forEach((dynamic data) { 
          final Input input = Input(
            id: data["id"],
            detectorId: data['detector_id'],
            waterLevel: data['wLevel'],
            weather: data['weather'],
            temprature: data['temprature'],
            weatherDesc: data['weather_desc'],
            pressure: data['pressure'],
            humidity: data['humidity'],
            windSpeed: data['wind_speed'],
            windDir: data['wind_dir'],
            cloudiness: data['cloudiness'],
            rainVol: data['rain_vol'],
            timestamp: data['last_updated']
          );
          fetchedInputList.add(input);
        });
        _inputs = fetchedInputList;
        _averageWLevel = responseData[0][0];
        _lastUpdated = responseData[0][1];
        _isLoading = false;
        notifyListeners();
      }
    } catch(error) {
      print("Error " + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchInputById(String id) async{
    _isLoading = true;
    notifyListeners();

    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/detectors/getDetectorById/$id/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {

        dynamic responseData = jsonDecode(response.body);

        Input input = Input(
          detectorId: responseData['id'],
          waterLevel: responseData['wLevel'],
          weather: responseData['weather'],
          temprature: responseData['temprature'],
          weatherDesc: responseData['weather_desc'],
          pressure: responseData['pressure'],
          humidity: responseData['humidity'],
          windSpeed: responseData['wind_speed'],
          windDir: responseData['wind_dir'],
          cloudiness: responseData['cloudiness'],
          rainVol: responseData['rain_vol'],
          timestamp: responseData['api_timestamp']
        );
        _inputById = input;
        _isLoading = false;
        notifyListeners();
      }
    } catch(error) {
      print("Error " + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchInputsMonthlyHistory(String id, DateTime dateFrom, DateTime dateTo) async{
    _isLoading = true;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String newDateFrom = formatter.format(dateFrom);
    final String newDateTo = formatter.format(dateTo);
    
    notifyListeners();  
    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/pages/getInputMonthlyHistory/$id/$newDateFrom/$newDateTo/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Input> fetchedInputList = [];

        List<dynamic> responseData = jsonDecode(response.body);

        responseData?.forEach((dynamic data) { 
          final Input input = Input(
            waterLevel: data['wlevel'],
            weather: data['weather'],
            temprature: data['temprature'].toString(),
            pressure: data['pressure'].toString(),
            humidity: data['humidity'].toString(),
            windSpeed: data['wind_speed'].toString(),
            windDir: data['wind_dir'].toString(),
            cloudiness: data['cloudiness'].toString(),
            rainVol: data['rain_vol'].toString(),
            timestamp: data['date']
          );
          fetchedInputList.add(input);
        });
        _inputsById = fetchedInputList;
        _isLoading = false;
        notifyListeners();
      }
    } catch(error) {
      print("Error (InputModel):" + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchInputsDailyHistory(String id, DateTime date) async{
    _isLoading = true;

    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String newDate = formatter.format(date);
    notifyListeners();  
    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/pages/getInputsDailyHistory/$id/$newDate/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Input> fetchedInputList = [];

        List<dynamic> responseData = jsonDecode(response.body);

        responseData?.forEach((dynamic data) { 
          final Input input = Input(
            waterLevel: data['wlevel'],
            weather: data['weather'],
            temprature: data['temprature'].toString(),
            pressure: data['pressure'].toString(),
            humidity: data['humidity'].toString(),
            windSpeed: data['wind_speed'].toString(),
            windDir: data['wind_dir'].toString(),
            cloudiness: data['cloudiness'].toString(),
            rainVol: data['rain_vol'].toString(),
            timestamp: data['date']
          );
          fetchedInputList.add(input);
        });
        _inputsById = fetchedInputList;
        _isLoading = false;
        notifyListeners();
      }
    } catch(error) {
      print("Error (InputModel):" + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

}