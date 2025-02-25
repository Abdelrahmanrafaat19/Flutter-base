import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../core/Theme/app_theme.dart';
import '../../core/utils/Extensions/utils_exts.dart';
import 'main_screen_nav_host.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    // Listen for navigation events
    GoRouter.of(context).routerDelegate.addListener(_onNavigate);
  }
  void _onNavigate() {
    if (GoRouter.of(context).state.path == "/") {
      UtilsExts.handleStatusBarColorWithIcon(
          statusBarColor:
          Color.lerp(AppTheme.appHeaderOne, AppTheme.appHeaderTwo, .4),statusBarIcons: Brightness.light);

    }else{
      UtilsExts.handleStatusBarColorWithIcon();
    }
  }
  @override
  Widget build(BuildContext context) {
    return const MainScreenNavHost();
  }
}
