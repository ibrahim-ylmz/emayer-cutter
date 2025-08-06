// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:emayer_cutter/core/service/api_service.dart';
import 'package:emayer_cutter/feature/stream/stream_notifier.dart';
import 'package:emayer_cutter/feature/stream/stream_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

mixin StreamScreenMixin on State<StreamScreen> {
  // Remove problematic late Provider declarations
  // These will be accessed directly in methods when needed

  // Reference to the StreamNotifier
  late StreamNotifier _streamNotifier;
  
  // Use centralized API service
  final ApiService _apiService = ApiService();
  
  // Stream specific endpoints
  final String autoActionEndpoint = '/v1/api/auto_action_app';

  Future<bool> streamAutoStart() async {
    try {
      final response = await _apiService.post(
        autoActionEndpoint,
        data: {
          "action": "start",
          "which_app": ["all"],
        },
      );
      if (response.statusCode == 200) {
        log('Stream Auto Start Success: ${response.data}');
        return true;
      } else {
        log('Stream Auto Start Failed: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      log('Stream Auto Start Error: $e');
      return false;
    }
  }

  Future<void> streamAutoStop() async {
    try {
      final response = await _apiService.post(
        autoActionEndpoint,
        data: {
          "action": "stop",
          "which_app": ["all"],
        },
      );
      log('Stream Auto Stop Success: ${response.data}');
    } catch (e) {
      log('Stream Auto Stop Error: $e');
    }
  }

  // bool isPlaying = false;
  // bool isSocketConnected = false;

  Uint8List imageData = Uint8List(0);

  String? previousBase64;
  late IO.Socket socket;

  // Create unique name/ID for this socket - constant across all instances
  final String streamSocketId = 'stream_socket';

  // Throttling mechanism for frame rate control
  Timer? _throttleTimer;
  final Duration _throttleDuration = const Duration(milliseconds: 33); // ~30 FPS
  
  @override
  void initState() {
    super.initState();
    
    // Initialize the StreamNotifier reference
    _streamNotifier = Provider.of<StreamNotifier>(context, listen: false);

    log('Creating new stream socket with ID: $streamSocketId');
    // Using completely unique configuration for the stream socket
    socket = IO.io(_apiService.baseUrl, <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
      'forceNew': true,
      'multiplex': false,
      'path': '/socket.io',
      'query': {
        'client': 'stream_client',
        'id': streamSocketId,
      }, // Unique identifier
      'extraHeaders': {'X-Client-Type': 'stream'},
    });

    // If the stream was active before, resume it automatically.
    if (_streamNotifier.isPlaying) {
      log('Stream was active, resuming connection...');
      initSocket();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Remove automatic socket initialization to prevent unnecessary connections
  }

  @override
  void dispose() {
    log('Disposing stream screen...');
    streamClear(); // Fully terminate the socket
    _throttleTimer?.cancel();
    super.dispose();
  }

  initSocket() {
    log('Initializing stream socket connection with ID: $streamSocketId');
    socket.connect();
    socket.onConnect((_) {
      log('Stream socket connection established (ID: $streamSocketId)');
      _streamNotifier.changeIsSocketConnected(true);
    });

    socket.on(_streamNotifier.streamType.value, (data) {
      // Throttled image update to prevent excessive frame refreshes
      if (data == previousBase64) return;
      previousBase64 = data;
      
      // Cancel previous timer if exists
      _throttleTimer?.cancel();
      
      // Set new timer for throttled update
      _throttleTimer = Timer(_throttleDuration, () {
        convertBase64ToImage(data);
      });
    });
    
    socket.onDisconnect((_) {
      log('Stream socket disconnected (ID: $streamSocketId)');
      _throttleTimer?.cancel();
      // Only update status if the user is not intentionally keeping the stream alive.
      if (!_streamNotifier.isPlaying) {
        _streamNotifier.changeIsSocketConnected(false);
      }
    });
    
    socket.onConnectError((err) => log('Stream socket error (ID: $streamSocketId): $err'));
    socket.onError((err) => log('Stream socket error (ID: $streamSocketId): $err'));
  }

  void convertBase64ToImage(String base64String) {
    Uint8List bytes = base64.decode(base64String);
    setState(() {
      imageData = bytes;
    });
  }

  void streamClear() {
    log('Clearing and completely disposing of stream socket with ID: $streamSocketId');
    socket.clearListeners(); // Remove all event listeners
    socket.disconnect();
    socket.dispose(); // This is crucial to stop background activity
  }

  void streamStart() {
    if (!_streamNotifier.isSocketConnected) {
      initSocket();
    } else {
      streamClear();

      _streamNotifier.changeIsPlaying(false);
      _streamNotifier.changeIsSocketConnected(false);

      Future.delayed(const Duration(milliseconds: 500), () {
        initSocket();
        _streamNotifier.changeIsPlaying(true);
      });
    }
  }
}
