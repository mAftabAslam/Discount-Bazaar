import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se_project/pages/MainPages/product.dart';

class HorizontalCardList extends StatelessWidget {
  const HorizontalCardList({Key? key});
  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: getCurrentUser(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (userSnapshot.hasError) {
          return Text('Error: ${userSnapshot.error}');
        } else {
          User? currentUser = userSnapshot.data;

          return StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collectionGroup('ads').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<DocumentSnapshot> data = snapshot.data!.docs.toList();
                return SizedBox(
                  height: 220,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(data.length, (index) {
                        var item = data[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: buildCard(item, context, currentUser),
                        );
                      }),
                    ),
                  ),
                );
              }
            },
          );
        }
      },
    );
  }

  Widget buildCard(
      DocumentSnapshot item, BuildContext context, User? currentUser) {
    String userDisplayName = currentUser?.displayName ?? 'Default Name';
    DateTime userCreationDate =
        currentUser?.metadata.creationTime ?? DateTime.now();
    String userMemberSince =
        '${userCreationDate.day}/${userCreationDate.month}/${userCreationDate.year}';
    return Container(
      width: 177,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0x0f101828),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x19101828),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  item['imageUrl'],
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ),
                Container(
                  width: 46,
                  height: 19,
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xffe0fff2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      item['category'],
                      style: TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff085938),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 6),
            child: Text(
              'Rs ' + item['price'].toString(),
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                color: Color(0xff8b8b8b),
              ),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetails(
                        imageUrl: item['imageUrl'],
                        name: item['name'],
                        price: item['price'],
                        category: item['category'],
                        description: item['description'],
                        userDisplayName: userDisplayName,
                        userMemberSince: userMemberSince,
                      ),
                    ));
                // Add your onTap functionality here
              },
              child: Container(
                width: 168,
                height: 35,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                decoration: BoxDecoration(
                  color: const Color(0xff1cf396),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'More Details',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff000000),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
