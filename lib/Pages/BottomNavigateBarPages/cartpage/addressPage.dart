
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishokerhaat/Custom_widgets/popup/new_address_alert_form.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/cartpage/payment.dart';

class AddressSelectionPage extends StatefulWidget {
  const AddressSelectionPage({super.key});

  @override
  State<AddressSelectionPage> createState() => _AddressSelectionPageState();
}

class _AddressSelectionPageState extends State<AddressSelectionPage> {
  // State to manage which address is selected
  int? _selectedAddress; // Null means no address is selected initially

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Green app bar as per image
        elevation: 0, // No shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // White back icon
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        title: const Text(
          'Select Address',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), // White title
        ),
        centerTitle: true, // Center the title
      ),
      body: Column(
        children: [
          // Top green section with progress indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: Colors.green,
            child: const Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 28), // Location icon
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          '-----------', // Dashed line
                          style: TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 2),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Icon(Icons.home, color: Colors.white, size: 28), // Home icon
                  ],
                ),
                SizedBox(height: 10),
                // You can add text indicators here if needed for steps, e.g., "Address" "Payment"
              ],
            ),
          ),

          // Main content area for addresses
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Address 1 Card
                  _buildAddressCard(
                    context: context,
                    index: 0,
                    title: 'Address 1 (Delivery)',
                    details:
                    'Shibpur Collagagate,Narsingdi,\nDhaka,Bangladesh',
                    phone: '0123456789',
                    email: 'abc@gmail.com',
                  ),
                  const SizedBox(height: 16), // Space between cards

                  // Address 2 Card
                  _buildAddressCard(
                    context: context,
                    index: 1,
                    title: 'Address 2',
                    details:
                    'Shibpur Collagagate,Narsingdi,\nDhaka,Bangladesh',
                    phone: '0123456789',
                    email: 'abc@gmail.com',
                  ),
                  const SizedBox(height: 24), // Space before add new address button

                  OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddAddressDialog(
                          onAdd: (address, phone, email) {
                            print('New Address: $address');
                            print('Phone: $phone');
                            print('Email: $email');

                            // You could add the new address to a state-managed list here
                            // setState(() => _addresses.add(...));
                          },
                        ),
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.green, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    ),
                    child: const Text(
                      'Add a new address',
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    ),
                  ),

                ],
              ),
            ),
          ),

          // Bottom "Next" button
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.green, // Green background for the button container
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: _selectedAddress != null
                  ? () {
                // Handle "Next" button press with selected address
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentMethodPage()));
              }
                  : null, // Disable button if no address is selected
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White button background
                foregroundColor: Colors.green, // Green text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Slightly rounded corners
                ),
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              child: const Text('Next'),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build an address card
  Widget _buildAddressCard({
    required BuildContext context,
    required int index,
    required String title,
    required String details,
    required String phone,
    required String email,
  }) {
    bool isSelected = _selectedAddress == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAddress = index; // Update selected address
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey.shade300, // Green border if selected
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Radio<int>(
              value: index,
              groupValue: _selectedAddress,
              onChanged: (int? value) {
                setState(() {
                  _selectedAddress = value;
                });
              },
              activeColor: Colors.green, // Green color for selected radio button
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    details,
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Phone : $phone',
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Email : $email',
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}