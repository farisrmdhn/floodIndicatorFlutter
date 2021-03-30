// Packages
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;

// Detector Model
import '../models/Notification.dart';

// JSON Convert
import 'dart:convert';

class NotificationModel extends Model {
  List<Notification> _notifications = [];
  List<Notification> _notificationsById = [];
  
  bool _isLoading = false;

  bool get isLoading {
    return _isLoading;
  }
  
  List<Notification> get notifications {
    return List.from(_notifications);
  }
  
  List<Notification> get notificationsById {
    return List.from(_notificationsById);
  }

  void fetchNotifications() async{
    _isLoading = true;
    
    notifyListeners();
    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/notifications/getNotifications/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Notification> fetchedNotificationList = [];

        List<dynamic> responseData = jsonDecode(response.body);

        responseData?.forEach((dynamic data) { 
          final Notification notification = Notification(
            id: data["id"],
            detectorId: data["detector_id"],
            type: int.parse(data["type"]),
            isNew: data["is_new"],
            timestamp: data['timestamp']
          );
          fetchedNotificationList.add(notification);
        });
        _notifications = fetchedNotificationList;
        _isLoading = false;
        notifyListeners();
      }
    } catch(error) {
      print("Error (NotificationModel): " + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  void fetchNotificationsbyId(String id) async{
    _isLoading = true;
    notifyListeners();
    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/notifications/getNotificationsById/$id/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Notification> fetchedNotificationList = [];

        List<dynamic> responseData = jsonDecode(response.body);

        responseData?.forEach((dynamic data) { 
          final Notification notification = Notification(
            id: data["id"],
            detectorId: data["detector_id"],
            type: int.parse(data["type"]),
            isNew: data["is_new"],
            timestamp: data['timestamp']
          );
          fetchedNotificationList.add(notification);
        });
        _notificationsById = fetchedNotificationList;
        _isLoading = false;
        notifyListeners();
      }
    } catch(error) {
      print("Error (NotificationModel): " + error.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> updateNotification(String id,  String detectorId) async{
    _isLoading = true;
    notifyListeners();

    String message;
    bool hasError = false;

    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/notifications/updateNotification/$id/$detectorId/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Notification> fetchedNotificationList = [];

        List<dynamic> responseData = jsonDecode(response.body);

        responseData?.forEach((dynamic data) { 
          final Notification notification = Notification(
            id: data["id"],
            detectorId: data["detector_id"],
            type: int.parse(data["type"]),
            isNew: data["is_new"],
            timestamp: data['timestamp']
          );
          fetchedNotificationList.add(notification);
          message = "Notification updated";
        });
        _notificationsById = fetchedNotificationList;
      } else {
        message = 'Failed to read notification';
        hasError = true;
      }
      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError
      };
    } catch(error) {
      print("Error (NotificationModel): " + error.toString());
      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError
      };
    }
  }

  Future<Map<String, dynamic>> deleteNotification(String id,  String detectorId) async{
    _isLoading = true;
    notifyListeners();

    String message;
    bool hasError = false;

    try {
      http.Response response = await http.get('http://192.168.1.100/floodIndicator/notifications/deleteNotification/$id/$detectorId/b6353c2d-1ddd-4f41-8920-edc9cc66dae8');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<Notification> fetchedNotificationList = [];

        List<dynamic> responseData = jsonDecode(response.body);
        responseData?.forEach((dynamic data) { 
          final Notification notification = Notification(
            id: data["id"],
            detectorId: data["detector_id"],
            type: int.parse(data["type"]),
            isNew: data["is_new"],
            timestamp: data['timestamp']
          );
          fetchedNotificationList.add(notification);
          message = "Notification deleted";
        });
        _notificationsById = fetchedNotificationList;
      } else {
        message = 'Failed to delete notification';
        hasError = true;
      }
      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError
      };
    } catch(error) {
      print("Error (NotificationModel): " + error.toString());
      _isLoading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError
      };
    }
  }
}