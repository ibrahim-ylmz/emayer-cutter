import 'dart:developer';
import 'package:dio/dio.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late final Dio _dio;

  /// Base URL for API requests
  final String baseUrl = 'http://127.0.0.1:5000';

  /// API endpoints
  final String systemEvent = '/v1/api/set_event/iot_device_app';
  final String systemStatusUrl = '/v1/api/get_event/iot_device_app';

  void initialize() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
      ),
    );

    // Add interceptors for logging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => log(object.toString()),
      ),
    );
  }

  /// GET request wrapper
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      log('GET Error: ${e.message}');
      rethrow;
    }
  }

  /// POST request wrapper
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
    } on DioException catch (e) {
      log('POST Error: ${e.message}');
      rethrow;
    }
  }

  /// Get system status
  Future<Response> getSystemStatus() async {
    return await get(systemStatusUrl, queryParameters: {'module': 'Control'});
  }

  /// Send power control request
  Future<Response> sendPowerRequest(bool isPowerOn) async {
    return await post(
      systemEvent,
      data: {
        "module": "Control",
        "event": isPowerOn ? "power_on" : "power_off",
      },
    );
  }

  /// Send vacuum control request
  Future<Response> sendVacuumRequest(bool isVacuumOn) async {
    return await post(
      systemEvent,
      data: {
        "module": "Control",
        "event": isVacuumOn ? "vacuum_on" : "vacuum_off",
      },
    );
  }

  /// Send lights control request
  Future<Response> sendLightsRequest(bool isLightsOn) async {
    return await post(
      systemEvent,
      data: {
        "module": "Control",
        "event": isLightsOn ? "lights_on" : "lights_off",
      },
    );
  }

  /// Get status value
  Future<Response> getStatusValue() async {
    return await get(systemStatusUrl, queryParameters: {'module': 'Status'});
  }

  /// Send speed decrease request
  Future<Response> sendSpeedDecrease() async {
    return await post(
      systemEvent,
      data: {"module": "Status", "event": "speed_decrease"},
    );
  }

  /// Send speed increase request
  Future<Response> sendSpeedIncrease() async {
    return await post(
      systemEvent,
      data: {"module": "Status", "event": "speed_increase"},
    );
  }

  /// Send torque decrease request
  Future<Response> sendTorqueDecrease() async {
    return await post(
      systemEvent,
      data: {"module": "Status", "event": "torque_decrease"},
    );
  }

  /// Send torque increase request
  Future<Response> sendTorqueIncrease() async {
    return await post(
      systemEvent,
      data: {"module": "Status", "event": "torque_increase"},
    );
  }
}
