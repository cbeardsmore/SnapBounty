import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class PurchaseProvider {
  Future<List<IAPItem>> getItems(List<String> productIds) async {
    return await FlutterInappPurchase.getProducts(productIds);
  }

  Future<PurchasedItem> purchase(String productId) async {
    try {
      return await FlutterInappPurchase.buyProduct(productId);
    } on PlatformException catch (error, stackTrace) {
      return Future.error(error, stackTrace);
    }
  }
}
