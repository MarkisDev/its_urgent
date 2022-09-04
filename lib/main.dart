import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:its_urgent/utils/navbar.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'firebase_options.dart';
import 'provider/login.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ChangeNotifierProvider(
          create: (context) => LoginProvider(),
          child: MaterialApp(
            theme: ThemeData(
              brightness: Brightness.light,
              primarySwatch: Colors.green,
            ),
            home: const BottomNavigation(),
          ),
        );
      },
    );
  }
}
