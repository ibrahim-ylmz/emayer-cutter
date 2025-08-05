import 'package:emayer_cutter/core/constant/const_asset.dart';
import 'package:emayer_cutter/core/navigation/app_router.dart';
import 'package:emayer_cutter/core/navigation/route_title_mapper.dart';
import 'package:emayer_cutter/core/notifiers/theme_notifier.dart';
import 'package:emayer_cutter/feature/home/home_notifier.dart';
import 'package:emayer_cutter/feature/home/widgets/system_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TopBar extends StatefulWidget {
  const TopBar({required this.title, super.key});

  final String? title;

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeNotifier>(context);
    final homeNotifier = Provider.of<HomeNotifier>(context);
    return Container(
      height: MediaQuery.of(context).size.width * 0.0630,
      color: Theme.of(context).colorScheme.onSecondary,
      child: Padding(
        padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.0255,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    homeNotifier.toggleSidebar();
                  },
                  child: SvgPicture.asset(
                    height: MediaQuery.of(context).size.width * 0.024,
                    AssetsConfirguration.hamburgerMenu,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.onError,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.0202,
                  ),
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      color: Theme.of(context).colorScheme.onError,
                      fontSize: MediaQuery.of(context).size.width * 0.015,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            //if page system page show theme changer button
            if (RouteTitleMapper.getPageTitleForRoute(
                  appRouter.state.fullPath ?? '/',
                ) ==
                PageTitle.system)
              Padding(
                padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width * 0.026,
                ),
                child: SystemButton(
                  activeText: 'Light',
                  activeTextColor: const Color.fromRGBO(125, 126, 127, 1),
                  activeColor: const Color.fromRGBO(224, 224, 224, 1),
                  activeToggleColor: const Color.fromRGBO(241, 241, 241, 1),
                  activeIcon: Icon(
                    color: const Color.fromRGBO(125, 126, 127, 1),
                    size: MediaQuery.of(context).size.width * 0.015,
                    Icons.wb_sunny_outlined,
                  ),
                  inactiveText: 'Dark',
                  inactiveTextColor: Colors.white,
                  inactiveColor: const Color.fromRGBO(64, 68, 72, 1),
                  inactiveToggleColor: const Color.fromRGBO(23, 23, 23, 1),
                  inactiveIcon: SvgPicture.asset(
                    AssetsConfirguration.systemLightOff,
                    height: MediaQuery.of(context).size.width * 0.015,
                    width: MediaQuery.of(context).size.width * 0.015,
                  ),
                  value: themeChanger.isLightMode,
                  onToggle: (val) {
                    themeChanger.toggleTheme();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
