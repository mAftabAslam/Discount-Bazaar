import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 27),
        padding: const EdgeInsets.fromLTRB(17, 10, 17, 5),
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
            Expanded(
              child: Text(
                'Search',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  color: Color(0xffa9a9a9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];

  void searchAds(String searchText) {
    print('Starting search for: $searchText');
    FirebaseFirestore.instance
        .collectionGroup('ads') // Query across all users' ads
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        print('Documents retrieved: ${querySnapshot.docs.length}');
        List<Map<String, dynamic>> results = [];
        querySnapshot.docs.forEach((DocumentSnapshot doc) {
          print(doc.data());
          var data = doc.data();
          print('Document data: $data');
          if (data != null &&
              data is Map<String, dynamic> &&
              data.containsKey('name')) {
            var name = data['name'];
            print('Name field: $name');
            if (name != null &&
                name
                    .toString()
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) {
              results.add(data);
            }
          }
        });
        print('Search results: $results');
        setState(() {
          _searchResults = results; // Update the state variable here
        });
      } else {
        print('No documents found');
        setState(() {
          _searchResults = [];
        });
      }
    }).catchError((error) {
      // Handle error during query execution
      print("Error searching ads: $error");
      setState(() {
        _searchResults = [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.5,
              color: Colors.white70,
            ),
            border: InputBorder.none,
          ),
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.5,
            color: Colors.white,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              searchAds(value);
            } else {
              // Handle case when search query is empty (display all ads or a default state)
              setState(() {
                _searchResults = [];
              });
            }
          },
        ),
      ),
      body: _searchResults.isNotEmpty
          ? ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 2,
                  child: ListTile(
                    leading: _searchResults[index]['imageUrl'] != null
                        ? Image.network(
                            _searchResults[index]['imageUrl'],
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(
                            width: 50,
                            height: 50,
                            child: Icon(Icons.image),
                          ),
                    title: Text(_searchResults[index]['name'] ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _searchResults[index]['category'] ?? '',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          _searchResults[index]['description'] ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    // Other details as needed
                  ),
                );
              },
            )
          : Center(
              child: Text('No results found'),
            ),
    );
  }
}
