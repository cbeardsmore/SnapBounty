import 'package:flutter/material.dart';
import '../widgets/gradient_app_bar.dart';

class PrimaryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradientAppBar('Challenges'),
      ),
    );
  }
}
