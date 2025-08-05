import 'app_router_name.dart';

enum PageTitle {
  system('System'),
  stream('Stream'),
  help('Help'),
  lock('Lock');

  const PageTitle(this.displayName);
  final String displayName;
}

class RouteTitleMapper {
  static const Map<String, PageTitle> _routeToTitleMap = {
    AppRouterName.system: PageTitle.system,
    AppRouterName.stream: PageTitle.stream,
    AppRouterName.help: PageTitle.help,
    AppRouterName.lock: PageTitle.lock,
  };

  static String getTitleForRoute(String routePath) {
    final pageTitle = _routeToTitleMap[routePath];
    return pageTitle?.displayName ?? 'Unknown Page';
  }

  static PageTitle? getPageTitleForRoute(String routePath) {
    return _routeToTitleMap[routePath];
  }

  static bool isValidRoute(String routePath) {
    return _routeToTitleMap.containsKey(routePath);
  }
}
