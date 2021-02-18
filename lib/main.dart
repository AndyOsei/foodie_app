import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodie_app/app_theme.dart';
import 'package:foodie_app/models/cart.dart';
import 'package:foodie_app/routes/router.gr.dart';
import 'package:foodie_app/values/values.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: StringConst.APP_NAME,
        theme: AppTheme.themeData,
        builder: ExtendedNavigator.builder<AppRouter>(
          router: AppRouter(),
          initialRoute: Routes.splashScreen,
        ),
      ),
    );
  }
}
