import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/login.dart';
import '../login/index.dart';
import 'myprofile.dart';
import 'setting_menu.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);
  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<SettingPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<int> checkSignedIn() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('isGoogleSignedIn')!) {
      return 2;
    }
    if (prefs.getBool('isPhoneSignedIn')!) {
      return 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            SettingMenu(
              text: "My Profile",
              icon: "assets/icons/User Icon.svg",
              press: () async {
                final prefs = await SharedPreferences.getInstance();
                if (prefs.getBool('isGoogleSignedIn')! ||
                    prefs.getBool('isPhoneSignedIn')!) {
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MyProfilePage(),
                    ),
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "Please sign in to continue",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  if (!mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                }
              },
            ),
            SettingMenu(
              text: "Notifications",
              icon: "assets/icons/Bell.svg",
              press: () {},
            ),
            SettingMenu(
              text: "Settings",
              icon: "assets/icons/Settings.svg",
              press: () {},
            ),
            SettingMenu(
              text: "Help Center",
              icon: "assets/icons/Question mark.svg",
              press: () {},
            ),
            SettingMenu(
              text: "Log Out",
              icon: "assets/icons/Log out.svg",
              press: () async {
                final prefs = await SharedPreferences.getInstance();
                if (prefs.getBool('isGoogleSignedIn')!) {
                  if (!mounted) return;
                  final provider =
                      Provider.of<LoginProvider>(context, listen: false);
                  provider.googleLogout();
                  Fluttertoast.showToast(
                    msg: "Sigin out successfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0,
                  );
                } else if (prefs.getBool('isPhoneSignedIn')!) {
                  if (!mounted) return;
                  final provider =
                      Provider.of<LoginProvider>(context, listen: false);
                  provider.phoneLogout();
                  Fluttertoast.showToast(
                    msg: "Signed out successfully",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0,
                  );
                } else {
                  Fluttertoast.showToast(
                    msg: "You are not logged in",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 16.0,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
