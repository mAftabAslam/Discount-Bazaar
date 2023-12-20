import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // For Firestore
import 'package:firebase_storage/firebase_storage.dart'; // For Firebase Storage
import 'package:image_picker/image_picker.dart'; // For Image Picker
import 'dart:io';

class EditScreen extends StatefulWidget {
  final DocumentSnapshot ad;

  const EditScreen({Key? key, required this.ad}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  String _selectedCategory = '';
  late ImagePicker _picker; // Declare _picker variable
  File? _pickedImage; // Declare _pickedImage variable
  late String _imageUrl; // Declare _imageUrl variable

  final List<String> categories = [
    'Jars',
    'Bottles',
    'Grains',
    'Dairy',
    'Processed Food',
    'Bulk',
    'Fruits',
    'Vegetables',
  ];

  @override
  void initState() {
    super.initState();
    _picker = ImagePicker();
    _nameController = TextEditingController(text: widget.ad['name']);
    _priceController =
        TextEditingController(text: widget.ad['price'].toString());
    _descriptionController =
        TextEditingController(text: widget.ad['description']);
    _selectedCategory = widget.ad['category'];
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateAd() async {
    try {
      print('Name: ${_nameController.text}');
      print('Price: ${_priceController.text}');
      print('Description: ${_descriptionController.text}');
      print('Category: $_selectedCategory');

      if (_pickedImage != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(_pickedImage!);

        await uploadTask.whenComplete(() async {
          String downloadURL = await storageReference.getDownloadURL();
          setState(() {
            _imageUrl = downloadURL;
          });
        }).catchError((onError) {
          print('Error uploading image: $onError');
        });
      }

      // Update Firestore document with new details including image URL if available
      Map<String, dynamic> updateData = {
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'description': _descriptionController.text,
        'category': _selectedCategory,
      };

      if (_pickedImage != null) {
        updateData['imageUrl'] = _imageUrl;
      }

      await widget.ad.reference.update(updateData);

      Navigator.pop(context); // Go back to the previous screen after update
    } catch (e) {
      print('Error updating ad: $e');
      // Handle error as needed
    }
  }

  Future<void> _pickAndUploadImage() async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Ad',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Color(0xff101728),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
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
                  onTap: _pickAndUploadImage,
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
                          color: Color(0x0f101728),
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
                        : Image.network(widget.ad['imageUrl'],
                            fit: BoxFit.cover),
                  ),
                ),
                SizedBox(height: 5),
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
                          controller: _nameController,
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
                // ... (similar styling for other fields)
                Container(
                  width: double.infinity,
                  height: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
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
                          controller: _priceController,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            hintText: 'Enter the price',
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
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCategory = newValue!;
                            });
                          },
                          items: categories.map((category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Text(category),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 14),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: double.infinity,
                  height: 150, // Adjust height as needed
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
                        height: 100, // Adjust height as needed
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
                          maxLines:
                              null, // Allow multiple lines for description
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            hintText: 'Enter the description',
                            hintStyle: TextStyle(
                              color: Color(0xffa9a9a9),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  onPressed: _updateAd,
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
                        'Update',
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
