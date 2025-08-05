import 'package:emayer_cutter/core/constant/const_asset.dart';
import 'package:emayer_cutter/core/design/size_extensions.dart';
import 'package:emayer_cutter/core/design/app_component_sizes.dart';
import 'package:emayer_cutter/core/navigation/app_router.dart';
import 'package:emayer_cutter/core/navigation/app_router_name.dart';
import 'package:emayer_cutter/feature/home/home_notifier.dart';
import 'package:emayer_cutter/feature/home/widgets/drawer_end_button.dart';
import 'package:emayer_cutter/feature/home/widgets/drawer_info.dart';
import 'package:emayer_cutter/feature/home/widgets/drawer_up_button.dart';
import 'package:emayer_cutter/feature/home/widgets/top_bar.dart';
import 'package:emayer_cutter/feature/lock/lock_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:emayer_cutter/core/navigation/route_title_mapper.dart';

class HomeScreen extends StatefulWidget {
  final Widget child;
  const HomeScreen({required this.child, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          homeDashBoard(),
          Expanded(
            child: Column(
              children: [
                TopBar(
                  title: RouteTitleMapper.getTitleForRoute(
                    appRouter.state.fullPath ?? '/',
                  ),
                ),

                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AnimatedContainer homeDashBoard() {
    return AnimatedContainer(
      duration: Durations.long2,
      width: context.watch<HomeNotifier>().isSidebarOpen
          ? AppComponentSizes.sidebarExpandedWidth
          : AppComponentSizes.sidebarCollapsedWidth,
      color: const Color(0xFF171717),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double imageWidth = constraints.maxWidth;
                    return Padding(
                      padding: EdgeInsets.only(
                        top: 30.h,
                        bottom: 40.h,
                        left: (imageWidth > 12.w) ? 12.w : 0,
                        right: (imageWidth > 12.w) ? 12.w : 0,
                      ),
                      child: Image.asset(
                        AssetsConfirguration.splash,
                        height: 120.h,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.w,
                    left: 20.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DrawerUpButton(
                        title: 'System',
                        svgIcon: AssetsConfirguration.drawerSystem,
                        onPressed: () {
                          context.go(AppRouterName.system);
                        },
                        isEnable:
                            appRouter.state.fullPath == AppRouterName.system,
                      ),
                      DrawerUpButton(
                        title: 'Streaming',
                        svgIcon: AssetsConfirguration.drawerStream,
                        onPressed: () {
                          context.go(AppRouterName.stream);
                        },
                        isStreaming: true,
                        isStreamingOk: true,

                        // context
                        //     .watch<StreamNotifier>()
                        //     .isSocketConnected,
                        isEnable:
                            appRouter.state.fullPath == AppRouterName.stream,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Divider(
                    color: Color.fromRGBO(255, 255, 255, 0.21),
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 20.w,
                    left: 20.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DrawerEndButton(
                        title: 'Help',
                        svgIcon: AssetsConfirguration.drawerInfo,
                        onPressed: () {
                          appRouter.go(AppRouterName.help);
                        },
                      ),
                      DrawerEndButton(
                        title: 'Lock',
                        svgIcon: AssetsConfirguration.drawerLock,
                        onPressed: () {
                          LockScreen.show(context);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70.h),
                        child: const DrawerInfo(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
