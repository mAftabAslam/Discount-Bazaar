import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  void handleCategoryTap(String categoryName) {
    // Action when any category card is tapped
    print('$categoryName tapped!');
    // Navigate or perform any other actions here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Categories',
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
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 24, 14, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(bottom: 15, right: 200), // Add margin here
                child: Text(
                  'Popular Categories',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // ...existing buildCategoryCard widgets...
              // Add more buildCategoryCard widgets for other categories
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Jars',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Bottles',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Dairy',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Bulk',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Fruits',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Vegetables',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Cans',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Grains',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
              buildCategoryCard(
                imageUrl: '[Image URL 2]',
                title: 'Frozen',
                onTap: () {
                  handleCategoryTap('Bottles');
                },
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCategoryCard({
    required String imageUrl,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 2, 0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xffeaecf0)),
          color: Color(0xffd4fae1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 12),
                width: 40,
                height: 40,
                child: Image.asset(
                  'lib/assets/tag.png',
                  width: 40,
                  height: 40,
                ),
              ),
              Expanded(
                // Ensures the text takes available space
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff101728),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 8),
                width: 5.51,
                height: 12,
                child: Image.asset(
                  'lib/assets/arrow.png',
                  width: 5.51,
                  height: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
