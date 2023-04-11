import 'package:flutter/material.dart';
import 'package:login_demo/core/router/routes.dart';
import 'package:sizer/sizer.dart';

import 'di/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // UI
            brightness: Brightness.dark,
            primaryColor: Colors.lightBlue[800],
            // font
            fontFamily: 'Georgia',
          ),
          initialRoute: Routes.initial,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
        );
      },
    );
  }
}
