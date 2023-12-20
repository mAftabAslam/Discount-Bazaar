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
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x07101828),
                      offset: Offset(0, 8),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Color(0x14101828),
                      offset: Offset(0, 20),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Content: Title and Message
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 16),
                          width: 48,
                          height: 48,
                          child: Image.asset(
                            'lib/assets/tickIcon.png',
                            width: 48,
                            height: 48,
                          ),
                        ),
                        Text(
                          'Confirm Logout',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff101728),
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Do you want to logout from Discount Bazaar?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff667084),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24), // Adjusted space
                    // Actions: Confirm and Cancel Buttons
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xff1cf396),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12), // Adjusted space
                    SizedBox(
                      height: 44,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xffcfd4dc)),
                          backgroundColor: Color(0xffffffff),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344053),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
        title: Text(
          'Your Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xff101728),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white, // Setting white background
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/Custombanda.png',
                width: 177.01,
                height: 177.01,
              ),
              SizedBox(height: 30),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<User?>(
                    future: _getCurrentUser(),
                    builder:
                        (BuildContext context, AsyncSnapshot<User?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        // Display a loading indicator while fetching data
                        return CircularProgressIndicator(); // You can replace this with your own loading widget
                      } else {
                        if (snapshot.hasData && snapshot.data != null) {
                          // Use the user's display name if available
                          String displayName =
                              snapshot.data!.displayName ?? 'No Name';
                          return Text(
                            displayName,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          );
                        } else {
                          // If no user is logged in or data fetching failed
                          return Text(
                            'No User',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: 52,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Color(0xffe0fff2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff085938),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50),
                  GestureDetector(
                    onTap: () => _signOut(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xffeaecf0)),
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout, // Replace with your logout icon
                            size: 18,
                            color: Color.fromARGB(255, 236, 3, 3),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Logout',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
