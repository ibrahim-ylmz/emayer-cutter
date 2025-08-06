import 'package:emayer_cutter/core/constant/stream_enum.dart';
import 'package:flutter/material.dart';

class StreamNotifier with ChangeNotifier {
  StreamType _streamType = StreamType.streamProcessed;
  StreamType get streamType => _streamType;
  void changeStreamType(streamType) {
    _streamType = streamType;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  bool _isSocketConnected = false;
  bool get isSocketConnected => _isSocketConnected;
  void changeIsSocketConnected(bool value) {
    if (_isSocketConnected == value) return; // Prevent unnecessary notifications
    _isSocketConnected = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  void changeIsPlaying(bool value) {
    if (_isPlaying == value) return; // Prevent unnecessary notifications
    _isPlaying = value;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}
