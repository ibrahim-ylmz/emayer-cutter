import 'package:emayer_cutter/core/constant/const_asset.dart';
import 'package:emayer_cutter/feature/home/widgets/system_button.dart';
import 'package:emayer_cutter/feature/system/system_notifier.dart';
import 'package:emayer_cutter/feature/system/system_screen_mixin.dart';
import 'package:emayer_cutter/feature/system/widgets/system_icon.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
          top: screenWidth * 0.015,
          left: screenWidth * 0.025,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.only(bottom: screenWidth * 0.01),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(30),
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
                              top: screenWidth * 0.011,
                              left: screenWidth * 0.0194,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: screenWidth * 0.004,
                                  height: screenWidth * 0.004,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onError,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: screenWidth * 0.004,
                                  ),
                                  child: Text(
                                    'Control',
                                    style: TextStyle(
                                      fontFamily: 'Roboto',
                                      // fontSize: 24,
                                      fontSize: screenWidth * 0.014,
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
                              top: screenWidth * 0.007,
                              left: screenWidth * 0.0255,
                              right: screenWidth * 0.0255,
                              bottom: screenWidth * 0.0026,
                            ),
                            child: SystemButton(
                              title: 'Power',
                              inactiveIcon: Icon(
                                color: Colors.white,
                                size: MediaQuery.of(context).size.width * 0.015,
                                Icons.power_settings_new_rounded,
                              ),
                              activeIcon: SvgPicture.asset(
                                height: screenWidth * 0.01,
                                AssetsConfirguration.systemPowerOn,
                              ),
                              value: context.watch<SystemNotifier>().isPowerOn,
                              onToggle: context
                                  .read<SystemNotifier>()
                                  .sendPowerOnRequest,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.0117,
                              right: screenWidth * 0.0117,
                              bottom: screenWidth * 0.0026,
                            ),
                            child: Divider(
                              height: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.0255,
                              right: screenWidth * 0.0255,
                              bottom: screenWidth * 0.0026,
                            ),
                            child: SystemButton(
                              title: 'Vacuum',
                              inactiveIcon: SvgPicture.asset(
                                height:
                                    MediaQuery.of(context).size.width * 0.015,
                                AssetsConfirguration.systemVacuumOff,
                              ),
                              activeIcon: SvgPicture.asset(
                                height:
                                    MediaQuery.of(context).size.width * 0.017,
                                AssetsConfirguration.systemVacuumOn,
                              ),
                              value: context.watch<SystemNotifier>().isVacuumOn,
                              onToggle: context
                                  .read<SystemNotifier>()
                                  .sendVacuumOnRequest,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.0117,
                              right: screenWidth * 0.0117,
                              bottom: screenWidth * 0.0026,
                            ),
                            child: Divider(
                              height: 1,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: screenWidth * 0.0255,
                              right: screenWidth * 0.0255,
                              bottom: screenWidth * 0.0026,
                            ),
                            child: SystemButton(
                              title: 'Lights',
                              inactiveIcon: SvgPicture.asset(
                                height:
                                    MediaQuery.of(context).size.width * 0.015,
                                AssetsConfirguration.systemLightOff,
                              ),
                              activeIcon: Icon(
                                color: Colors.white,
                                size: MediaQuery.of(context).size.width * 0.015,
                                Icons.wb_sunny_outlined,
                              ),
                              value: context.watch<SystemNotifier>().isLightsOn,
                              onToggle: context
                                  .read<SystemNotifier>()
                                  .sendLightsOnRequest,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Expanded(
                    flex: 4,
                    child: StatusContainer(
                      isPowerOn: context.watch<SystemNotifier>().isPowerOn,
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
                  SizedBox(height: screenWidth * 0.01),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(
                    flex: 10,
                    child: Stack(
                      children: [
                        Positioned(
                          top: screenWidth * 0.04,
                          left: screenWidth * 0.13,
                          child: SystemIcon(
                            isActive: context
                                .watch<SystemNotifier>()
                                .isLightsOn,
                            svgIconPath: AssetsConfirguration.idea,
                            onTap: context
                                .read<SystemNotifier>()
                                .sendLightsOnRequest,
                          ),
                        ),
                        Positioned(
                          bottom: screenWidth * 0.0125,
                          right: screenWidth * 0.244,
                          child: SystemIcon(
                            isActive: context
                                .watch<SystemNotifier>()
                                .isVacuumOn,
                            svgIconPath: AssetsConfirguration.systemVacuumOn,
                            onTap: context
                                .read<SystemNotifier>()
                                .sendVacuumOnRequest,
                          ),
                        ),
                        Positioned(
                          top: screenWidth * 0.04,
                          right: screenWidth * 0.13,
                          child: SystemIcon(
                            isActive: context.watch<SystemNotifier>().isPowerOn,
                            svgIconPath: AssetsConfirguration.systemRight,
                            onTap: context
                                .read<SystemNotifier>()
                                .sendPowerOnRequest,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          right: screenWidth * 0.01,
                          bottom: screenWidth * 0.01,
                        ),
                        child: const SystemInfo(
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
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
