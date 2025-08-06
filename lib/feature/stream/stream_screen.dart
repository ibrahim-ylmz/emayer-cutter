import 'dart:async';
import 'package:emayer_cutter/core/constant/stream_enum.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:emayer_cutter/feature/stream/stream_notifier.dart';
import 'package:emayer_cutter/feature/stream/stream_screen_mixin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> with StreamScreenMixin {
  // Local state to prevent unnecessary rebuilds
  bool _isConnected = false;
  bool _isPlaying = false;
  late StreamNotifier _streamNotifier;

  @override
  void initState() {
    super.initState();
    // Initialize local state
    _streamNotifier = Provider.of<StreamNotifier>(context, listen: false);
    _isConnected = _streamNotifier.isSocketConnected;
    _isPlaying = _streamNotifier.isPlaying;

    // Add listener for targeted rebuilds
    _streamNotifier.addListener(_updateLocalState);
  }

  void _updateLocalState() {
    if (_isConnected != _streamNotifier.isSocketConnected ||
        _isPlaying != _streamNotifier.isPlaying) {
      setState(() {
        _isConnected = _streamNotifier.isSocketConnected;
        _isPlaying = _streamNotifier.isPlaying;
      });
    }
  }

  @override
  void dispose() {
    _streamNotifier.removeListener(_updateLocalState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 25.w,
          right: 25.w,
          top: 60.h,
          bottom: 60.h,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30.r),
              child: GestureDetector(
                onTap: () async {
                  final streamNotifier = Provider.of<StreamNotifier>(
                    context,
                    listen: false,
                  );
                  if (!_isPlaying) {
                    if (!_isConnected) {
                      bool response = await streamAutoStart();
                      if (response) {
                        Future.delayed(const Duration(seconds: 3), () {
                          initSocket();
                          streamNotifier.changeIsPlaying(true);
                          _updateLocalState();
                        });
                      }
                    }
                    streamNotifier.changeIsPlaying(true);
                    _updateLocalState();
                  } else {
                    streamClear();
                    streamAutoStop();
                    streamNotifier.changeIsSocketConnected(false);
                    streamNotifier.changeIsPlaying(false);
                    _updateLocalState();
                  }
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.grey, Colors.black],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),

                    Center(
                      child: _isConnected
                          ? imageData.isNotEmpty
                              ? RepaintBoundary(
                                  child: Image.memory(
                                    imageData,
                                    gaplessPlayback: true,
                                    alignment: Alignment.center,
                                    filterQuality: FilterQuality.low,
                                    width: double.infinity,
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : const CircularProgressIndicator(color: Colors.white)
                          : const CircularProgressIndicator(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 20.h,
              left: 55.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Top Cam',
                    style: TextStyle(
                      fontSize: 30.sp,
                      color: Colors.white,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Container(
                      width: 80.w,
                      height: 33.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(23.r),
                        color: _isConnected
                            ? const Color.fromRGBO(33, 184, 42, 1)
                            : Colors.red[700],
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 3.5.r,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            _isConnected ? "Online" : "Offline",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 25.h,
              right: 13.w,
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: const Text('Stream'),
                      onTap: () {
                        _streamNotifier.changeStreamType(StreamType.stream);
                        streamStart();
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Stream Processed'),
                      onTap: () {
                        _streamNotifier.changeStreamType(
                          StreamType.streamProcessed,
                        );
                        streamStart();
                      },
                    ),
                  ];
                },
                child: Container(
                  height: 55.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color.fromRGBO(255, 255, 255, 0.47),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                      size: 15.s,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!_isPlaying) {
                  if (!_isConnected) {
                    bool response = await streamAutoStart();
                    if (response) {
                      Future.delayed(const Duration(seconds: 3), () {
                        initSocket();
                        _streamNotifier.changeIsPlaying(true);
                        _updateLocalState();
                      });
                    }
                  }
                  _streamNotifier.changeIsPlaying(true);
                  _updateLocalState();
                } else {
                  streamClear();
                  streamAutoStop();
                  _streamNotifier.changeIsSocketConnected(false);
                  _streamNotifier.changeIsPlaying(false);
                  _updateLocalState();
                }
              },
              child: Center(
                child: AnimatedOpacity(
                  opacity: _isPlaying ? 0.0 : 1.0,
                  duration: Durations.short3,
                  child: Container(
                    height: 135.h,
                    width: 135.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(48, 57, 63, 1),
                    ),
                    child: Center(
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 110.s,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
