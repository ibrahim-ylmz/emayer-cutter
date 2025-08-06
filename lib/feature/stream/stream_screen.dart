import 'dart:async';
import 'package:emayer_cutter/core/constant/stream_enum.dart';
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
          // left: 25,
          left: MediaQuery.of(context).size.width * 0.013,
          // right: 25,
          right: MediaQuery.of(context).size.width * 0.013,
          // top: 60,
          top: MediaQuery.of(context).size.height * 0.055,
          // bottom: 60,
          bottom: MediaQuery.of(context).size.height * 0.055,
        ),
        child: Stack(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(
                  // 30,
                  MediaQuery.of(context).size.width * 0.015,
                ),
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
                // bottom: 20,
                bottom: MediaQuery.of(context).size.height * 0.02,
                // left: 55,
                left: MediaQuery.of(context).size.width * 0.028,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Top Cam',
                      style: TextStyle(
                        // fontSize: 30,
                        fontSize: MediaQuery.of(context).size.width * 0.0155,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        // top: 10,
                        top: MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Container(
                        // width: 80,
                        width: MediaQuery.of(context).size.width * 0.042,
                        // height: 33,
                        height: MediaQuery.of(context).size.height * 0.03,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            // 23,
                            MediaQuery.of(context).size.width * 0.012,
                          ),
                          color: streamNotifierListen.isSocketConnected
                              ? const Color.fromRGBO(33, 184, 42, 1)
                              : Colors.red[700],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              // radius: 3.5,
                              radius:
                                  MediaQuery.of(context).size.width * 0.0019,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.003,
                              // width: 5,
                            ),
                            Text(
                              streamNotifierListen.isSocketConnected
                                  ? "Online"
                                  : "Offline",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: Colors.white,
                                // fontSize: 14

                                fontSize:
                                    MediaQuery.of(context).size.width * 0.0072,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.025,
              right: MediaQuery.of(context).size.width * 0.013,
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
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: MediaQuery.of(context).size.width * 0.035,
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
                      size: MediaQuery.of(context).size.width * 0.0155,
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
                    // height: 135,
                    height: MediaQuery.of(context).size.height * 0.13,
                    // width: 135,
                    width: MediaQuery.of(context).size.width * 0.13,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(48, 57, 63, 1)),
                    child: Center(
                        child: streamNotifierListen.isPlaying
                            ? Icon(
                                Icons.pause,
                                color: Colors.white,
                                // size: 110,
                                size: MediaQuery.of(context).size.width * 0.055,
                              )
                            : Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                // size: 110,
                                size: MediaQuery.of(context).size.width * 0.055,
                              ))),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
