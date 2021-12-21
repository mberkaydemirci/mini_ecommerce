import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mini_ecommerce/model/product_model.dart';

class ProductService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String collection = "products";

  Future<List<ProductModel>> getProducts() async =>
      _firestore.collection("products").get().then((result) {
        List<ProductModel> products = [];
        for (DocumentSnapshot<Map<String, dynamic>> product in result.docs) {
          products.add(ProductModel.fromSnapshot(product));
        }
        return products;
      });
}
