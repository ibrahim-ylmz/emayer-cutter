import 'package:emayer_cutter/core/constant/stream_enum.dart';
import 'package:flutter/material.dart';

class StreamNotifier with ChangeNotifier {
  StreamType _streamType = StreamType.streamProcessed;
  StreamType get streamType => _streamType;
  void changeStreamType(streamType) {
    _streamType = streamType;
    notifyListeners();
  }

  bool _isSocketConnected = false;
  bool get isSocketConnected => _isSocketConnected;
  void changeIsSocketConnected(bool value) {
    _isSocketConnected = value;
    notifyListeners();
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  void changeIsPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }
}
