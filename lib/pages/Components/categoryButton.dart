import 'package:flutter/material.dart';
import 'package:se_project/pages/MainPages/categories.dart';
import 'package:se_project/pages/MainPages/categoryResultScreen.dart';

class CategoryButton extends StatelessWidget {
  final String text;

  const CategoryButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryAdsScreen(category: text),
          ),
        );
      },
      child: Container(
        width: 84,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xffe0fff2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1,
              color: Color(0xff085938),
            ),
          ),
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final List<String> categories;

  const CategorySection({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Row(
          children: [
            const Text(
              'Categories',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 1.5,
                color: Color(0xff000000),
              ),
            ),
            const Spacer(),
            InkWell(
              onTap: () {
                // Handle onTap logic to view all categories
                // Navigator.push(...);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Categories(),
                    ));
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(10), // Set the radius here
                ),
                child: Container(
                  padding: const EdgeInsets.all(1), // Padding for the tap area
                  child: const Text(
                    'See all',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 2,
                      color: Color(0xff085938),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(height: 17),
        Row(
          children: categories
              .map((category) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.3),
                    child: CategoryButton(text: category),
                  ))
              .toList(),
        ),
        const SizedBox(height: 18),
      ],
    );
  }
}
