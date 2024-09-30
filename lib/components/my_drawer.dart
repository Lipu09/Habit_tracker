import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../pages/settings_page.dart';
import '../service/auth/auth_gate.dart';
import '../service/auth/auth_service.dart';
import 'package:provider/provider.dart';
import '../pages/login_page.dart'; // Import your login page

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  // Access auth service
  final _auth = AuthService();

  // Logout
  Future<void> logout(BuildContext context) async {
    try {
      await _auth.logout();
      // Navigate to the AuthGate or Login Page after logout
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthGate()), // Use your AuthGate page
            (Route<dynamic> route) => false, // Clear the navigation stack
      );
    } catch (e) {
      // Handle error here, e.g., show a Snackbar or AlertDialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logout failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    (currentUser?.displayName != null && currentUser!.displayName!.isNotEmpty)
                        ? currentUser.displayName!.substring(0, 1)
                        : 'U',
                    style: TextStyle(fontSize: 24),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  foregroundColor: Colors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  currentUser?.displayName ?? 'Guest',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  currentUser?.email ?? 'No Email',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('H O M E'),
            onTap: () {
              // Handle navigation to home
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('S E T T I N G S'),
            onTap: () {
              // Navigate to SettingsPage
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          const SizedBox(height: 200), // Adding space before the logout button
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('L O G O U T'),
            onTap: () => logout(context), // Pass context to the logout function
          ),
        ],
      ),
    );
  }
}
