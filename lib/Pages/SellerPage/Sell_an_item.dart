import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'AddMoreDetails.dart';

class SellItemPage extends StatefulWidget {
  const SellItemPage({super.key});

  @override
  State<SellItemPage> createState() => _SellItemPageState();
}

class _SellItemPageState extends State<SellItemPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;
  final List<String> _categories = [
    'ফল (Fruits)',
    'শাকসবজি (Vegetables)',
    'কাপড় (Cloths)',
    'হস্তশিল্প (Handmade Items)',
    'স্থানীয় খাবার (Local Foods)',
    'গাছপালা (Plants)',
    'মাছ (Fishes)',

  ];

  final ImagePicker _picker = ImagePicker();
  final List<File> _images = [];
  final int maxImages = 5;
  final int minImages = 0; // No minimum images required

  @override
  void initState() {
    super.initState();
    _selectedCategory = _categories[1]; // 'ফল (Fruits)' as default
  }

  Future<void> _pickImage() async {
    if (_images.length >= maxImages) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Maximum 5 images allowed.')),
      );
      return;
    }

    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  void _onNextPressed() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category.')),
      );
      return;
    }

    // Navigate to AddMoreDetailsPage
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddMoreDetailsPage(
        productName: _productNameController.text.trim(),
        category: _selectedCategory!,
        description: _descriptionController.text.trim(),
        images: _images,)),
    );


    // No navigation here, so it stays on this page
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double imageBoxSize = 90;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF228B22),
        title: const Text(
          'Sell an Item',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add Images',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: imageBoxSize,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _images.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _images.length) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              width: imageBoxSize,
                              height: imageBoxSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(_images[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black54,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(Icons.close,
                                      color: Colors.white, size: 18),
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            margin: const EdgeInsets.only(right: 8),
                            width: imageBoxSize,
                            height: imageBoxSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _images.length < maxImages
                                    ? Colors.grey
                                    : Colors.grey.shade300,
                                width: 1,
                              ),
                            ),
                            child: _images.length < maxImages
                                ? const Center(
                              child: Icon(Icons.add,
                                  color: Color(0xFF228B22), size: 30),
                            )
                                : Center(
                              child: Text(
                                'Max\nImages',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 12),
                              ),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Product Name',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(
                    hintText: 'e.g., তাজা পেয়ারা (Fresh Guava)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                      const BorderSide(color: Color(0xFF228B22), width: 2),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product name cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                const Text(
                  'Product Category',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                      const BorderSide(color: Color(0xFF228B22), width: 2),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  hint: const Text('Select Category'),
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) =>
                  value == null ? 'Please select a category' : null,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Description (Optional)',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText:
                    'e.g., মিষ্টি এবং রসালো, সরাসরি বাগান থেকে সংগ্রহিত (Sweet and juicy, directly collected from the garden)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                      const BorderSide(color: Color(0xFF228B22), width: 2),
                    ),
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _onNextPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF228B22),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
