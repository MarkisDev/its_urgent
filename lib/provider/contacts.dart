import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';

enum ContactPermission { granted, denied, deniedForever }

class ContactsProvider extends ChangeNotifier {
  ContactPermission _permissionStatus = ContactPermission.denied;
  List<Contact>? _contacts;

  ContactPermission get permissionStatus => _permissionStatus;
  List<Contact>? get contacts => _contacts;

  set contacts(List<Contact>? val) {
    if (val != contacts) {
      _contacts = val;
      notifyListeners();
    }
  }

  set permissionStatus(ContactPermission val) {
    if (val != permissionStatus) {
      _permissionStatus = val;
      notifyListeners();
    }
  }

  Future<bool> requestContactPermission() async {
    PermissionStatus result = await Permission.contacts.request();
    if (result.isGranted) {
      permissionStatus = ContactPermission.granted;
      return true;
    } else if (result.isDenied) {
      permissionStatus = ContactPermission.denied;
    } else if (result.isPermanentlyDenied) {
      permissionStatus = ContactPermission.deniedForever;
    }
    return false;
  }

  void getContact() async {
    final result = await requestContactPermission();
    if (result) {
      contacts = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    }
  }
}
