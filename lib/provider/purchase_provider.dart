import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class PurchaseProvider {
  Future<List<IAPItem>> getItems(List<String> productIds) async {
    return await FlutterInappPurchase.getProducts(productIds);
  }

  Future<PurchasedItem> purchase(IAPItem item) async {
    return await FlutterInappPurchase.buyProduct(item.productId);
  }
}
