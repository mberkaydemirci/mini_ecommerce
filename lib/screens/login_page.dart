import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_ecommerce/helpers/common.dart';
import 'package:mini_ecommerce/provider/user_provider.dart';
import 'package:mini_ecommerce/screens/sign_up_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  late SharedPreferences preferences;
  bool loading = false;

  late String userUid;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status == Status.Authenticating
          ? HomePage()
          : Stack(
              children: <Widget>[
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 50.0, bottom: 50),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 20,
                            )
                          ]),
                      child: Form(
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Container(
                                    alignment: Alignment.topCenter,
                                    child: Image.asset(
                                      'images/cart.png',
                                      width: 120.0,
                                      //                height: 240.0,
                                    )),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _emailTextController,
                                      decoration: const InputDecoration(
                                        hintText: "Email",
                                        icon: const Icon(Icons.email),
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
                                // PASSWORD
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                child: Material(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.grey.withOpacity(0.2),
                                  elevation: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0),
                                    child: TextFormField(
                                      controller: _passwordTextController,
                                      decoration: const InputDecoration(
                                        hintText: "Password",
                                        icon: Icon(Icons.password_outlined),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "The password field cannot be empty";
                                        } else if (value.length < 6) {
                                          return "The password has to be at least 6 characters long";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),

                                // NEW PADDING
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                child: Material(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.black,
                                    elevation: 0,
                                    child: MaterialButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          if (!await user.signIn(
                                              _emailTextController.text,
                                              _passwordTextController.text))
                                            _key.currentState!.showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        "Sign in failed")));
                                        }
                                      },
                                      minWidth:
                                          MediaQuery.of(context).size.width,
                                      child: const Text(
                                        "Login",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    )),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(14.0, 8, 14, 8),
                                    child: Text(
                                      "Forgot password",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignUpPage()));
                                          },
                                          child: Text(
                                            "Create an account",
                                            textAlign: TextAlign.center,
                                            style:
                                                TextStyle(color: Colors.black),
                                          ))),
                                ],
                              ),
                            ],
                          )),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
