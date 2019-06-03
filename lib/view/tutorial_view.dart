import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:snap_bounty/widgets/gradient_app_bar.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('How to Play'),
        ),
        body: _buildCarousel(context) 
    );
  }

  Widget _buildCarousel(BuildContext context) {
    return Container(
      child: Carousel(
        images: [
          AssetImage('assets/tutorial1.jpg'),
          AssetImage('assets/tutorial2.jpg'),
          AssetImage('assets/tutorial3.jpg')
        ],
        dotColor: Theme.of(context).primaryColor,
        dotBgColor: Theme.of(context).accentColor.withOpacity(0.7),
      ),
    );
  }
}
