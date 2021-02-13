// ignore: import_of_legacy_library_into_null_safe
import 'package:auto_route/auto_route.dart';
import 'package:auto_route/auto_route_annotations.dart';
import 'package:foodie_app/screens/auth_screen.dart';
import 'package:foodie_app/screens/get_started_screen.dart';
import 'package:foodie_app/screens/home_screen.dart';
import 'package:foodie_app/screens/search_screen.dart';
import 'package:foodie_app/screens/splash_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    // initial route is named "/"
    MaterialRoute(page: SplashScreen, initial: true),

    MaterialRoute(page: GetStartedScreen),
    MaterialRoute(page: AuthScreen),
    MaterialRoute(page: HomeScreen),

    CustomRoute<bool>(
      page: SearchScreen,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
  ],
)
class $AppRouter {}
