import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
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
            height: 40.h,
            width: double.infinity,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    widget.svgIcon ?? "Null",
                    height: kIsWeb ? 24.0 : 18.s,
                    width: kIsWeb ? 24.0 : null,
                    fit: BoxFit.contain,
                    colorFilter: const ColorFilter.mode(
                      Color.fromRGBO(255, 255, 255, 0.8),
                      BlendMode.srcIn,
                    ),
                  ),
                  buttonWidth > 180.w
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: 35.w,
                          ),
                          child: Text(
                            widget.title ?? "Null",
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize: 12.sp,
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

