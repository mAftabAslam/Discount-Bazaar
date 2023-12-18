import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:se_project/pages/Components/snackBar.dart';
import 'package:se_project/pages/MainPages/onboarding.dart';

Future<User?> _getCurrentUser() async {
  return FirebaseAuth.instance.currentUser;
}

class ProfilePage extends StatelessWidget {
 
  Future<void> _signOut(BuildContext context) async {
    // Show confirmation dialog before signing out
    bool confirmSignOut = await _confirmSignOut(context);
    if (confirmSignOut) {
      // Perform sign out logic here
      // For Google sign out:
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();

      _showCustomSnackBar(context, 'Logged out successfully');
      // For Firebase sign out:
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth.signOut();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Onboarding()),
        (Route<dynamic> route) => false,
      );
    }
  }

  Future<bool> _confirmSignOut(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirm Logout'),
              content: Text('Are you sure you want to log out?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // Dismiss the dialog and return false
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(true); // Dismiss the dialog and return true
                  },
                  child: Text('Logout'),
                ),
              ],
            );
          },
        ) ??
        false; // Return false if the dialog is dismissed
  }

  void _showCustomSnackBar(BuildContext context, String message) {
    CustomSnackBar(
      message: message,
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<User?>(
              future: _getCurrentUser(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    User? user = snapshot.data;
                    return Text(
                      'Welcome, ${user?.displayName ?? "User"}',
                      style: TextStyle(fontSize: 20),
                    );
                  } else {
                    return Text('User not found');
                  }
                }
                return CircularProgressIndicator();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
