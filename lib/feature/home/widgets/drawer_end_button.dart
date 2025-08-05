import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';

class DrawerEndButton extends StatefulWidget {
  const DrawerEndButton(
      {required this.title,
      required this.svgIcon,
      required this.onPressed,
      super.key});

  final String? title;
  final VoidCallback? onPressed;
  final String? svgIcon;

  @override
  State<DrawerEndButton> createState() => _DrawerEndButtonState();
}

class _DrawerEndButtonState extends State<DrawerEndButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double buttonWidth = constraints.maxWidth;
          return SizedBox(
            height: 32.h,
            width: double.infinity,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    widget.svgIcon ?? "Null",
                    height: 14.s,
                  ),
                  buttonWidth > 151.w
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: 29.w,
                          ),
                          child: Text(
                            widget.title ?? "Null",
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: 9.sp,
                            ),
                          ),
                        )
                      : Container()
                ]),
          );
        },
      ),
    );
  }
}
