import 'package:flutter/material.dart';
import 'package:krishokerhaat/Pages/BottomNavigateBarPages/cartpage/MyOrders.dart';
import 'package:krishokerhaat/Pages/SellerPage/MyItemsPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final greenColor = const Color(0xFF2E7D32);

  // Profile Info (initial values)
  String name = 'Smart Farmer';
  String phone = '+8801XXXXXXXXX';
  String email = 'farmer@smartkrishi.com';
  String address = 'Village Road, Narsingdi, BD';
  String dob = '15-06-1985';

  void _editField(String title, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $title"),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: title,
            border: const OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Widget buildInfoTile(IconData icon, String label, String value, Function(String) onEdit) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: greenColor),
      title: Text(label, style: const TextStyle(color: Colors.black54, fontSize: 14)),
      subtitle: Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      trailing: IconButton(
        icon: const Icon(Icons.edit, size: 20),
        onPressed: () => _editField(label, value, onEdit),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Green Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 60, bottom: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [greenColor, greenColor.withOpacity(0.9)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage('https://i.imgur.com/QCNbOAo.png'),
                ),
                const SizedBox(height: 10),
                Text('@${name.toLowerCase().replaceAll(' ', '')}',
                    style: const TextStyle(color: Colors.white, fontSize: 20)),
                Text(email, style: const TextStyle(color: Colors.white70)),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text('Back to Home'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: greenColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                )
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Text(
              'Seller Info',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.shopping_bag, color: greenColor),
              title: const Text(
                'My Orders',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyOrderPage()));
              },
            ),

            ListTile(
              leading: Icon(Icons.shopping_bag, color: greenColor),
              title: const Text(
                'My Items on sell',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyItemsPage()));
              },
            ),
              ],
            ),
          ),



          // Account Info
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Account Info',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                buildInfoTile(Icons.person, 'Name', name, (val) => setState(() => name = val)),
                buildInfoTile(Icons.phone, 'Mobile', phone, (val) => setState(() => phone = val)),
                buildInfoTile(Icons.email, 'Email', email, (val) => setState(() => email = val)),
                buildInfoTile(Icons.home, 'Address', address, (val) => setState(() => address = val)),
                buildInfoTile(Icons.calendar_today, 'D.O.B', dob, (val) => setState(() => dob = val)),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
