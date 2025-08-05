import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';

class DrawerUpButton extends StatelessWidget {
  const DrawerUpButton({
    required this.isEnable,
    required this.title,
    required this.svgIcon,
    required this.onPressed,
    this.isStreaming = false,
    this.isStreamingOk = false,
    Key? key,
  }) : super(key: key);

  final bool isEnable;
  final String title;
  final VoidCallback onPressed;
  final String svgIcon;
  final bool isStreaming;
  final bool isStreamingOk;

  @override
  Widget build(BuildContext context) {
    Duration duration = Durations.long4;

    return Padding(
      padding: EdgeInsets.only(
        bottom: 18.h,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(55),
        onTap: onPressed,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double buttonWidth = constraints.maxWidth;
            return AnimatedContainer(
              duration: duration,
              curve: Curves.easeOut,
              width: double.infinity,
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: (isEnable && buttonWidth > 220.w)
                    ? const Color.fromRGBO(255, 255, 255, 0.21)
                    : Colors.transparent,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Icon container
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isEnable
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : null,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          svgIcon,
                          height: 16.s,
                          // ignore: deprecated_member_use
                          color: isEnable
                              ? const Color.fromRGBO(23, 23, 23, 1)
                              : const Color.fromRGBO(209, 209, 209, 1),
                        ),
                      ),
                    ),
                    // Text and badge container
                    if (buttonWidth > 220.w)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w, right: 4.w),
                          child: Row(
                            children: [
                              // Title text
                              Flexible(
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: isEnable
                                        ? const Color.fromRGBO(255, 255, 255, 1)
                                        : const Color.fromRGBO(255, 255, 255, 0.8),
                                    fontSize: 13.sp,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              // Online/Offline badge
                              if (isStreaming)
                                Container(
                                  margin: EdgeInsets.only(left: 6.w),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 3.h,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: isStreamingOk
                                        ? const Color.fromRGBO(33, 184, 42, 1)
                                        : Colors.red[700],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 3.w,
                                        height: 3.w,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(width: 3.w),
                                      Text(
                                        isStreamingOk ? "Online" : "Offline",
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          color: Colors.white,
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
