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
    'Jars',
    'Bottles',
    'Grains',
    'Dairy',
    'Cans',
    'Bulk',
    'Fruits',
    'Vegetables',
    'Frozen',
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
    } else if (_itemNameController.text.length > 12 && showError) {
      _showCustomSnackBar(context, 'Name should not exceed 12 characters');
      showError = false;
    }

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
      appBar: AppBar(
        title: Text(
          'Your Ads',
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
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 25),
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0x19000000)),
                      color: Color(0xffffffff),
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
                    child: _pickedImage != null
                        ? Image.file(_pickedImage!, fit: BoxFit.cover)
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 12),
                                  width: 40,
                                  height: 40,
                                  child: Image.asset(
                                    'lib/assets/upload.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tap to upload',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff085938),
                                      ),
                                    ),
                                    Text(
                                      ' from your gallery',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff667084),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 5),

                // Name Input Field
                Container(
                  width: double.infinity,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344053),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffcfd4dc)),
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0c101828),
                              offset: Offset(0, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _itemNameController,
                          decoration: InputDecoration(
                            hintText: 'Enter your item name',
                            hintStyle: TextStyle(
                              color: Color(0xffa9a9a9),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Item Price Input Field
                Container(
                  width: double.infinity,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Price',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344053),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffcfd4dc)),
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0c101828),
                              offset: Offset(0, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _itemPriceController,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              color: Color(0xffa9a9a9),
                            ),
                            prefix: Text(
                              'Rs ',
                              style: TextStyle(
                                color: Color(0xff344053),
                              ),
                            ),
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 14),
                            border: InputBorder.none,
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Category Dropdown
                Container(
                  width: double.infinity,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344053),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 44,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffcfd4dc)),
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0c101828),
                              offset: Offset(0, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField<String>(
                          value: _selectedCategory,
                          items: _categories.map((String category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select Category',
                            hintStyle: TextStyle(
                              color: Color(0xffa9a9a9),
                            ),
                          ),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Description Input Field
                Container(
                  width: double.infinity,
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff344053),
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        width: double.infinity,
                        height: 108,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Color(0xffcfd4dc)),
                          color: Color(0xffffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x0c101828),
                              offset: Offset(0, 1),
                              blurRadius: 1,
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            hintText: 'Enter your description',
                            hintStyle: TextStyle(
                              color: Color(0xffa9a9a9),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                          ),
                          maxLines: 3,
                          onChanged: (value) {
                            setState(() {
                              _description = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),

                // Post Ad Button
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 1,
                    shadowColor: Color(0x0c101828),
                    primary: Color(0xff1cf396),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 44,
                    child: Center(
                      child: Text(
                        'Post Ad',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
