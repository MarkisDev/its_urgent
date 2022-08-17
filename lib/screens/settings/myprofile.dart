import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  MyProfilePageState createState() => MyProfilePageState();
}

class MyProfilePageState extends State<MyProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  String name = "";
  String email = "";
  String phone = "";

  void getPhoneData() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('name').toString();
        email = prefs.getString('email').toString();
        phone = prefs.getString('phone').toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    getPhoneData();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Logout'),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
              width: 150,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: const [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Name : ${user.displayName ?? name}",
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              "Email : ${user.email ?? email}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Phone : $phone",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
