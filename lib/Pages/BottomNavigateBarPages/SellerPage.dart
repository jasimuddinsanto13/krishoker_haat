import 'package:flutter/material.dart';

import '../../Custom_widgets/bottom_navigation_bar.dart';

class SellerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Add New Item Page Content', style: TextStyle(fontSize: 24)),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 2,),
    );
  }
}