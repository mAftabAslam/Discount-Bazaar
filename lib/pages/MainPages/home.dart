import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se_project/pages/Components/Trending.dart';
import 'package:se_project/pages/Components/categoryButton.dart';
import 'package:se_project/pages/Components/searchBar.dart';
import 'package:se_project/pages/Components/slideshow.dart';
import 'package:se_project/pages/MainPages/categories.dart';
import 'package:se_project/pages/MainPages/notifications.dart';
import 'package:se_project/pages/MainPages/trending.dart';

class HomeScreen extends StatelessWidget {
  final String userId;

  const HomeScreen({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 29, 15, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(context),
            CustomSearchBar(),
            BannerSlider(),
            const CategorySection(
                categories: ['Jars', 'Grains', 'Dairy', 'Bottles']),
            _buildTrendingSection(context),
            HorizontalCardList(),

            // ... (more extracted widgets)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 9),
            width: 42,
            height: 42,
            child: SvgPicture.asset(
              'lib/assets/Logo.svg',
              width: 32,
              height: 32,
            ),
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DISCOUNT BAZAAR',
                style: TextStyle(
                  fontFamily: 'Cabinet Grotesk',
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  height: 1.2575,
                  letterSpacing: 0.5,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
          const Spacer(),
          MaterialButton(
            onPressed: () {
              // Add your onPressed logic here
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Notifications(),
                  ));
            },
            child: Container(
              margin: const EdgeInsets.only(top: 5),
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'lib/assets/bell.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.only(bottom: 27),
      padding: const EdgeInsets.fromLTRB(17, 10, 263, 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xfff5f6fa),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0c101828),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 11),
            width: 18,
            height: 18,
            child: SvgPicture.asset(
              'lib/assets/search.svg',
              width: 18,
              height: 18,
            ),
          ),
          const Text(
            'Search',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: Color(0xffa9a9a9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      width: double.infinity,
      height: 160, // Adjust the height as needed
      decoration: BoxDecoration(
        color: const Color(0xff333333),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'lib/assets/banner.png', // Replace this with your image file path
        ),
      ),
    );
  }

  Widget _buildCategories(BuildContext context) {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Categories(),
                    ));
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), // Set the radius here
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
          children: [
            _buildCategoryButton('Jars'),
            const SizedBox(width: 8),
            _buildCategoryButton('Fruits'),
            const SizedBox(width: 8),
            _buildCategoryButton('Dairy'),
            const SizedBox(width: 8),
            _buildCategoryButton('Flour'),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildCategoryButton(String text) {
    return Container(
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
    );
  }

  Widget _buildTrendingSection(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          const Text(
            'Trending',
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Trending(),
                  ));
            },
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), // Set the radius here
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
    );
  }

  // You can continue extracting more widgets as needed
}
