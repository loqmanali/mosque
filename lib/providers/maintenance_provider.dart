import 'package:flutter/material.dart';

import '../models/maintenance_request.dart';

class MaintenanceProvider extends ChangeNotifier {
  final List<MaintenanceRequest> _requests = [];

  List<MaintenanceRequest> get requests => List.unmodifiable(_requests);

  void addRequest(MaintenanceRequest request) {
    _requests.add(request);
    notifyListeners();
  }

  void updateRequest(MaintenanceRequest request) {
    final index = _requests.indexWhere((r) => r.id == request.id);
    if (index != -1) {
      _requests[index] = request;
      notifyListeners();
    }
  }

  void deleteRequest(String id) {
    _requests.removeWhere((request) => request.id == id);
    notifyListeners();
  }

  List<MaintenanceRequest> getRequestsByPriority(String priority) {
    return _requests.where((request) => request.priority == priority).toList();
  }

  List<MaintenanceRequest> getRequestsByCategory(String category) {
    return _requests.where((request) => request.category == category).toList();
  }
}
