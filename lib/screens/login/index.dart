import 'package:flutter/material.dart';

import 'gauth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  SettingPageState createState() => SettingPageState();
}

class SettingPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Text("Name"),
            ElevatedButton(
              onPressed: () {},
              child: Text("Akash"),
            ),
            const GAuth(),
          ],
        ),
      ),
    );
  }
}
