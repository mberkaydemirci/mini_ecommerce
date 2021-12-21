import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/provider/product_provider.dart';
import 'package:mini_ecommerce/provider/user_provider.dart';
import 'package:mini_ecommerce/screens/home_page.dart';
import 'package:mini_ecommerce/screens/loading.dart';
import 'package:mini_ecommerce/screens/login_page.dart';
import 'package:mini_ecommerce/screens/splash.dart';
import 'package:provider/provider.dart';
import 'package:mini_ecommerce/provider/user_provider.dart' as us;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: UserProvider.initialize()),
      ChangeNotifierProvider.value(value: ProductProvider()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
      home: ScreensController(),
    ),
  ));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case us.Status.Uninitialized:
        return Splash();
      case us.Status.Unauthenticated:
      case us.Status.Authenticating:
        return const LoginPage();
      case us.Status.Authenticated:
        return const HomePage();
      default:
        return const LoginPage();
    }
  }
}
