// ignore_for_file: avoid_print

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
  late StreamNotifier stream = Provider.of<StreamNotifier>(
    context,
    listen: false,
  );

  late StreamNotifier streamListen = Provider.of<StreamNotifier>(
    context,
    listen: true,
  );

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

  @override
  void initState() {
    super.initState();

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (streamListen.isSocketConnected) {
      initSocket();
    }
  }

  @override
  void dispose() {
    log('Disposing stream socket with ID: $streamSocketId');
    if (socket.connected) {
      socket.disconnect();
    }
    socket.clearListeners();
    socket.dispose();
    super.dispose();
  }

  initSocket() {
    log('Initializing stream socket connection with ID: $streamSocketId');
    socket.connect();
    socket.onConnect((_) {
      log('Stream socket connection established (ID: $streamSocketId)');
      stream.changeIsSocketConnected(true);
    });

    socket.on(stream.streamType.value, (data) {
      if (data == previousBase64) return;
      // log('Convert Base64 to Image');
      previousBase64 = data;
      convertBase64ToImage(data);
    });
    socket.onDisconnect(
      (_) => log('Stream socket disconnected (ID: $streamSocketId)'),
    );
    socket.onConnectError(
      (err) => log('Stream socket error (ID: $streamSocketId): $err'),
    );
    socket.onError(
      (err) => log('Stream socket error (ID: $streamSocketId): $err'),
    );
  }

  void convertBase64ToImage(String base64String) {
    Uint8List bytes = base64.decode(base64String);
    setState(() {
      imageData = bytes;
    });
  }

  void streamClear() {
    log('Clearing stream socket with ID: $streamSocketId');
    if (socket.connected) {
      socket.disconnect();
    }
    socket.clearListeners();
    // Avoid calling close() and destroy() which can affect other sockets
    imageData = Uint8List(0);
  }

  void streamStart() {
    if (!streamListen.isSocketConnected) {
      initSocket();
    } else {
      streamClear();

      stream.changeIsPlaying(false);
      stream.changeIsSocketConnected(false);

      Future.delayed(const Duration(milliseconds: 500), () {
        initSocket();
        stream.changeIsPlaying(true);
      });
    }
  }
}
