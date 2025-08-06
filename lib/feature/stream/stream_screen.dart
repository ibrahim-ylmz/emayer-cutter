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
  @override
  Widget build(BuildContext context) {
    final streamNotifierListen =
        Provider.of<StreamNotifier>(context, listen: true);
    final streamNotifier = Provider.of<StreamNotifier>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 14.w,
          right: 14.w,
          top: 105.h,
          bottom: 105.h,
        ),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: GestureDetector(
                    onTap: () async {
                      if (!streamNotifierListen.isPlaying) {
                        if (!streamNotifierListen.isSocketConnected) {
                          bool response = await streamAutoStart();
                          if (response) {
                            Future.delayed(const Duration(seconds: 3), () {
                              initSocket();
                              streamNotifier.changeIsPlaying(true);
                            });
                          }
                        }
                        streamNotifier.changeIsPlaying(true);
                      } else {
                        streamClear();
                        streamAutoStop();
                        streamNotifier.changeIsSocketConnected(false);
                        streamNotifier.changeIsPlaying(false);
                      }
                    },
                    child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.grey,
                                Colors.black,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                        child: streamNotifierListen.isSocketConnected
                            ? imageData.isNotEmpty
                                ? RepaintBoundary(
                                    child: Image.memory(
                                      gaplessPlayback: true,
                                      alignment: Alignment.center,
                                      filterQuality: FilterQuality.high,
                                      width: double.infinity,
                                      imageData,
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  )
                            : const Center(
                                child: CircularProgressIndicator(),
                              )))),
            Positioned(
                bottom: 38.h,
                left: 59.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Top Cam',
                      style: TextStyle(
                        fontSize: 15.s,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Container(
                        width: 45.w,
                        height: 58.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13.r),
                          color: streamNotifierListen.isSocketConnected
                              ? const Color.fromRGBO(33, 184, 42, 1)
                              : Colors.red[700],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 2.r,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(width: 3.w),
                            Text(
                              streamNotifierListen.isSocketConnected
                                  ? "Online"
                                  : "Offline",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: Colors.white,
                                fontSize: 8.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              bottom: 48.h,
              right: 14.w,
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: const Text('Stream'),
                      onTap: () {
                        Provider.of<StreamNotifier>(context, listen: false)
                            .changeStreamType(StreamType.stream);

                        streamStart();
                      },
                    ),
                    PopupMenuItem(
                      child: const Text('Stream Processed'),
                      onTap: () {
                        Provider.of<StreamNotifier>(context, listen: false)
                            .changeStreamType(StreamType.streamProcessed);

                        streamStart();
                      },
                    ),
                  ];
                },
                child: Container(
                  height: 106.h,
                  width: 38.w,
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
                      size: 17.s,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (!streamNotifierListen.isPlaying) {
                  if (!streamNotifierListen.isSocketConnected) {
                    bool response = await streamAutoStart();
                    if (response) {
                      Future.delayed(const Duration(seconds: 3), () {
                        initSocket();
                        streamNotifier.changeIsPlaying(true);
                      });
                    }
                  }
                  streamNotifier.changeIsPlaying(true);
                } else {
                  streamClear();
                  streamAutoStop();
                  streamNotifier.changeIsSocketConnected(false);
                  streamNotifier.changeIsPlaying(false);
                }
              },
              child: Center(
                  child: AnimatedOpacity(
                opacity: streamNotifierListen.isPlaying ? 0 : 1,
                duration: Durations.short3,
                child: Container(
                    height: 250.h,
                    width: 140.w,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(48, 57, 63, 1)),
                    child: Center(
                        child: streamNotifierListen.isPlaying
                            ? Icon(
                                Icons.pause,
                                color: Colors.white,
                                size: 59.s,
                              )
                            : Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 59.s,
                              ))),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
