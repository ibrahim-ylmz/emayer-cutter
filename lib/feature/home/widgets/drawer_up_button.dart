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
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AnimatedContainer(
                      width: 44.w,
                      height: 44.w,
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
                    if (buttonWidth > 180.w)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: 12.w),
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
                      ),
                    if (buttonWidth > 180.w && isStreaming)
                      Container(
                        height: 18.h,
                        margin: EdgeInsets.only(left: 8.w, right: 4.w),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isStreamingOk
                              ? const Color.fromRGBO(33, 184, 42, 1)
                              : Colors.red[700],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 2.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 4.w,
                                height: 4.w,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                isStreamingOk ? "Online" : "Offline",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
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
