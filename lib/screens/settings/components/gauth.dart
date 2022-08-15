import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:its_urgent/provider/gauth.dart';

class GAuth extends StatelessWidget {
  GAuth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GAuthProvider(),
      child: ElevatedButton(
        onPressed: () {
          final provider = Provider.of<GAuthProvider>(context, listen: false);
          provider.googleLogin();
        },
        child: const Text('Sign Up with Google'),
      ),
    );
  }
}
