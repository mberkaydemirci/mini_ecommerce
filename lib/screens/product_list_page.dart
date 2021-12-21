import 'package:flutter/material.dart';
import 'package:mini_ecommerce/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    product.loadProducts();
    return Scaffold(
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
                          ],
                        ),
                      ),
                    )))
                .toList(),
          ),
        ),
      ),
    );
  }
}
