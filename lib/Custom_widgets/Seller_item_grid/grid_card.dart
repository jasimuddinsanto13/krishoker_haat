import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String? imageUrl;
  final String name;
  final String price;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            child: imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(imageUrl!, width: 110, height: 110, fit: BoxFit.cover)
                : Container(
              width: 110,
              height: 110,
              color: Colors.grey,
              child: const Icon(Icons.image, size: 50, color: Colors.white),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 8),
                  Text('৳$price',
                      style: TextStyle(fontSize: 14, color: Colors.green[700])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
