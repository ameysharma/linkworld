import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: unused_import
import 'package:firebase_core/firebase_core.dart';
import 'profile_page.dart';  // Import ProfilePage here

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CollectionReference productsRef =
      FirebaseFirestore.instance.collection('products');

  int _selectedIndex = 0; // To track bottom navigation selection
  final List<String> _menuItems = ["Market", "Orders", "Profile"]; // Menu options

    setState(() {
      _selectedIndex = index;
    });
  }

  // Marketplace Page Content
  Widget _buildMarketplaceSection() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 600; // Determine if it's desktop layout

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildMarketplaceCard(
                      title: 'Buy Products',
                      color: Colors.green[100],
                      icon: Icons.shopping_cart,
                      iconColor: Colors.green,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigating to Buy section...')),
                        );
                      },
                    ),
                    _buildMarketplaceCard(
                      title: 'Sell Products',
                      color: Colors.blue[100],
                      icon: Icons.sell,
                      iconColor: Colors.blue,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigating to Sell section...')),
                        );
                      },
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildMarketplaceCard(
                      title: 'Buy Products',
                      color: Colors.green[100],
                      icon: Icons.shopping_cart,
                      iconColor: Colors.green,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigating to Buy section...')),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    _buildMarketplaceCard(
                      title: 'Sell Products',
                      color: Colors.blue[100],
                      icon: Icons.sell,
                      iconColor: Colors.blue,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Navigating to Sell section...')),
                        );
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildMarketplaceCard({
    required String title,
    required Color? color,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: color,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 50, color: iconColor),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Orders Section
  Widget _buildOrdersSection() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.shopping_bag, size: 50, color: Colors.orange),
          SizedBox(height: 10),
          Text(
            'Orders Section',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text('Here you can view and manage your orders.'),
        ],
      ),
    );
  }

  // Content Builder
  Widget _buildContent() {
    if (_selectedIndex == 0) {
      return _buildMarketplaceSection(); // Show Marketplace Section for "Market"
    } else if (_selectedIndex == 1) {
      return _buildOrdersSection(); // Show Orders Section
    } else {
      return const ProfilePage(); // Show Profile Section (from profile_page.dart)
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check screen width to determine if it's desktop or mobile
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        centerTitle: true,
        // Adding the Hamburger menu icon to open the Drawer
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openEndDrawer(); // Open the drawer
            },
          ),
        ],
      ),
      body: Row(
        children: [
          // Desktop layout with the Sidebar Menu (NavigationRail)
          if (isDesktop) 
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: _onItemTapped,
              labelType: NavigationRailLabelType.all,
              destinations: _menuItems
                  .map((item) => NavigationRailDestination(
                        icon: const Icon(Icons.circle),
                        selectedIcon: const Icon(Icons.circle_rounded),
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
                        icon: const Icon(Icons.circle),
                        label: item,
                      ))
                  .toList(),
            ),
      endDrawer: Drawer(  // Right-side drawer (for mobile)
        child: ListView(
          padding: EdgeInsets.zero,
          children: _menuItems.map((item) {
            return ListTile(
              title: Text(item),
              onTap: () {
                int index = _menuItems.indexOf(item);
                setState(() {
                  _selectedIndex = index;
                });
                Navigator.pop(context);  // Close the drawer after item selection
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
