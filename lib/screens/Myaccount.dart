import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/auth_sservice.dart';

class MyAccountPage extends StatelessWidget {
  final AuthService _authService = AuthService();

  Future<void> _changePassword(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Prompt the user to enter their current password
        String currentPassword = await _showPasswordPrompt(context, 'Enter Current Password');

        // Prompt the user to enter the new password
        String newPassword = await _showPasswordPrompt(context, 'Enter New Password');

        // Reauthenticate the user with their current password
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );

        await user.reauthenticateWithCredential(credential);

        // Now you can change the password
        await FirebaseAuth.instance.currentUser?.updatePassword(newPassword);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password changed successfully.'),
          ),
        );
      } else {
        throw FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found. Please sign in again.',
        );
      }
    } catch (e) {
      print('Error changing password: $e');

      // Cast the exception to FirebaseAuthException
      if (e is FirebaseAuthException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error changing password. Please try again.'),
        ),
      );
    }
  }

  Future<String> _showPasswordPrompt(BuildContext context, String title) async {
    String password = '';

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: TextField(
            obscureText: true,
            onChanged: (value) {
              password = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(password);
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );

    return password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // User Information Card
          _buildCard(
            title: 'User Information',
            child: FutureBuilder<User?>(
              future: FirebaseAuth.instance.authStateChanges().first,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                User? user = snapshot.data;

                if (user != null) {
                  return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    future: FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
                    builder: (context, userSnapshot) {
                      if (userSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      }

                      if (userSnapshot.hasError) {
                        return Text('Error loading user data.');
                      }

                      Map<String, dynamic>? userData = userSnapshot.data?.data();

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${user.email}'),
                          SizedBox(height: 5),
                          Text('User Name: ${userData?['username'] ?? "Not set"}'), // Fetch username from user data
                          SizedBox(height: 10),
                          // Add more user information as needed
                        ],
                      );
                    },
                  );
                } else {
                  return Text('User not logged in.');
                }
              },
            ),
          ),

          SizedBox(height: 20),

          // Account Settings Card
          _buildCard(
            title: 'Account Settings',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildListTile(
                  title: 'Change Password',
                  onTap: () {
                    // Call the function to change the password
                    _changePassword(context);
                  },
                ),
                _buildListTile(
                  title: 'Edit Profile',
                  onTap: () {
                    // Implement edit profile functionality
                    // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage()));
                  },
                ),
                // Add more settings and options as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildListTile({required String title, required VoidCallback onTap}) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}