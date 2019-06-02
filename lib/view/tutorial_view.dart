import 'package:flutter/material.dart';

import 'package:snap_bounty/widgets/gradient_app_bar.dart';

class TutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: GradientAppBar('How to Play'),
        ),
        body: PageView(
          controller: PageController(viewportFraction: 0.8),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset('assets/tutorial1.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset('assets/tutorial2.png'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Image.asset('assets/tutorial3.png'),
            ),
          ],
        ));
  }
}
