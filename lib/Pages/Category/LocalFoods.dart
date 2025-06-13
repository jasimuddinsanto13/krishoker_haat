import 'package:flutter/material.dart';
import '../../Custom_widgets/category_item_each_custom.dart';

class LocalFoodsPage extends StatelessWidget {
  const LocalFoodsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CategoryItemsPage(categoryName:  'স্থানীয় খাবার (Local Foods)');
  }
}
