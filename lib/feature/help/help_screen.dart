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
          left: 50.w,
          top: 40.h,
          bottom: 40.h,
          right: 50.w,
        ),
        child: Column(
          children: [
            Container(
              width: 300.w,
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
                  left: AppComponentSizes.largeSpacing,
                  top: AppComponentSizes.largeSpacing,
                  right: AppComponentSizes.largeSpacing,
                  bottom: AppComponentSizes.largeSpacing,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 15.h),
                      child: Text(
                        'Contact Information',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(105, 109, 110, 1),
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(40, 181, 224, 1),
                                Color.fromRGBO(4, 150, 255, 1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.email_rounded,
                            size: 20.s,
                            color: const Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ),
                        SizedBox(width: 14.w),
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
                                        fontSize: 16.sp,
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
                                  fontSize: 11.sp,
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
                    SizedBox(height: 12.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                Color.fromRGBO(40, 181, 224, 1),
                                Color.fromRGBO(4, 150, 255, 1),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Center(
                            child: Text(
                              'phone',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 14.w),
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
                                        fontSize: 16.sp,
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
                                  fontSize: 11.sp,
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
