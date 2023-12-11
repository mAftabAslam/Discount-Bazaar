import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:se_project/pages/Components/Trending.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15, 29, 15, 5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 3, 28),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                    width: 42,
                    height: 42,
                    child: SvgPicture.asset(
                      'lib/assets/Logo.svg',
                      width: 32,
                      height: 32,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 2, 9, 0),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontFamily: 'Cabinet Grotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.2575,
                        letterSpacing: 1,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 2, 82, 0),
                    child: const Text(
                      'BAZAAR',
                      style: TextStyle(
                        fontFamily: 'Cabinet Grotesk',
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        height: 1.2575,
                        letterSpacing: 1,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    width: 24,
                    height: 24,
                    child: SvgPicture.asset(
                      'lib/assets/bell.svg',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(1, 0, 0, 27),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 11, 0),
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
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(1, 0, 2, 20),
              padding: const EdgeInsets.all(0),
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
            ),

            Container(
              margin: const EdgeInsets.fromLTRB(0, 0, 1, 12),
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 236, 0),
                    child: const Text(
                      'Categories',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  const Text(
                    'See all',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 2,
                      color: Color(0xff085938),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(1, 0, 1, 17),
              width: double.infinity,
              height: 38,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 84,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffe0fff2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Jars',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: Color(0xff085938),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 84,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffe0fff1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Fruits',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: Color(0xff085938),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 84,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffe0fff2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Dairy',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: Color(0xff085938),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 84,
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xffe0fff2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Text(
                        'Flour',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 1,
                          color: Color(0xff085938),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 253, 10),
                    child: const Text(
                      'Trending',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  const Text(
                    'See all',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 2,
                      color: Color(0xff085938),
                    ),
                  ),
                ],
              ),
            ),

// Cards
            const HorizontalCardList(),

// ... (more containers and widgets)
          ],
        ),
      ),
    );
  }
}
