import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:se_project/pages/MainPages/edit.dart';

class MyAds extends StatelessWidget {
  final String userId;

  const MyAds({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Your Ads',
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
      body: _buildAdsList(),
    );
  }

  Widget _buildAdsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('ads')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No ads available.'));
        }

        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
            var ad = snapshot.data!.docs[index];
            return _buildAdCard(ad, context);
          },
        );
      },
    );
  }

  Widget _buildAdCard(DocumentSnapshot ad, BuildContext context) {
    Future<void> _confirmDelete(BuildContext context) async {
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
                        child: Icon(
                          Icons.delete,
                          size: 48,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        'Confirm Delete',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff101728),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Are you sure you want to delete this ad?',
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
                  // Actions: Delete and Cancel Buttons
                  SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await _deleteAd(ad);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12), // Adjusted space
                  SizedBox(
                    height: 44,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
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
      );
    }

    void _editAd(DocumentSnapshot ad) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditScreen(ad: ad),
        ),
      );
    }

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAdImage(ad['imageUrl']),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad['name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${ad['category']}',
                  style: TextStyle(fontSize: 16.0, color: Colors.grey),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Rs ${ad['price']}',
                  style: TextStyle(color: Colors.green, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(ad['description']),
                SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _editAd(ad),
                        child: Text(
                          'Edit',
                          style: TextStyle(color: Color(0xff085938)),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffD4FAE1)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Adding space between buttons
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _confirmDelete(context),
                        child: Text(
                          'Delete',
                          style: TextStyle(color: Colors.black),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xff1CF396)),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdImage(String imageUrl) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          10, 10, 10, 0), // Padding top: 10, left: 10, right: 10
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Adding border radius
        // Setting a default color for the container
      ),
      child: AspectRatio(
        aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(10), // Applying border radius to the image
          child: imageUrl.isNotEmpty
              ? Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Icon(
                    Icons.image,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }

  Future<void> _deleteAd(DocumentSnapshot ad) async {
    try {
      // Delete image from Firebase Storage
      String imageUrl = ad['imageUrl'];
      if (imageUrl.isNotEmpty) {
        Reference storageRef = FirebaseStorage.instance.refFromURL(imageUrl);
        await storageRef.delete();
      }

      // Delete ad document from Firestore
      await ad.reference.delete();
    } catch (e) {
      print('Error deleting ad: $e');
      // Handle error as needed
    }
  }
}
