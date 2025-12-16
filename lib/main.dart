import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/route/route_manager.dart';

void main() {
  runApp( ProviderScope(child: MyApp()));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_,context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Riverpod MVVM Demo',
            theme: ThemeData(primarySwatch: Colors.blue),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.splashRoute,
          );
        }
    );
  }
}