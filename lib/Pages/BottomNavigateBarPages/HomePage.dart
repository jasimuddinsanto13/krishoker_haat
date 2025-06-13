import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krishokerhaat/Custom_widgets/Seller_item_grid/my_item_grid.dart';
import 'package:krishokerhaat/Custom_widgets/bottom_navigation_bar.dart';
import 'package:krishokerhaat/Custom_widgets/category_icons.dart';
import 'package:krishokerhaat/Custom_widgets/section_title.dart';
import 'package:krishokerhaat/Pages/Category/Cloths.dart';
import 'package:krishokerhaat/Pages/Category/Fishes.dart';
import 'package:krishokerhaat/Pages/Category/Homemade%20Items.dart';
import 'package:krishokerhaat/Pages/Category/LocalFoods.dart';
import 'package:krishokerhaat/Pages/Category/PlantsandSeeds.dart';
import 'package:krishokerhaat/utils/media_query.dart';

import '../Category/Fruits.dart';
import '../Category/Vegetables.dart';
import '../../Auth/profilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> _productsFuture;

  // For filter chip selection state
  String _selectedFilter = "Newest";

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProducts(filter: _selectedFilter);
  }

  Future<List<dynamic>> fetchProducts({String? filter}) async {
    // Modify your URL here if your API supports filter query parameters
    final url = Uri.parse('http://192.168.0.102:8000/api/products/');

    try {
      final response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        // Handle if response is List directly
        if (jsonData is List) {
          return jsonData;
        }
        // Handle if response is Map with results key
        else if (jsonData is Map && jsonData.containsKey('results')) {
          return jsonData['results'];
        } else {
          throw Exception('Unexpected JSON format');
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  void _onFilterSelected(String filter) {
    setState(() {
      _selectedFilter = filter;
      _productsFuture = fetchProducts(filter: filter);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Top bar
            Container(
              height: SizeConfig.screenHeight * 0.2,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top row: Profile icon and notification icon
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProfilePage()),
                              );
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.person, color: Colors.green),
                            ),
                          ),
                          const Icon(Icons.notifications, color: Colors.white),
                        ],
                      ),
                    ),

                    // Search bar
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.search, color: Colors.green),
                          SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search",
                                border: InputBorder.none,
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Icon(Icons.tune, color: Colors.green),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Special For You Section
            const SectionTitle(title: "#SpecialForYou"),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (_, index) => Container(
                  width: 220,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Category Section
            const SectionTitle(title: "Category"),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryIconItem(
                    image: "",
                    label: "Fruits",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FruitsPage()),
                      );
                    },
                  ),
                  const SizedBox(width: 15),
                  CategoryIconItem(image: "", label: "Vegetables", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VegetablesPage()));

                  }),
                  const SizedBox(width: 15),
                  CategoryIconItem(image: "", label: "Cloths", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ClothsPage()));
                  }),
                  const SizedBox(width: 15),
                  CategoryIconItem(
                      image: "", label: "Handmade Items", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeMadeItemsPage()));

                  }),
                  const SizedBox(width: 15),
                  CategoryIconItem(image: "", label: "Local Foods", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LocalFoodsPage()));

                  }),
                  const SizedBox(width: 15),
                  CategoryIconItem(image: "", label: "Plants", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PlantsandSeedsPage()));

                  }),
                  const SizedBox(width: 15),
                  CategoryIconItem(image: "", label: "Fishes", onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>FishesPage()));

                  }),
                  const SizedBox(width: 15),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Flash Sell Header and Filter Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Flash Sell",
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () {
                    // TODO: Implement "See all" functionality if needed
                  },
                  child: const Text("See all", style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Filter Chips Row
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: ["All", "Newest", "Popular"].map((filter) {
                  final selected = filter == _selectedFilter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(filter),
                      selected: selected,
                      selectedColor: Colors.green,
                      backgroundColor: Colors.grey[200],
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : Colors.black,
                      ),
                      onSelected: (_) => _onFilterSelected(filter),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 10),
            MyItemsGrid(),


            // Products List from backend
       /*    FutureBuilder<List<dynamic>>(
              future: _productsFuture,
              builder: (context, snapshot) {
                 if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                          'Error loading products: ${snapshot.error.toString()}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                final products = snapshot.data!;
                return ListView.separated(
                  physics:
                  const NeverScrollableScrollPhysics(), // disable inner scroll
                  shrinkWrap: true,
                  itemCount: products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final imageUrl = product['images'] != null &&
                        product['images'].isNotEmpty
                        ? product['images'][0]['image']
                        : null;
                    final name = product['name'] ?? 'No Name';
                    final price = product['price']?.toString() ?? '0';

                    return _productCard(imageUrl, name, price);
                  },
                );
              },
            ), */
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(currentIndex: 0),
    );
  }
}
