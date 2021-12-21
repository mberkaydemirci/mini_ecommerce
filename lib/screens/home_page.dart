import 'package:flutter/material.dart';
import 'package:mini_ecommerce/helpers/common.dart';
import 'package:mini_ecommerce/helpers/log_in_button.dart';
import 'package:mini_ecommerce/provider/product_provider.dart';
import 'package:mini_ecommerce/provider/user_provider.dart';
import 'package:mini_ecommerce/screens/add_product_page.dart';
import 'package:mini_ecommerce/screens/api_page.dart';
import 'package:mini_ecommerce/screens/product_details_page.dart';
import 'package:mini_ecommerce/screens/product_list_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            LoginButton(
              buttonText: "Product Details",
              buttonColor: Colors.green.shade600,
              textColor: Colors.white,
              radius: 12,
              onPressed: () {
                changeScreen(context, ProductDetails());
              },
            ),
            LoginButton(
              buttonText: "Product Add",
              buttonColor: Colors.green.shade600,
              textColor: Colors.white,
              radius: 12,
              onPressed: () {
                changeScreen(context, AddProduct());
              },
            ),
            LoginButton(
                buttonText: "Product List",
                buttonColor: Colors.green.shade600,
                textColor: white,
                radius: 18,
                onPressed: () {
                  changeScreen(context, ProductList());
                }),
            LoginButton(
                buttonText: "Breaking Bad API",
                buttonColor: Colors.green.shade600,
                textColor: white,
                radius: 18,
                onPressed: () {
                  changeScreen(context, ApiPage());
                }),
            LoginButton(
              buttonText: "Logout",
              buttonColor: Colors.green.shade600,
              textColor: white,
              radius: 18,
              onPressed: () async {
                await user.signOut();
              },
            ),
            /*            ElevatedButton(
                onPressed: () async {
                  await user.signOut();
                },
                child: Text("Logout"))*/
          ],
        ),
      ),
    ));
  }
}
