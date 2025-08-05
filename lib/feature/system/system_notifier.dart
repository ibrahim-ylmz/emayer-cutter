import 'dart:async';
import 'dart:developer';
import 'package:emayer_cutter/core/service/system_service.dart';
import 'package:emayer_cutter/feature/system/models/system_status_model.dart';
import 'package:emayer_cutter/feature/system/models/system_value_model.dart';

import 'package:flutter/material.dart';

class SystemNotifier with ChangeNotifier {
  final SystemService _systemService = SystemService();
  bool _isPowerOn = false;
  bool get isPowerOn => _isPowerOn;
  void changeIsPowerOn(bool value) {
    _isPowerOn = value;
    notifyListeners();
  }

  bool _isVacuumOn = false;
  bool get isVacuumOn => _isVacuumOn;
  void changeIsVacuumOn(bool value) {
    _isVacuumOn = value;
    notifyListeners();
  }

  bool _isLightsOn = false;
  bool get isLightsOn => _isLightsOn;
  void changeIsLightsOn(bool value) {
    _isLightsOn = value;
    notifyListeners();
  }

  bool _isShowGifOn = false;
  bool get isShowGifOn => _isShowGifOn;
  void changeIsShowGifOn(bool value) {
    _isShowGifOn = value;
    notifyListeners();
  }

  bool _isOpenedGif = false;
  bool get isOpenedGif => _isOpenedGif;
  void changeIsOpenedOn(bool value) {
    _isOpenedGif = value;
    notifyListeners();
  }

  int _speedValue = 0;
  int get speedValue => _speedValue;
  void changeSpeedValue(int value) {
    _speedValue = value;
    notifyListeners();
  }

  int _torqueValue = 0;
  int get torqueValue => _torqueValue;
  void changeTorqueValue(int value) {
    _torqueValue = value;
    notifyListeners();
  }

  SystemStatus _systemStatus = SystemStatus();
  SystemStatus get systemStatus => _systemStatus;
  void updateSystemStatus(SystemStatus status) {
    _systemStatus = status;
    notifyListeners();
  }

  SystemValue _systemValue = SystemValue();
  SystemValue get systemValue => _systemValue;
  void updateSystemValue(SystemValue value) {
    _systemValue = value;
    notifyListeners();
  }

  bool _firstInit = false;
  bool get firstInit => _firstInit;
  void changeFirstInit(bool value) {
    _firstInit = value;
    notifyListeners();
  }

  /// Start periodic system status requests
  void startPeriodicRequest() {
    _systemService.startPeriodicRequest();
  }

  /// Stop periodic system status requests
  void stopPeriodicRequest() {
    _systemService.stopPeriodicRequest();
  }

  /// Get system status from API
  Future<void> getSystemStatus() async {
    final data = await _systemService.getSystemStatus();
    if (data != null) {
      final status = SystemStatus.fromJson(data);
      log(status.toString());
      updateSystemStatus(status);

      changeIsPowerOn(status.message?.power ?? false);
      changeIsVacuumOn(status.message?.vacuum ?? false);
      changeIsLightsOn(status.message?.lights ?? false);

      if (!firstInit) {
        changeFirstInit(true);
        if (isPowerOn) {
          startPeriodicRequest();
        }
      }

      log(isPowerOn.toString());
    }
  }

  /// Send power control request
  Future<bool> sendPowerOnRequest(bool isPowerOn) async {
    final success = await _systemService.sendPowerRequest(isPowerOn);
    if (success) {
      if (isPowerOn) {
        changeIsPowerOn(true);
        getSystemStatus();
        startPeriodicRequest();
      } else {
        changeIsPowerOn(false);
        stopPeriodicRequest();
        sendVacuumOnRequest(false);
        sendLightsOnRequest(false);
      }
      return true;
    } else {
      return false;
    }
  }

  /// Send lights control request
  Future<bool> sendLightsOnRequest(bool isLightsOn) async {
    final success = await _systemService.sendLightsRequest(isLightsOn);
    if (success) {
      if (isLightsOn) {
        changeIsLightsOn(true);
      } else {
        changeIsLightsOn(false);
      }
      return true;
    } else {
      return false;
    }
  }

  /// Send vacuum control request
  Future<bool> sendVacuumOnRequest(bool isVacuumOn) async {
    final success = await _systemService.sendVacuumRequest(isVacuumOn);
    if (success) {
      if (isVacuumOn) {
        changeIsVacuumOn(true);
      } else {
        changeIsVacuumOn(false);
      }
      return true;
    } else {
      return false;
    }
  }

  /// Get status value from API
  Future<bool> statusValue() async {
    final data = await _systemService.getStatusValue();
    if (data != null) {
      final value = SystemValue.fromJson(data);
      updateSystemValue(value);
      return true;
    } else {
      return false;
    }
  }

  /// Decrease speed
  Future<bool> speedDecrease() async {
    final success = await _systemService.sendSpeedDecrease();
    if (success) {
      statusValue();
      return true;
    } else {
      return false;
    }
  }

  /// Increase speed
  Future<bool> speedIncrease() async {
    final success = await _systemService.sendSpeedIncrease();
    if (success) {
      statusValue();
      return true;
    } else {
      return false;
    }
  }

  /// Decrease torque
  Future<bool> torqueDecrease() async {
    final success = await _systemService.sendTorqueDecrease();
    if (success) {
      statusValue();
      return true;
    } else {
      return false;
    }
  }

  /// Increase torque
  Future<bool> torqueIncrease() async {
    final success = await _systemService.sendTorqueIncrease();
    if (success) {
      statusValue();
      return true;
    } else {
      return false;
    }
  }
}
