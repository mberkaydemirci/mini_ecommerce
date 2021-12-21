import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const UID = "uid";
  static const NAME = "name";
  static const EMAIL = "email";
  static const PASSWORD = "password";

  String? _name;
  String? _email;
  String? _uid;
  String? _password;

  String? get name => _name;
  String? get email => _email;
  String? get id => _uid;
  String? get password => _password;

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    _uid = snapshot.data()![UID];
    _name = snapshot.data()![NAME];
    _email = snapshot.data()![EMAIL];
    _password = snapshot.data()![PASSWORD];
  }
}
