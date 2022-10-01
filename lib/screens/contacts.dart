import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:its_urgent/provider/contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../widgets/rating.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);
  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> with WidgetsBindingObserver {
  List<Contact>? contacts;
  late final ContactsProvider contactProvider;
  bool _isAppPaused = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    contactProvider = ContactsProvider();
    contactProvider.getContact();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

// Method will check if permission was granted outside app through settings
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed &&
        _isAppPaused &&
        (contactProvider.permissionStatus == ContactPermission.deniedForever)) {
      _isAppPaused = false;
      contactProvider.getContact();
    } else if (state == AppLifecycleState.paused &&
        contactProvider.permissionStatus == ContactPermission.deniedForever) {
      _isAppPaused = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: contactProvider,
      child: Consumer<ContactsProvider>(builder: (context, value, child) {
        // Choosing what to render depending on permission
        Widget widget;
        if (contactProvider.permissionStatus == ContactPermission.denied ||
            contactProvider.permissionStatus ==
                ContactPermission.deniedForever) {
          widget = Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                    left: 14.0,
                    top: 21.0,
                    right: 14.0,
                  ),
                  child: Text(
                    'Read files permission',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 14.0,
                    top: 21.0,
                    right: 14.0,
                  ),
                  child: const Text(
                    'In order to make calls directly, we need access to your contacts.',
                    textAlign: TextAlign.center,
                  ),
                ),
                if (contactProvider.permissionStatus ==
                    ContactPermission.deniedForever)
                  Container(
                    padding: const EdgeInsets.only(
                      left: 14.0,
                      top: 21.0,
                      right: 14.0,
                    ),
                    child: const Text(
                      'You need to grant permission from settings.',
                      textAlign: TextAlign.center,
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 14.0, top: 21.0, right: 14.0, bottom: 21.0),
                  child: ElevatedButton(
                      child: Text(contactProvider.permissionStatus ==
                              ContactPermission.deniedForever
                          ? 'Open settings'
                          : 'Allow access'),
                      onPressed: () => contactProvider.permissionStatus ==
                              ContactPermission.deniedForever
                          ? openAppSettings()
                          : contactProvider.getContact()),
                ),
              ],
            ),
          );
        } else {
          contacts = contactProvider.contacts;
          widget = (contacts == null)
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: contacts!.length,
                  itemBuilder: (BuildContext context, int index) {
                    Uint8List? image = contacts![index].photo;
                    String num = (contacts![index].phones.isNotEmpty)
                        ? (contacts![index].phones.first.number)
                        : "--";
                    return ListTile(
                      leading: (contacts![index].photo == null)
                          ? const CircleAvatar(child: Icon(Icons.person))
                          : CircleAvatar(backgroundImage: MemoryImage(image!)),
                      title: Text(
                          "${contacts![index].name.first} ${contacts![index].name.last}"),
                      subtitle: Text(num),
                      onTap: () {
                        if (contacts![index].phones.isNotEmpty) {
                          showDialog(
                            context: context,
                            builder: (_) => RatingDialog(
                                name: contacts![index].name.first, number: num),
                          );
                        }
                      },
                    );
                  },
                );
        }

        return Scaffold(body: widget);
      }),
    );
  }
}
