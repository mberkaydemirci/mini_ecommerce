import 'package:flutter/material.dart';
import 'package:mini_ecommerce/helpers/common.dart';
import 'package:mini_ecommerce/model/product_model.dart';
import 'package:mini_ecommerce/model/user_model.dart';
import 'package:mini_ecommerce/provider/product_provider.dart';
import 'package:mini_ecommerce/screens/product_details_page.dart';
import 'package:mini_ecommerce/services/product_service.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    product.loadProducts();
    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 100.0),
        child: Container(
          child: Column(
            children: product.products
                .map((item) => GestureDetector(
                        child: Container(
                      child: Center(
                        child: Column(
                          children: [
                            Text("Product Name" + item.productName),
                            Text("Product Price" + item.priceO),
                            Text("Product Code" + item.productCode + "\n \n"),
                          ],
                        ),
                      ),
                    )))
                .toList(),
          ),
        ),
      ),
      /*ListView(
        children: [
          Text(product.products.toList().toString()),
        ],
      ),*/
    );
  }
}
