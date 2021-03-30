// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

// Detector Model
import '../models/Detector.dart';

// JSON Convert
import 'dart:convert';

class DetectorModel extends Model {
  List<Detector> _detectors = [];
  bool _isLoading = false;
  
  Detector _detectorById;
  
  bool get isLoading {
    return _isLoading;
  }
  
  List<Detector> get detectors {
    return List.from(_detectors);
  }

  Detector get detectorById {
    return _detectorById;
  }

  void fetchDetectors() async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/detectors/getDetectors/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Detector> fetchedDetectorList = [];

        List<dynamic> responseData = jsonDecode(response.body);

        responseData?.forEach((dynamic data) {
          final Detector detector = Detector(
            id: data["id"],
            name: data["name"],
            latitude: data["latitude"],
            longitude: data["longitude"],
          );
          fetchedDetectorList.add(detector);
        });
        _detectors = fetchedDetectorList;
        notifyListeners();
        _isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      print("Error " + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchDetectorById(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/detectors/getDetectorById/$id/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic responseData = jsonDecode(response.body);
        final Detector detector = Detector(
          id: responseData["id"],
          name: responseData["name"],
          latitude: responseData["latitude"],
          longitude: responseData["longitude"],
        );
        _detectorById = detector;
        _isLoading = false;
        notifyListeners();
      }
    } catch (error) {
      print("Error (DetectorModel):" + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }
}