import 'package:flutter/material.dart';

class CategoryIconItem extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;

  const CategoryIconItem({
    Key? key,
    required this.image,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(image),
            backgroundColor: Colors.grey[300],
          ),
          SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
