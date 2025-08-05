import 'package:emayer_cutter/core/constant/const_asset.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:emayer_cutter/feature/system/system_notifier.dart';
import 'package:emayer_cutter/feature/system/system_screen_mixin.dart';
import 'package:emayer_cutter/feature/system/widgets/system_button.dart';
import 'package:emayer_cutter/feature/system/widgets/system_info.dart';
import 'package:emayer_cutter/feature/system/widgets/system_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SystemScreen extends StatefulWidget {
  const SystemScreen({super.key});

  @override
  State<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> with SystemScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(top: 16.h, left: 27.w),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(bottom: 10.h),
                            decoration: BoxDecoration(
                              color: Theme.of(
                                context,
                              ).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 12.h,
                                    left: 21.w,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 4.w,
                                        height: 4.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onError,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.w),
                                        child: Text(
                                          'Control',
                                          style: TextStyle(
                                            fontFamily: 'Roboto',
                                            fontSize: 15.sp,
                                            color: Theme.of(
                                              context,
                                            ).colorScheme.onError,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: 7.h,
                                    left: 27.w,
                                    right: 27.w,
                                    bottom: 3.h,
                                  ),
                                  child: SystemButton(
                                    title: 'Power',
                                    inactiveIcon: Icon(
                                      color: Colors.white,
                                      size: 16.s,
                                      Icons.power_settings_new_rounded,
                                    ),
                                    activeIcon: SvgPicture.asset(
                                      height: 10.h,
                                      AssetsConfirguration.systemPowerOn,
                                    ),
                                    value: context
                                        .watch<SystemNotifier>()
                                        .isPowerOn,
                                    onToggle: context
                                        .read<SystemNotifier>()
                                        .sendPowerOnRequest,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 12.w,
                                    right: 12.w,
                                    bottom: 3.h,
                                  ),
                                  child: Divider(
                                    height: 1,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 27.w,
                                    right: 27.w,
                                    bottom: 3.h,
                                  ),
                                  child: SystemButton(
                                    title: 'Vacuum',
                                    inactiveIcon: SvgPicture.asset(
                                      height: 16.h,
                                      AssetsConfirguration.systemVacuumOff,
                                    ),
                                    activeIcon: SvgPicture.asset(
                                      height: 18.h,
                                      AssetsConfirguration.systemVacuumOn,
                                    ),
                                    value: context
                                        .watch<SystemNotifier>()
                                        .isVacuumOn,
                                    onToggle: context
                                        .read<SystemNotifier>()
                                        .sendVacuumOnRequest,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 12.w,
                                    right: 12.w,
                                    bottom: 3.h,
                                  ),
                                  child: Divider(
                                    height: 1,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondary,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 27.w,
                                    right: 27.w,
                                    bottom: 3.h,
                                  ),
                                  child: SystemButton(
                                    title: 'Lights',
                                    inactiveIcon: SvgPicture.asset(
                                      height: 16.h,
                                      AssetsConfirguration.systemLightOff,
                                    ),
                                    activeIcon: Icon(
                                      color: Colors.white,
                                      size: 16.s,
                                      Icons.wb_sunny_outlined,
                                    ),
                                    value: context
                                        .watch<SystemNotifier>()
                                        .isLightsOn,
                                    onToggle: context
                                        .read<SystemNotifier>()
                                        .sendLightsOnRequest,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 100.h),
                        Expanded(
                          child: StatusContainer(
                            isPowerOn: context
                                .watch<SystemNotifier>()
                                .isPowerOn,
                            sensor1Text: 'Sensor 1',
                            sensor1Status:
                                context
                                    .watch<SystemNotifier>()
                                    .systemStatus
                                    .message
                                    ?.sensors
                                    ?.sensor1 ??
                                false,
                            sensor2Text: 'Sensor 2',
                            sensor2Status:
                                context
                                    .watch<SystemNotifier>()
                                    .systemStatus
                                    .message
                                    ?.sensors
                                    ?.sensor2 ??
                                false,
                            sensor3Text: 'Sensor 3',
                            sensor3Status:
                                context
                                    .watch<SystemNotifier>()
                                    .systemStatus
                                    .message
                                    ?.sensors
                                    ?.sensor3 ??
                                false,
                            motor1Text: 'Motor 1',
                            motor1Status:
                                context
                                    .watch<SystemNotifier>()
                                    .systemStatus
                                    .message
                                    ?.motors
                                    ?.motor1 ??
                                false,
                            motor2Text: 'Motor 2',
                            motor2Status:
                                context
                                    .watch<SystemNotifier>()
                                    .systemStatus
                                    .message
                                    ?.motors
                                    ?.motor2 ??
                                false,
                            motor3Text: 'Motor 3',
                            motor3Status:
                                context
                                    .watch<SystemNotifier>()
                                    .systemStatus
                                    .message
                                    ?.motors
                                    ?.motor3 ??
                                false,
                            topTitle: 'Status',
                            infoText: 'Speed',
                            infoValue:
                                context
                                    .watch<SystemNotifier>()
                                    .systemValue
                                    .message
                                    ?.speed ??
                                0,
                            speedDecrease: context
                                .read<SystemNotifier>()
                                .speedDecrease,
                            speedIncrease: context
                                .read<SystemNotifier>()
                                .speedIncrease,
                            torqueDecrease: context
                                .read<SystemNotifier>()
                                .torqueDecrease,
                            torqueIncrease: context
                                .read<SystemNotifier>()
                                .torqueIncrease,

                            infoText1: 'Torque',
                            infoValue1:
                                context
                                    .watch<SystemNotifier>()
                                    .systemValue
                                    .message
                                    ?.torque ??
                                0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40.w),
                  Expanded(child: Placeholder()),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: SystemInfo(
                title: 'Info',
                valueText: 'Machine ID',
                valueText1: 'Model',
                valueText2: 'AI Version',
                valueText3: 'Last Update',
                value: 'ID-123456789',
                value1: 'AB12345',
                value2: 'AI-123456789',
                value3: '01.02.2024',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
