import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  int _selectedIndex = 0; // To track bottom navigation selection

  final List<String> _menuItems = ["Market", "Orders", "Profile"]; // Menu options

  // Method to handle navigation in bottom navigation bar
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildContent() {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Firebase initialization failed!',
              style: TextStyle(fontSize: 18, color: Colors.red),
            ),
          );
        }

        return StreamBuilder<QuerySnapshot>(
          stream: productsRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error fetching products!',
                  style: TextStyle(fontSize: 18, color: Colors.red),
                ),
              );
            }
            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final products = snapshot.data!.docs.map((doc) {
                return doc.data() as Map<String, dynamic>;
              }).toList();

              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.shopping_bag,
                          color: Theme.of(context).primaryColor),
                      title: Text(
                        product['name'] ?? 'Unnamed Product',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        'Price: ₹${product['price'] ?? 'N/A'}',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Selected: ${product['name'] ?? 'Unnamed Product'}'),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'No products available',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Check screen width to determine if it's desktop or mobile
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: Text('Marketplace'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          if (isDesktop) // Desktop Side Menu
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelType: NavigationRailLabelType.all,
              destinations: _menuItems
                  .map((item) => NavigationRailDestination(
                        icon: Icon(Icons.circle),
                        selectedIcon: Icon(Icons.circle_rounded),
                        label: Text(item),
                      ))
                  .toList(),
            ),
          Expanded(child: _buildContent()), // Main Content
        ],
      ),
      bottomNavigationBar: isDesktop
          ? null // No bottom nav for desktop
          : BottomNavigationBar(
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: _menuItems
                  .map((item) => BottomNavigationBarItem(
                        icon: Icon(Icons.circle),
                        label: item,
                      ))
                  .toList(),
            ),
    );
  }
}
