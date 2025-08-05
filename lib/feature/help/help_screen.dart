import 'package:flutter/material.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:emayer_cutter/core/design/app_component_sizes.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          left: 60.w,
          top: 50.h,
          bottom: 50.h,
          right: 60.w,
        ),
        child: Column(
          children: [
            Container(
              width: 340.w,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(AppComponentSizes.largeRadius * 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: AppComponentSizes.extraLargeSpacing,
                  top: AppComponentSizes.extraLargeSpacing,
                  right: AppComponentSizes.extraLargeSpacing,
                  bottom: AppComponentSizes.extraLargeSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 18.h),
                      child: Text(
                        'Contact Information',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: AppComponentSizes.bodyFontSize,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(105, 109, 110, 1),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(40, 181, 224, 1),
                                Color.fromRGBO(4, 150, 255, 1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(AppComponentSizes.mediumRadius),
                          ),
                          child: Icon(
                            Icons.email_rounded,
                            size: AppComponentSizes.mediumIcon,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'support@loopbot.co',
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: AppComponentSizes.subtitleFontSize,
                                        color: const Color.fromRGBO(65, 77, 85, 1),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '24/7 Support',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: AppComponentSizes.captionFontSize,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(105, 109, 110, 1),
                                ),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(40, 181, 224, 1),
                                Color.fromRGBO(4, 150, 255, 1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(AppComponentSizes.mediumRadius),
                          ),
                          child: Center(
                            child: Text(
                              'phone',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: AppComponentSizes.captionFontSize,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 18.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '+90 850 255 51 55',
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: AppComponentSizes.subtitleFontSize,
                                        color: const Color.fromRGBO(65, 77, 85, 1),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '24/7 Support',
                                style: TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: AppComponentSizes.captionFontSize,
                                  fontWeight: FontWeight.w400,
                                  color: const Color.fromRGBO(105, 109, 110, 1),
                                ),
                                maxLines: 10,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
