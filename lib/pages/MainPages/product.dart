import 'package:flutter/material.dart';
import 'package:se_project/pages/MainPages/chats.dart';

class ProductDetails extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final String category;
  final String description;
  final String userDisplayName;
  final String
      userMemberSince; // Date of when the Google account was added to Firebase

  ProductDetails({
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
    required this.userDisplayName,
    required this.userMemberSince,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xff101728),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color:
              Colors.black, // Change this color to make the back button visible
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffEAECF0),
            ),
            SizedBox(height: 10),
            Container(
              width: 362,
              height: 206,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0c101828),
                    offset: Offset(0, 1),
                    blurRadius: 2,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 25),
            Text(
              name,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rs $price',
                  style: TextStyle(fontSize: 24, color: Color(0xff8B8B8B)),
                ),
                Container(
                  width: 64,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Color(0xffE0FFF2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xffE0FFF2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          category,
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xff085938),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 22),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffEAECF0),
            ),
            SizedBox(height: 17),
            Text(
              'Description',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            Container(
              width: 361,
              height: 70,
              child: SingleChildScrollView(
                child: Text(
                  description,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8B8B8B)),
                ),
              ),
            ),
            SizedBox(height: 22),
            Container(
              width: double.infinity,
              height: 1,
              color: Color(0xffEAECF0),
            ),
            SizedBox(height: 22),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                          'lib/assets/Custombanda.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: 10), // Adjust the margin as needed
                      child: Text(
                        userDisplayName,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Member since $userMemberSince',
                      style: TextStyle(fontSize: 12, color: Color(0xff085938)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 33),
            SizedBox(
              width: 360,
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for chat button here

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chats(),
                      ));
                },
                child: Text(
                  'Chat',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xff1cf396),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
