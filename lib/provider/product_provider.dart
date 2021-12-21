import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/model/product_model.dart';
import 'package:mini_ecommerce/services/product_service.dart';
import 'package:uuid/uuid.dart';

class ProductProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String ref = 'products';
  List<ProductModel> products = [];
  ProductService _productService = ProductService();

  loadProducts() async {
    //_firestore.collection("products").get();
    products = await _productService.getProducts();
    notifyListeners();
  }

  void uploadProduct(Map<String, dynamic> data) {
    var id = Uuid();
    String productId = id.v1();
    data["productId"] = productId;
    _firestore.collection(ref).doc(productId).set(data);
  }
}
