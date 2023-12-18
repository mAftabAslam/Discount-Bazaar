import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyAds extends StatelessWidget {
  final String userId;

  const MyAds({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Ads')),
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
          return AlertDialog(
            title: Text('Confirm Delete'),
            content: Text('Are you sure you want to delete this ad?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(); // Dismiss the dialog
                  await _deleteAd(ad); // Call delete method
                },
                child: Text('Delete'),
              ),
            ],
          );
        },
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
                Text(
                  'Rs ${ad['price']}',
                  style: TextStyle(color: Colors.green, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                Text(ad['description']),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () =>
                      _confirmDelete(context), // Confirm before delete
                  child: Text('Delete'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdImage(String imageUrl) {
    return AspectRatio(
      aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
      child: imageUrl.isNotEmpty
          ? Image.network(
              imageUrl,
              fit: BoxFit.cover,
            )
          : Container(color: Colors.grey[300]),
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
