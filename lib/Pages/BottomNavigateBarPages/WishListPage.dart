import 'package:flutter/material.dart';
import 'package:krishokerhaat/Custom_widgets/Seller_item_grid/my_item_grid.dart';
import '../../Custom_widgets/bottom_navigation_bar.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
        title:  Center(
          child: Text(
            'Wishlist Page Content',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),

      body: Column(
        children: [

        ],
      ),
     // bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 1),
    );
  }
}
