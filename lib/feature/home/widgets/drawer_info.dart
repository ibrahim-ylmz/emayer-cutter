import 'package:flutter/material.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';

class DrawerInfo extends StatelessWidget {
  const DrawerInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double drawerWidth = constraints.maxWidth;
        if (drawerWidth > 140.w) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Guiss.ai',
                  style: TextStyle(
                    height: 1.8,
                    fontFamily: 'Roboto',
                    letterSpacing: 1,
                    color: const Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Trademark of Emayer Technology\n',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      letterSpacing: 1,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                      fontWeight: FontWeight.w600,
                      height: 1.8,
                      fontSize: 8.sp,
                    ),
                    children: [
                      TextSpan(
                        text: '© 2024 All Rights Reserved',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 1),
                          fontSize: 8.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 71.h,
          );
        }
      },
    );
  }
}
