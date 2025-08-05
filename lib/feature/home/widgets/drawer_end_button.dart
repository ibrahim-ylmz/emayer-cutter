import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.onPressed,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double buttonWidth = constraints.maxWidth;
          return SizedBox(
            height: screenWidth * 0.0295,
            width: double.infinity,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    widget.svgIcon ?? "Null",
                    height: screenWidth * 0.013,
                  ),
                  buttonWidth > screenWidth * 0.14
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: screenWidth * 0.027,
                          ),
                          child: Text(
                            widget.title ?? "Null",
                            style: TextStyle(
                              color: const Color.fromRGBO(255, 255, 255, 0.8),
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.008,
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
