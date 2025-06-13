

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/cartpage/MyOrders.dart';

class ConfirmOrderPage extends StatelessWidget {
  const ConfirmOrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    // A strong green for the AppBar, mimicking the gradient
    final Color appBarColor = Colors.green[700]!;

    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey background for the whole page
      appBar: AppBar(
        backgroundColor: appBarColor, // Green AppBar
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            // Handle back button press
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          'CONFIRM ORDER',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          // Progress indicators
          Icon(Icons.location_on, color: Colors.white, size: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('.....', style: TextStyle(color: Colors.white)),
          ),
          Icon(Icons.credit_card, color: Colors.white, size: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0),
            child: Text('.....', style: TextStyle(color: Colors.white)),
          ),
          Icon(Icons.check_circle, color: Colors.white, size: 20), // Solid check for completion
          SizedBox(width: 10), // Spacing from the right edge
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // White background for the main content area
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView( // Make the content scrollable if it overflows
            child: Padding(
              padding: const EdgeInsets.all(24.0), // Padding inside the white container
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Illustration (Placeholder - replace with your actual image asset)
                  Image.network(
                    'https://via.placeholder.com/200x150/90EE90/FFFFFF?text=Order+Success', // Placeholder URL
                    // Or use Image.asset('assets/order_success_illustration.png') if you have it locally
                    height: 150,
                    width: 200,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Your Order has been placed successfully !!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'You can check your order process in my orders section.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  // MY ORDERS Button
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrderPage()));
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey[700], // Darker grey text to contrast
                      side: BorderSide(color: Colors.grey[400]!, width: 1), // Light grey border
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'MY ORDERS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60), // Space before the bottom button

                  // CONTINUE SHOPPING Button
                  SizedBox(
                    width: double.infinity, // Makes the button full width
                    child: ElevatedButton(
                      onPressed: () {
                        // Continue shopping action
                        print('Continue Shopping');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appBarColor, // Green button
                        foregroundColor: Colors.white, // White text
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 0, // No shadow for a flat look
                      ),
                      child: const Text(
                        'CONTINUE SHOPPING',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}