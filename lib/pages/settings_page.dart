import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            // Displaying User's Information
            if (currentUser != null) ...[
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      (currentUser != null && currentUser.displayName != null && currentUser.displayName!.isNotEmpty)
                          ? currentUser.displayName!.substring(0, 1)
                          : 'U',  // Default to 'U' if displayName is null or empty
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  title: Text(
                    'Logged in as: ${currentUser?.displayName ?? 'User'}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(currentUser?.email ?? 'No Email'),
                ),
              ),

            ],
            const SizedBox(height: 16),
            // Dark/Light Mode Toggle
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              child: ListTile(
                title: Text(
                  Provider.of<ThemeProvider>(context).isDarkMode ? 'Light Mode' : 'Dark Mode',
                ),
                trailing: CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
                  activeColor: Colors.blueAccent,
                  trackColor: Colors.grey.shade300,
                  thumbColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Additional Settings Options
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('Privacy Policy'),
                onTap: () {
                  // Handle navigation to Privacy Policy
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 4,
              child: ListTile(
                leading: const Icon(Icons.article),
                title: const Text('Terms of Service'),
                onTap: () {
                  // Handle navigation to Terms of Service
                },
              ),
            ),
            const SizedBox(height: 16),
            // Logout Option
            // Card(
            //   margin: const EdgeInsets.symmetric(vertical: 10),
            //   elevation: 4,
            //   child: ListTile(
            //     leading: const Icon(Icons.logout),
            //     title: const Text('Logout'),
            //     onTap: () {
            //       // Handle logout logic
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
