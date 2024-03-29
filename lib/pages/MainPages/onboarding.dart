import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:se_project/homePagealt.dart';
import 'package:se_project/pages/Components/snackBar.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key});

// Google Sign In With Firebase
  Future<String?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential =
        await auth.signInWithCredential(credential);

    // Return the user ID or null if the user is not signed in
    return userCredential.user?.uid;
  }

  void _showCustomSnackBar(BuildContext context, String message) {
    CustomSnackBar(
      message: message,
    ).show(context);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 42, 0, 0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 41),
              width: double.infinity,
              height: 414,
              child: Stack(
                children: [
                  Positioned(
                    left: 317,
                    top: -10,
                    child: TextButton(
                      onPressed: () {
                        // Add your onPressed logic here
                      },
                      child: const SizedBox(
                        width: 30,
                        height: 24,
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.7142857143,
                            color: Color(0xFF000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 108,
                    top: 6,
                    child: Align(
                      child: SizedBox(
                        width: 327,
                        height: 399,
                        child: Image.asset(
                          'lib/assets/Object.png', // Replace with your image URL
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 165,
                    top: 233,
                    child: Align(
                      child: SizedBox(
                        width: 64,
                        height: 64,
                        child: SvgPicture.asset(
                          'lib/assets/Logo.svg', // Replace with your image URL
                          width: 64,
                          height: 64,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 134,
                    top: 302,
                    child: Align(
                      child: SizedBox(
                        width: 132,
                        height: 31,
                        child: Text(
                          'DISCOUNT',
                          style: TextStyle(
                            fontFamily: 'Cabinet Grotesk',
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            height: 1.2575,
                            letterSpacing: 1.2,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 126,
                    top: 329,
                    child: Align(
                      child: SizedBox(
                        width: 148,
                        height: 11,
                        child: Text(
                          'BAZAAR',
                          style: TextStyle(
                            fontFamily: 'Cabinet Grotesk',
                            fontSize: 8,
                            fontWeight: FontWeight.w400,
                            height: 1.2575,
                            letterSpacing: 18.48,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 7, 12),
              child: const Text(
                'Welcome To Discount Bazaar!',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 1,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 25, 0),
              constraints: const BoxConstraints(
                maxWidth: 332,
              ),
              child: const Text(
                'Buy and Sell whatever unnecessary grocery\nitem you have in your houses.',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                  color: Color(0xFF000000),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(16, 38, 16, 26),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      String? userId = await signInWithGoogle();
                      if (userId != null) {
                        _showCustomSnackBar(context, 'Logged in Succesfully');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => Home2(userId: userId)),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(90.74, 10, 90.5, 10),
                      primary: const Color(0xff1cf396),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            color: Color(
                                0x0c101828)), // Replace with your shadow color
                      ),
                      elevation: 1, // Adjust elevation as needed
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 10.23, 0),
                          width: 23.53,
                          height: 24,
                          child: SvgPicture.asset(
                            'lib/assets/Google icon.svg', // Replace with your image asset path
                            width: 23.53,
                            height: 24,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: Color(0xff000000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(93, 25, 88, 0),
                    width: double.infinity,
                    height: 41,
                    child: const Stack(
                      children: [
                        Positioned(
                          left: 1,
                          top: 17,
                          child: Align(
                            child: SizedBox(
                              width: 180, // Adjust width as needed
                              height: 24,
                              child: Row(
                                children: [
                                  Text(
                                    'Made with ',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.7142857143,
                                      color: Color(0xff085938),
                                    ),
                                  ),
                                  Icon(
                                    Icons.favorite,
                                    size: 18,
                                    color: Color(0xff1cf396),
                                  ),
                                  Text(
                                    ' by Arsalan',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.7142857143,
                                      color: Color(0xff085938),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
