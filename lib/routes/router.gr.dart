// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../screens/auth_screen.dart';
import '../screens/get_started_screen.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String getStartedScreen = '/get-started-screen';
  static const String authScreen = '/auth-screen';
  static const String homeScreen = '/home-screen';
  static const String searchScreen = '/search-screen';
  static const all = <String>{
    splashScreen,
    getStartedScreen,
    authScreen,
    homeScreen,
    searchScreen,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.splashScreen, page: SplashScreen),
    RouteDef(Routes.getStartedScreen, page: GetStartedScreen),
    RouteDef(Routes.authScreen, page: AuthScreen),
    RouteDef(Routes.homeScreen, page: HomeScreen),
    RouteDef(Routes.searchScreen, page: SearchScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    SplashScreen: (data) {
      final args = data.getArgs<SplashScreenArguments>(
        orElse: () => SplashScreenArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SplashScreen(key: args.key),
        settings: data,
      );
    },
    GetStartedScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const GetStartedScreen(),
        settings: data,
      );
    },
    AuthScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const AuthScreen(),
        settings: data,
      );
    },
    HomeScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const HomeScreen(),
        settings: data,
      );
    },
    SearchScreen: (data) {
      return PageRouteBuilder<bool>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SearchScreen(),
        settings: data,
        transitionsBuilder: TransitionsBuilders.slideBottom,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// SplashScreen arguments holder class
class SplashScreenArguments {
  final Key key;
  SplashScreenArguments({this.key});
}
