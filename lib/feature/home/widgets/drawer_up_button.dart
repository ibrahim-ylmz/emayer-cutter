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
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: (isEnable && buttonWidth > 180.w)
                    ? const Color.fromRGBO(255, 255, 255, 0.21)
                    : Colors.transparent,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: AnimatedContainer(
                      width: 44.w,
                      duration: duration,
                      curve: Curves.easeOut,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isEnable
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : null,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          svgIcon,
                          height: 18.s,
                          // ignore: deprecated_member_use
                          color: isEnable
                              ? const Color.fromRGBO(23, 23, 23, 1)
                              : const Color.fromRGBO(209, 209, 209, 1),
                        ),
                      ),
                    ),
                  ),
                  buttonWidth > 180.w
                      ? Padding(
                          padding: EdgeInsets.only(left: 18.w),
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: isEnable
                                    ? const Color.fromRGBO(255, 255, 255, 1)
                                    : const Color.fromRGBO(255, 255, 255, 0.8),
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  if (buttonWidth > 180.w && isStreaming)
                    Padding(
                      padding: EdgeInsets.only(left: 6.w),
                      child: Container(
                        height: 20.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: isStreamingOk
                              ? const Color.fromRGBO(33, 184, 42, 1)
                              : Colors.red[700],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 6.w),
                          child: Row(
                            children: [
                              Container(
                                width: 4.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: 4.w),
                                child: Text(
                                  isStreamingOk ? "Online" : "Offline",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: 11.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
