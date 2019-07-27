import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

const Map<String, Widget> PRODUCT_ICON_MAP = {
  'tier1_donation': Icon(Icons.cake),
  'tier2_donation': Icon(Icons.local_drink),
  'tier3_donation': Icon(Icons.fastfood),
  'tier4_donation': Icon(Icons.money_off),
  'tier5_donation': Icon(Icons.verified_user)
};

class DonationsPage extends StatefulWidget {
  @override
  _DonationsPageState createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> {
  final InAppPurchaseConnection _inAppPurchase =
      InAppPurchaseConnection.instance;
  List<ProductDetails> _products = [];
  StreamSubscription<List<PurchaseDetails>> _subscription;
  bool _available = true;

  @override
  void initState() {
    Stream _purchaseUpdated = _inAppPurchase.purchaseUpdatedStream;
    _subscription = _purchaseUpdated.listen((purchaseDetailsList) {
      print(purchaseDetailsList.toString());
    });
    initStore();
    super.initState();
  }

  void initStore() async {
    final bool isAvailable = await _inAppPurchase.isAvailable();
    setState(() {
      _available = isAvailable;
    });
    if (isAvailable) {
      await _getProducts();
    }
  }

  @override
  void dispose() async {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> _getProducts() async {
    final ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(PRODUCT_ICON_MAP.keys.toSet());
    setState(() {
      _products = response.productDetails;
    });
  }

  void _buyProduct(ProductDetails product) {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    _inAppPurchase.buyConsumable(
        purchaseParam: purchaseParam, autoConsume: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(flexibleSpace: GradientAppBar('Donations')),
        body: Builder(builder: (BuildContext context) {
          return Padding(
              padding: const EdgeInsets.all(8.0), child: _buildBody(context));
        }));
  }

  Widget _buildBody(BuildContext context) {
    if (_products.length == 0)
      return Center(child: CircularProgressIndicator());
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(height: 20);
        },
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final ProductDetails _product = _products[index];
          return ListTile(
            leading: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: PRODUCT_ICON_MAP[_product.id]),
            title: Text(_product.title.split('(')[0]),
            subtitle: Text(_product.description),
            trailing: RaisedButton(
                child: Text(_product.price),
                color: Colors.greenAccent,
                onPressed: () {
                  _buyProduct(_product);
                }),
            onTap: () {
              _buyProduct(_product);
            },
          );
        });
  }
}
