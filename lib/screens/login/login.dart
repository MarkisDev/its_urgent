import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../settings/index.dart';
import '../../provider/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      child: Column(
        children: [
          TextField(
            controller: phoneController,
            decoration: const InputDecoration(
              hintText: 'Phone Number',
              prefix: Padding(
                padding: EdgeInsets.all(4),
                child: Text('+91'),
              ),
            ),
            maxLength: 10,
            keyboardType: TextInputType.phone,
          ),
          Visibility(
            visible: otpVisibility,
            child: TextField(
              controller: otpController,
              decoration: const InputDecoration(
                hintText: 'Enter OTP',
                prefix: Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(''),
                ),
              ),
              maxLength: 6,
              keyboardType: TextInputType.number,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              if (otpVisibility) {
                verifyOTP();
              } else {
                loginWithPhone();
              }
            },
            child: Text(
              otpVisibility ? "Verify" : "Login",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<LoginProvider>(context, listen: false);
              provider.googleLogin();
            },
            icon: const FaIcon(FontAwesomeIcons.google),
            label: const Text('Sign Up'),
          ),
          ElevatedButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<LoginProvider>(context, listen: false);
              provider.googleLogout();
            },
            icon: const FaIcon(FontAwesomeIcons.google),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91${phoneController.text}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  void verifyOTP() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
      (value) {
        setState(() {
          user = FirebaseAuth.instance.currentUser;
        });
      },
    ).whenComplete(
      () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "You are logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingPage(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "your login is failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }
}
