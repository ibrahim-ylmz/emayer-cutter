import 'dart:async';
import 'dart:developer';
import 'api_service.dart';

class SystemService {
  static final SystemService _instance = SystemService._internal();
  factory SystemService() => _instance;
  SystemService._internal();

  final ApiService _apiService = ApiService();
  Timer? _timer;

  /// Start periodic system status requests
  void startPeriodicRequest() {
    log('Starting periodic system status requests');
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      getSystemStatus();
    });
  }

  /// Stop periodic system status requests
  void stopPeriodicRequest() {
    log('Stopping periodic system status requests');
    _timer?.cancel();
    _timer = null;
  }

  /// Get system status from API
  Future<Map<String, dynamic>?> getSystemStatus() async {
    try {
      final response = await _apiService.getSystemStatus();
      
      if (response.statusCode == 200) {
        if (response.data == null) return null;
        log('System status received: ${response.data}');
        return response.data;
      } else {
        log('Failed to get system status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error getting system status: $e');
      return null;
    }
  }

  /// Send power control request
  Future<bool> sendPowerRequest(bool isPowerOn) async {
    try {
      final response = await _apiService.sendPowerRequest(isPowerOn);
      
      if (response.statusCode == 200) {
        log('Power request sent successfully: ${isPowerOn ? "ON" : "OFF"}');
        return true;
      } else {
        log('Failed to send power request: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error sending power request: $e');
      return false;
    }
  }

  /// Send vacuum control request
  Future<bool> sendVacuumRequest(bool isVacuumOn) async {
    try {
      final response = await _apiService.sendVacuumRequest(isVacuumOn);
      
      if (response.statusCode == 200) {
        log('Vacuum request sent successfully: ${isVacuumOn ? "ON" : "OFF"}');
        return true;
      } else {
        log('Failed to send vacuum request: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error sending vacuum request: $e');
      return false;
    }
  }

  /// Send lights control request
  Future<bool> sendLightsRequest(bool isLightsOn) async {
    try {
      final response = await _apiService.sendLightsRequest(isLightsOn);
      
      if (response.statusCode == 200) {
        log('Lights request sent successfully: ${isLightsOn ? "ON" : "OFF"}');
        return true;
      } else {
        log('Failed to send lights request: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error sending lights request: $e');
      return false;
    }
  }

  /// Get status value from API
  Future<Map<String, dynamic>?> getStatusValue() async {
    try {
      final response = await _apiService.getStatusValue();
      
      if (response.statusCode == 200) {
        log('Status value received: ${response.data}');
        return response.data;
      } else {
        log('Failed to get status value: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Error getting status value: $e');
      return null;
    }
  }

  /// Send speed decrease request
  Future<bool> sendSpeedDecrease() async {
    try {
      final response = await _apiService.sendSpeedDecrease();
      
      if (response.statusCode == 200) {
        log('Speed decrease request sent successfully');
        return true;
      } else {
        log('Failed to send speed decrease request: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error sending speed decrease request: $e');
      return false;
    }
  }

  /// Send speed increase request
  Future<bool> sendSpeedIncrease() async {
    try {
      final response = await _apiService.sendSpeedIncrease();
      
      if (response.statusCode == 200) {
        log('Speed increase request sent successfully');
        return true;
      } else {
        log('Failed to send speed increase request: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error sending speed increase request: $e');
      return false;
    }
  }

  /// Send torque decrease request
  Future<bool> sendTorqueDecrease() async {
    try {
      final response = await _apiService.sendTorqueDecrease();
      
      if (response.statusCode == 200) {
        log('Torque decrease request sent successfully');
        return true;
      } else {
        log('Failed to send torque decrease request: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error sending torque decrease request: $e');
      return false;
    }
  }

  /// Send torque increase request
  Future<bool> sendTorqueIncrease() async {
    try {
      final response = await _apiService.sendTorqueIncrease();
      
      if (response.statusCode == 200) {
        log('Torque increase request sent successfully');
        return true;
      } else {
        log('Failed to send torque increase request: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Error sending torque increase request: $e');
      return false;
    }
  }

  /// Dispose resources
  void dispose() {
    stopPeriodicRequest();
  }
}
