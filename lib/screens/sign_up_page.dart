import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/helpers/common.dart';
import 'package:mini_ecommerce/provider/user_provider.dart';
import 'package:mini_ecommerce/screens/loading.dart';
import 'package:mini_ecommerce/screens/login_page.dart';
import 'package:mini_ecommerce/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  bool hidePass = true;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences;
  FirebaseDatabase _database = FirebaseDatabase.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? Loading()
          : Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius:
                              20.0, // has the effect of softening the shadow
                        )
                      ],
                    ),
                  ),
                ),
                //EMAIL
                Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                                alignment: Alignment.topCenter,
                                child: Image.asset(
                                  'images/cart.png',
                                  width: 120.0,
//                height: 240.0,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _nameTextController,
                                    decoration: const InputDecoration(
                                      hintText: "Name",
                                      icon: Icon(Icons.person_outline),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "The name field cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                  title: TextFormField(
                                    controller: _emailTextController,
                                    decoration: const InputDecoration(
                                      hintText: "Email",
                                      icon: const Icon(Icons.email),
                                      border: InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex =
                                            new RegExp(pattern.toString());
                                        if (!regex.hasMatch(value))
                                          return 'Please make sure your email address is valid';
                                        else
                                          return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            // PASSWORD
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.grey.withOpacity(0.2),
                              elevation: 0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: ListTile(
                                    title: TextFormField(
                                      controller: _passwordTextController,
                                      obscureText: hidePass,
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        icon: Icon(Icons.password_outlined),
                                        border: InputBorder.none,
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "The password has to be at least 6 characters long";
                                        } else if (_passwordTextController
                                                .text !=
                                            value) {
                                          return "the passwords do not match";
                                        }
                                        return null;
                                      },
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          hidePass = !hidePass;
                                        });
                                      },
                                      icon: Icon(Icons.remove_red_eye),
                                      iconSize: 12,
                                    )),
                              ),
                            ),
                          ),
                          // SIGN UP ------------------------------------------------------
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                            child: Material(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black,
                                elevation: 0,
                                child: MaterialButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      if (!await user.signUp(
                                          _nameTextController.text,
                                          _emailTextController.text,
                                          _passwordTextController.text))
                                        print("if içi signUp");
                                      _key.currentState!.showSnackBar(SnackBar(
                                          content: Text("Sign up failed")));
                                      changeScreenReplacement(
                                          context, LoginPage());
                                      return;
                                    }
                                    print("if dışı");
                                  },
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: const Text(
                                    "Sign Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                )),
                          ),
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "I already have an account",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Divider(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
    );
  }
}
