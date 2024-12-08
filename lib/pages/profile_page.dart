import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header with avatar and username
          Row(
            children: [
              CircleAvatar(
                radius: 50, // Adjust size of the profile image
                backgroundColor: Colors.blue, // Using a solid color as the placeholder
                child: const Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.white, // Icon color
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'John Doe', // Replace with dynamic user data
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'john.doe@example.com', // Replace with dynamic user data
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          // User details & Settings buttons
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Button for editing profile
                  ListTile(
                    leading: const Icon(Icons.edit, color: Colors.blue),
                    title: const Text(
                      'Edit Profile',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      // Handle Edit Profile action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Navigating to Edit Profile...')),
                      );
                    },
                  ),
                  const Divider(), // Divider between options

                  // Button for changing password
                  ListTile(
                    leading: const Icon(Icons.lock, color: Colors.blue),
                    title: const Text(
                      'Change Password',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      // Handle Change Password action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Navigating to Change Password...')),
                      );
                    },
                  ),
                  const Divider(), // Divider between options

                  // Button for viewing order history
                  ListTile(
                    leading: const Icon(Icons.history, color: Colors.blue),
                    title: const Text(
                      'Order History',
                      style: TextStyle(fontSize: 18),
                    ),
                    onTap: () {
                      // Handle View Order History action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Navigating to Order History...')),
                      );
                    },
                  ),
                  const Divider(), // Divider between options

                  // Button for logging out
                  ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.blue),
                    title: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 18, color: Colors.red),
                    ),
                    onTap: () {
                      // Handle Logout action
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Logging out...')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
