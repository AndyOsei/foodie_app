// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/dish.dart';
import '../screens/auth_screen.dart';
import '../screens/cart_screen.dart';
import '../screens/dish_info_screen.dart';
import '../screens/get_started_screen.dart';
import '../screens/home_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../screens/splash_screen.dart';

class Routes {
  static const String splashScreen = '/';
  static const String getStartedScreen = '/get-started-screen';
  static const String authScreen = '/auth-screen';
  static const String homeScreen = '/home-screen';
  static const String dishInfoScreen = '/dish-info-screen';
  static const String profileScreen = '/profile-screen';
  static const String cartScreen = '/cart-screen';
  static const String searchScreen = '/search-screen';
  static const all = <String>{
    splashScreen,
    getStartedScreen,
    authScreen,
    homeScreen,
    dishInfoScreen,
    profileScreen,
    cartScreen,
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
    RouteDef(Routes.dishInfoScreen, page: DishInfoScreen),
    RouteDef(Routes.profileScreen, page: ProfileScreen),
    RouteDef(Routes.cartScreen, page: CartScreen),
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
    DishInfoScreen: (data) {
      final args = data.getArgs<DishInfoScreenArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => DishInfoScreen(
          key: args.key,
          dish: args.dish,
        ),
        settings: data,
      );
    },
    ProfileScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const ProfileScreen(),
        settings: data,
      );
    },
    CartScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => const CartScreen(),
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

/// DishInfoScreen arguments holder class
class DishInfoScreenArguments {
  final Key key;
  final Dish dish;
  DishInfoScreenArguments({this.key, @required this.dish});
}
