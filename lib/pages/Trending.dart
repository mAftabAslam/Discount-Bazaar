import 'package:flutter/material.dart';

class HorizontalCardList extends StatelessWidget {
  const HorizontalCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220, // Adjust the height according to your design
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3, // Replace with the number of cards you have
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0), // Adjust horizontal spacing between cards
            child: buildCard(), // Create a function to build your card widget
          );
        },
      ),
    );
  }

  Widget buildCard() {
    return Container(
      width: 177, // Replace with your card width
      decoration: BoxDecoration(
        color: Colors.white, // Replace with your card color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(4, 5, 4, 10),
            width: 177,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(1, 0, 1, 2),
                  padding: const EdgeInsets.fromLTRB(90, 12, 11.03, 37),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f6fa),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 11.85),
                        width: 13.94,
                        height: 12.15,
                        child: Image.network(
                          '[Image url]',
                          width: 13.94,
                          height: 12.15,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 47.97, 0),
                        width: 18,
                        height: 18,
                        child: Image.network(
                          '[Image url]',
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(1, 0, 1, 6),
                  width: double.infinity,
                  height: 24,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 0, 36, 0),
                        child: const Text(
                          '10 Kilo Atta',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff000000),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 5, 0, 3),
                        width: 42,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xffe0fff2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Center(
                          child: Text(
                            'Rs 1000',
                            style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w700,
                              color: Color(0xff085938),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(1, 0, 0, 9),
                  constraints: const BoxConstraints(maxWidth: 168),
                  child: const Text(
                    'Tapal Danedar up for grabs! 4x Family Packs available to spice up your chai game. Don\'t miss out!',
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff8b8b8b),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 1, 0),
                  width: 168,
                  height: 38,
                  decoration: BoxDecoration(
                    color: const Color(0xff1cf396),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
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
              ],
            ),
          ),
// Add your card contents here
          // Example: Text('Your Card Content'),
        ],
      ),
    );
  }
}
