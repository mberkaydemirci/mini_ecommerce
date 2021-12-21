import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  //constants
  static const PRODUCTID = "productId";
  static const PRODUCTCODE = "productCode";
  static const PRODUCTNAME = "productName";
  static const PRICEO = "priceO";

  //private variables
  late String _productId;
  late String _productCode;
  late String _productName;
  late String _priceO;

  String get productId => _productId;
  String get productCode => _productCode;
  String get productName => _productName;
  String get priceO => _priceO;

  ProductModel.fromSnapshot(DocumentSnapshot<Map<dynamic, dynamic>> snapshot) {
    _productId = snapshot.data()![PRODUCTID];
    _productCode = snapshot.data()![PRODUCTCODE];
    _productName = snapshot.data()![PRODUCTNAME];
    _priceO = snapshot.data()![PRICEO];
  }

  ProductModel.fromMap(Map data) {
    _productCode = data[productCode];
    _productName = data[productName];
    _productId = data[productId];
    _priceO = data[_priceO];
  }

  @override
  String toString() {
    return 'ProductModel(_productId: $_productId, _productCode: $_productCode, _productName: $_productName, _priceO: $_priceO)';
  }
}
