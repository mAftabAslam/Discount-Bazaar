import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:se_project/homePagealt.dart';
import 'dart:io';

import 'package:se_project/pages/Components/snackBar.dart';

class Sell extends StatefulWidget {
  final String userId;

  const Sell({Key? key, required this.userId}) : super(key: key);

  @override
  State<Sell> createState() => _SellState();
}

class _SellState extends State<Sell> {
  late CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;
  late String _imageUrl = ''; // URL of the uploaded image

  Future<void> _getImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path); // Store picked image file
      });

      // Uploading image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}');
      UploadTask uploadTask = storageReference.putFile(File(pickedFile.path));

      await uploadTask.whenComplete(() async {
        // Retrieving the uploaded image URL
        String downloadURL = await storageReference.getDownloadURL();
        setState(() {
          _imageUrl = downloadURL;
        });
      }).catchError((onError) {
        // Handle upload error
        print('Error uploading image: $onError');
      });
    }
  }

  void _showCustomSnackBar(BuildContext context, String message) {
    CustomSnackBar(
      message: message,
    ).show(context);
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _itemNameController = TextEditingController();
  TextEditingController _itemPriceController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;
  String _description = '';

  List<String> _categories = [
    'Vegetables',
    'Jars',
    'Fruits',
    'Dairy',
    'Grains',
  ];

  void _submitForm() async {
    bool showError = true; // Flag to control showing error Snackbars

    if (_imageUrl.isEmpty) {
      _showCustomSnackBar(context, 'Please add a picture');
      showError = false;
    }

    if (_itemNameController.text.isEmpty && showError) {
      _showCustomSnackBar(context, 'Please enter item name');
      showError = false;
    }

    if (_itemPriceController.text.isEmpty &&
        double.tryParse(_itemPriceController.text) == null &&
        showError) {
      _showCustomSnackBar(context, 'Please enter a valid item price');
      showError = false;
    }

    if (_selectedCategory == null && showError) {
      _showCustomSnackBar(context, 'Please select a category');
      showError = false;
    }

    if (_description.isEmpty && _description.length < 10 && showError) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Description should be at least 10 characters'),
        ),
      );
      showError = false;
    } else if (showError) {
      try {
        // Reference to the user's document using the passed userId
        DocumentReference userDocRef = users.doc(widget.userId);

        // Add the ad to the 'ads' subcollection under the user's document
        await userDocRef.collection('ads').add({
          'name': _itemNameController.text,
          'price': double.parse(_itemPriceController.text),
          'category': _selectedCategory,
          'description': _description,
          'imageUrl': _imageUrl, // Add the image URL to Firestore
        });

        print('Item posted to Firestore!');
        _itemNameController.clear();
        _itemPriceController.clear();
        _selectedCategory = null;
        _descriptionController.clear();
        _imageUrl = ''; // Reset the image URL after posting

        _showCustomSnackBar(context, 'Add Posted Succesfully');
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home2(userId: widget.userId),
            ));
      } catch (e, stackTrace) {
        print('Error adding item: $e');
        print('Stack trace: $stackTrace');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sell")),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _getImage,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300], // Placeholder color
                  child:
                      _pickedImage != null // Display picked image if available
                          ? Image.file(_pickedImage!, fit: BoxFit.cover)
                          : Center(child: Icon(Icons.add_a_photo, size: 60)),
                ),
              ),
              TextFormField(
                controller: _itemNameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
              ),
              TextFormField(
                controller: _itemPriceController,
                decoration: const InputDecoration(
                  labelText: 'Item Price',
                  prefixText: 'Rs ', // Adding 'Rs' as prefix
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                items: _categories.map((String category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                hint: const Text('Select Category'),
                onChanged: (String? value) {
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Post Ad'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
