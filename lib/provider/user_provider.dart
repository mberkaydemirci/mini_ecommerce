import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/helpers/common.dart';
import 'package:mini_ecommerce/model/user_model.dart';
import 'package:mini_ecommerce/screens/login_page.dart';
import 'package:mini_ecommerce/services/user_service.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserProvider with ChangeNotifier {
  FirebaseAuth? _auth = FirebaseAuth.instance;
  User? _user;
  Status _status = Status.Uninitialized;
  UserServices _userServices = UserServices();
  UserModel? _userModel;
  String? uid;
  UserModel? get userModel => _userModel;
  Status get status => _status;
  User? get user => _user;

  UserProvider.initialize() : _auth = FirebaseAuth.instance {
    _auth?.authStateChanges().listen((_onStateChanged));
  }
  Future<void> _onStateChanged(User? user) async {
    if (_user == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = user;
      _userModel = await _userServices.getUserById(user!.uid);
      _status = Status.Authenticated;
    }
    notifyListeners();
  }

  Future<bool> signIn(String email, String password) async {
    _status = Status.Authenticating;
    notifyListeners();
    await _auth!
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      uid = value.user!.uid;
      print(value.user!.uid);
      _userModel = await _userServices.getUserById(value.user!.uid);
      notifyListeners();
    });
    return true;
  }

  Future signOut() async {
    await _auth!.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> reloadUserModel() async {
    _userModel = await _userServices.getUserById(uid.toString());
    notifyListeners();
  }

  Future<bool> signUp(String name, String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth!
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {
        print("CREATE USER");
        _userServices.createUser({
          'name': name,
          'email': email,
          'uid': user.user!.uid,
          'password': password,
        });
        _userModel = await _userServices.getUserById(user.user!.uid);
        notifyListeners();
      });
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> signInAnonymously() async {
    try {
      UserCredential result = await _auth!.signInAnonymously();
      return true;
    } catch (e) {
      print("ERROR Anonymous" + e.toString());
      return false;
    }
  }
}
