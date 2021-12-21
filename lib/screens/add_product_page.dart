import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mini_ecommerce/helpers/common.dart';
import 'package:mini_ecommerce/provider/product_provider.dart';
import 'package:mini_ecommerce/services/product_service.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  ProductProvider product = ProductProvider();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productCodeController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: const Icon(
          Icons.close,
          color: Colors.black,
        ),
        title: const Text(
          "add product",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading
              ? CircularProgressIndicator()
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'enter a product name with 10 characters at maximum',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: red, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productNameController,
                        decoration: InputDecoration(hintText: 'Product name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must enter the product name';
                          } else if (value.length > 10) {
                            return 'Product name cant have more than 10 letters';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: productCodeController,
                        decoration: InputDecoration(hintText: 'Product code'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must enter the product code';
                          } else if (value.length > 10) {
                            return 'Product name cant have more than 10 letters';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        controller: priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Price',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'You must enter the product name';
                          }
                        },
                      ),
                    ),
                    FlatButton(
                      color: red,
                      textColor: white,
                      child: Text('add product'),
                      onPressed: () {
                        Fluttertoast.showToast(msg: "adding product");
                        validateAndUpload();
                      },
                    )
                  ],
                ),
        ),
      ),
    );
  }

  void validateAndUpload() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);
      product.uploadProduct({
        "productName": productNameController.text,
        "priceO": priceController.text,
        'productCode': productCodeController.text
      });
      _formKey.currentState!.reset();
      setState(() => isLoading = false);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Product Added");
    }
  }
}
