import 'package:flutter/material.dart';
import 'package:krishokerhaat/Pages/SellerPage/AddMoreDetails.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/CartPage.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/SellerPage.dart';
import 'package:krishokerhaat/Pages/SellerPage/Sell_an_item.dart';

// Import your pages here
import '../Pages/BottomNavigateBarPages/ChatPage.dart';
import '../Pages/BottomNavigateBarPages/HomePage.dart';
import '../Pages/BottomNavigateBarPages/WishListPage.dart';


class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  const BottomNavigationBarWidget({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  void _navigateToPage(BuildContext context, int index) {
    Widget page;
    switch (index) {
      case 0:
        page =  HomePage();
        break;
      case 1:
        page =  WishlistPage();
        break;
      case 2:
        page =  SellItemPage();
        break;
      case 3:
        page = CartPage();
        break;
      case 4:
        page = ChatPage();
        break;
      default:
        page = HomePage();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _navigateToPage(context, index),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: "Wishlist"),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle, size: 50, color: Colors.green),
          label: "",
        ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
      ],
    );
  }
}
