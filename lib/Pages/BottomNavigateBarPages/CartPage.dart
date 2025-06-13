import 'package:flutter/material.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/cartpage/addressPage.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int _mangoQuantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cart Item
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://i.imgur.com/example_mango_cart.jpg',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                      const Icon(Icons.image, size: 80, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mango (Rupali)',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Shibpur Collegiate, Narsingdi, Dhaka',
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[700]),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (_mangoQuantity > 0) _mangoQuantity--;
                                });
                              },
                              child: const Icon(Icons.remove_circle_outline,
                                  color: Colors.grey),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              '$_mangoQuantity',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(width: 8.0),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _mangoQuantity++;
                                });
                              },
                              child: const Icon(Icons.add_circle_outline,
                                  color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '৳ ${_mangoQuantity * 120}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800]),
                  ),
                ],
              ),
            ),

            // Promocode
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              color: Colors.green[50],
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Add Promocode',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle apply promocode
                    },
                    child: const Text(
                      'Apply',
                      style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            // Order Summary
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildSummaryRow('Cart total', '৳ ${_mangoQuantity * 120}'),
                  const SizedBox(height: 8.0),
                  _buildSummaryRow('Delivery Fee', '৳ 60'),
                  const SizedBox(height: 8.0),
                  _buildSummaryRow('Promocode', '৳ 00'),
                ],
              ),
            ),
            const SizedBox(height: 80), // Spacer for bottom bar visibility
          ],
        ),
      ),

      // Bottom fixed Checkout button
      bottomNavigationBar: Container(
        color: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AddressSelectionPage()));
              },
              child: const Text(
                'Checkout Now',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Text(
              'Total',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              '৳ ${_mangoQuantity * 120 + 60}', // Dynamic total
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 16, color: Colors.black)),
        Text(value,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
      ],
    );
  }
}
