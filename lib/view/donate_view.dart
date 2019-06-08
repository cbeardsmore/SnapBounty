import 'package:flutter/material.dart';

import 'package:snap_bounty/widgets/gradient_app_bar.dart';

class DonationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('Donations'),
        ),
        body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.cake),
          title: Text('Chocolate Bar'),
          subtitle:
              Text('Everyone loves a treat, help feed my sugar addiction.'),
          trailing: Text("\$0.99"),
        ),
        Divider(height: 10),
        ListTile(
          leading: Icon(Icons.local_drink),
          title: Text('Red Bull'),
          subtitle:
              Text('Keep me up at night fixing the endless list of bugs.'),
          trailing: Text("\$2.99"),
        ),
        Divider(height: 10),
        ListTile(
          leading: Icon(Icons.fastfood),
          title: Text('Lunch'),
          subtitle:
              Text('Buy me a decent healthy meal.'),
          trailing: Text("\$5.99"),
        ),
        Divider(height: 10),
        ListTile(
          leading: Icon(Icons.money_off),
          title: Text('Ad Free'),
          subtitle:
              Text('Help keep those damn ads off this platform.'),
          trailing: Text("\$9.99"),
        ),
        Divider(height: 10),
      ],
    ));
  }
}
