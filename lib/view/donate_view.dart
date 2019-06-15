import 'package:flutter/material.dart';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:snap_bounty/provider/purchase_provider.dart';
import 'package:snap_bounty/widgets/gradient_app_bar.dart';

class DonationsPage extends StatefulWidget {
  @override
  _DonationsPageState createState() => _DonationsPageState();
}

class _DonationsPageState extends State<DonationsPage> {
  final Map<String, Widget> _productIconMap = {
    'tier1_donation': Icon(Icons.cake),
    'tier2_donation': Icon(Icons.local_drink),
    'tier3_donation': Icon(Icons.fastfood),
    'tier4_donation': Icon(Icons.money_off),
    'tier5_donation': Icon(Icons.verified_user)
  };

  final PurchaseProvider _purchaseProvider = PurchaseProvider();
  List<IAPItem> _items;

  @override
  void initState() {
    super.initState();
    initPurchases();
  }

  void initPurchases() async {
    await FlutterInappPurchase.initConnection;
    List<IAPItem> _fetchedItems =
        await _purchaseProvider.getItems(_productIconMap.keys.toList());
    setState(() {
      _items = _fetchedItems;
    });
  }

  @override
  void dispose() async {
    super.dispose();
    await FlutterInappPurchase.endConnection;
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
    if (_items == null) return Center(child: CircularProgressIndicator());
    return ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(height: 20);
        },
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final IAPItem _item = _items[index];
          return ListTile(
            leading: Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: _productIconMap[_item.productId]),
            title: Text(_item.title.split('(')[0]),
            subtitle: Text(_item.description),
            trailing: Text(_item.localizedPrice),
            onTap: () {
              _purchaseProvider.purchase(_item.productId).catchError((error) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('An error occurred. Please try again!'),
                ));
              });
            },
          );
        });
  }
}
