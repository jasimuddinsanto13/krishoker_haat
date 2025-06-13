import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/CartPage.dart';

class MyOrderPage extends StatelessWidget {
  const MyOrderPage({super.key});

  // Sample data for orders
  final List<Map<String, dynamic>> orders = const [
    {
      'productImage': 'https://picsum.photos/seed/product1/100/100',
      'productName': 'Pink Cotton Tshirt',
      'customerName': 'Samantha Smith',
      'customerLocation': 'New York, USA',
      'orderDate': '24 Jun, 11:40',
      'orderId': '224154',
      'payment': '30.50',
      'productId': 'TST11414',
      'qty': '1',
      'orderStatus': 'Pending',
    },
    {
      'productImage': 'https://picsum.photos/seed/product2/100/100',
      'productName': 'Summer Full Sleeve T-shirt',
      'customerName': 'Emili Williamson',
      'customerLocation': 'Hamilton, USA',
      'orderDate': '24 Jun, 10:22',
      'orderId': '224126',
      'payment': '39.50',
      'productId': 'TST11887',
      'qty': '1',
      'orderStatus': 'Pending',
    },
    {
      'productImage': 'https://picsum.photos/seed/product3/100/100',
      'productName': 'Floral Print Shirt',
      'customerName': 'George Taylor',
      'customerLocation': 'New York, USA',
      'orderDate': '24 Jun, 10:49',
      'orderId': '224112',
      'payment': '30.50',
      'productId': 'TST11887',
      'qty': '1',
      'orderStatus': 'Pending',
    },
    {
      'productImage': 'https://picsum.photos/seed/product4/100/100',
      'productName': 'Pink Cotton Tshirt', // Duplicate to match screenshot
      'customerName': 'Samantha Smith',
      'customerLocation': 'New York, USA',
      'orderDate': '24 Jun, 11:40',
      'orderId': '224154',
      'payment': '30.50',
      'productId': 'TST11414',
      'qty': '1',
      'orderStatus': 'Pending',
    },
    {
      'productImage': 'https://picsum.photos/seed/product5/100/100',
      'productName': 'Summer Full Sleeve T-shirt', // Duplicate to match screenshot
      'customerName': 'Samantha Smith',
      'customerLocation': 'New York, USA',
      'orderDate': '24 Jun, 10:22',
      'orderId': '224126',
      'payment': '39.50',
      'productId': 'TST11887',
      'qty': '1',
      'orderStatus': 'Pending',
    },
    {
      'productImage': 'https://picsum.photos/seed/product6/100/100',
      'productName': 'Product six',
      'customerName': 'Customer Name',
      'customerLocation': 'New York, USA',
      'orderDate': '24 Jun, 10:22',
      'orderId': '224127',
      'payment': '45.00',
      'productId': 'TST11888',
      'qty': '2',
      'orderStatus': 'Processing',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white), // Hamburger menu icon
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white), // Search icon (optional)
            onPressed: () {
              // Handle search
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white), // Cart icon (optional)
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return _buildOrderItemCard(order);
        },
      ),
    );
  }

  Widget _buildOrderItemCard(Map<String, dynamic> order) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  order['productImage'],
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                      Container(
                        width: 80,
                        height: 80,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
                ),
              ),
              const SizedBox(width: 12),
              // Product details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order['productName'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${order['customerName']} | ${order['customerLocation']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Ordered on ${order['orderDate']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Order ID ${order['orderId']}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(height: 24, thickness: 1, color: Colors.grey), // Separator line
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    '\$${order['payment']}', // Assuming currency is USD as per image
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product ID',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    order['productId'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Qty.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    order['qty'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end, // Align to right
                children: [
                  Text(
                    'Order Status',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  Text(
                    order['orderStatus'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.purple.shade300, // Purple for "Pending"
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}