import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
    final double screenWidth = MediaQuery.of(context).size.width;
    Duration duration = Durations.long4;

    return Padding(
      padding: EdgeInsets.only(
        bottom: screenWidth * 0.013,
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
              height: screenWidth * 0.035,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(55),
                color: (isEnable && buttonWidth > screenWidth * 0.14)
                    ? const Color.fromRGBO(255, 255, 255, 0.21)
                    : Colors.transparent,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: AnimatedContainer(
                      width: screenWidth * 0.034,
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
                          height: screenWidth * 0.013,
                          // ignore: deprecated_member_use
                          color: isEnable
                              ? const Color.fromRGBO(23, 23, 23, 1)
                              : const Color.fromRGBO(209, 209, 209, 1),
                        ),
                      ),
                    ),
                  ),
                  buttonWidth > screenWidth * 0.14
                      ? Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.014),
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                fontFamily: "Roboto",
                                color: isEnable
                                    ? const Color.fromRGBO(255, 255, 255, 1)
                                    : const Color.fromRGBO(255, 255, 255, 0.8),
                                fontSize: screenWidth * 0.01,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                  if (buttonWidth > screenWidth * 0.14 && isStreaming)
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.004),
                      child: Container(
                        height: screenWidth * 0.0145,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(23),
                          color: isStreamingOk
                              ? const Color.fromRGBO(33, 184, 42, 1)
                              : Colors.red[700],
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.005),
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth * 0.003,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(left: screenWidth * 0.003),
                                child: Text(
                                  isStreamingOk ? "Online" : "Offline",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    color: Colors.white,
                                    fontSize: screenWidth * 0.008,
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
