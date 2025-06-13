import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krishokerhaat/Pages/SellerPage/MyItemsPage.dart';

class AddMoreDetailsPage extends StatefulWidget {
  final String productName;
  final String category;
  final String description;
  final List<File> images;

  AddMoreDetailsPage({
    required this.productName,
    required this.category,
    required this.description,
    required this.images,
  });

  @override
  _AddMoreDetailsPageState createState() => _AddMoreDetailsPageState();
}

class _AddMoreDetailsPageState extends State<AddMoreDetailsPage> {
  final TextEditingController priceController = TextEditingController();
  bool allowCalls = true;
  String negotiationStatus = "Yes, can be done";
  bool isSubmitting = false;

  void _showNegotiationOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Select negotiation option',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        negotiationStatus = "Yes, can be done";
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text("Yes"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        negotiationStatus = "No";
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                    child: Text("No"),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> submitProduct() async {
    if (priceController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a price')),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    final uri = Uri.parse('http://10.0.2.2:8000/api/products/'); // <-- Emulator-safe URL

    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = widget.productName;
    request.fields['category'] = widget.category;
    request.fields['price'] = priceController.text.trim();
    request.fields['negotiation_status'] = negotiationStatus;
    request.fields['allow_calls'] = allowCalls ? 'true' : 'false';

    if (widget.description.trim().isNotEmpty) {
      request.fields['description'] = widget.description;
    }

    try {
      if (widget.images.isNotEmpty) {
        for (var imageFile in widget.images) {
          var stream = http.ByteStream(imageFile.openRead());
          var length = await imageFile.length();

          var multipartFile = http.MultipartFile(
            'uploaded_images', // Make sure this matches your Django image field
            stream,
            length,
            filename: imageFile.path.split('/').last,
          );

          request.files.add(multipartFile);
        }
      }
    } catch (e) {
      print('Image processing error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Image error')));
      setState(() {
        isSubmitting = false;
      });
      return;
    }

    try {
      var response = await request.send();

      if (response.statusCode == 201 || response.statusCode == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => MyItemsPage()),
        );
      } else {
        String respStr = await response.stream.bytesToString();
        print('Status: ${response.statusCode}');
        print('Body: $respStr');
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to post product')));
      }
    } catch (e) {
      print('Submit error: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Network error')));
    }

    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add more details', style: TextStyle(color: Colors.green)),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.green),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product preview
            Row(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  color: Colors.grey[300],
                  child: widget.images.isNotEmpty
                      ? Image.file(widget.images[0], fit: BoxFit.cover)
                      : Icon(Icons.image, color: Colors.grey[600]),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.productName,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('With shipping charge'),
                      Text(widget.category,
                          style: TextStyle(color: Colors.green)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 24),

            /// Price input
            Text("Price details", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Selling price',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),

            /// Negotiation option
            GestureDetector(
              onTap: _showNegotiationOptions,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Negotiation"),
                  Text(
                    negotiationStatus,
                    style: TextStyle(
                      color: negotiationStatus == "No"
                          ? Colors.redAccent
                          : Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            /// Call permission
            Text("Contact option", style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Allow buyers to call you"),
                Switch(
                  value: allowCalls,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      allowCalls = value;
                    });
                  },
                ),
              ],
            ),

            Spacer(),

            /// Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : submitProduct,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isSubmitting
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
                    : Text("Post in Haat",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
