import 'package:flutter/material.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/cartpage/confirm_order.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Payment Mode Header
              Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    const Text(
                      'Payment Mode',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    // You can add progress indicators here
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.grey),

              // Mobile Banking Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MOBILE BANKING',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentOption(
                      icon: 'assets/bkash_logo.png',
                      label: 'bKash',
                      onTap: () {
                        print('bKash selected');
                      },
                    ),
                    const Divider(height: 1, color: Colors.grey),
                    _buildPaymentOption(
                      icon: 'assets/nagad_logo.png',
                      label: 'Nagad',
                      onTap: () {
                        print('Nagad selected');
                      },
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Colors.grey),

              // Cash Section
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CASH',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildPaymentOption(
                      icon: 'assets/cash_delivery_icon.png',
                      label: 'Cash on Delivery',
                      onTap: () {
                        print('Cash on Delivery selected');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Confirm Order Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ConfirmOrderPage()));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Confirm Order'),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentOption({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            Image.asset(
              icon,
              width: 10, // Smaller size
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 16.0),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
