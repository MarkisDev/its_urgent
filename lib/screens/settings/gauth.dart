import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:its_urgent/provider/gauth.dart';

class GAuth extends StatelessWidget {
  const GAuth({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GAuthProvider(),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<GAuthProvider>(context, listen: false);
              provider.googleLogin();
            },
            icon: const FaIcon(FontAwesomeIcons.google),
            label: const Text('Sign Up'),
          ),
           ElevatedButton.icon(
            onPressed: () {
              final provider =
                  Provider.of<GAuthProvider>(context, listen: false);
              provider.googleLogout();
            },
            icon: const FaIcon(FontAwesomeIcons.google),
            label: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
