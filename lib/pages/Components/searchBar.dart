import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:se_project/pages/MainPages/product.dart';

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
  int _resultsCount = 0; // Variable to hold the count of search results
  bool _showResults = false;

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  late String userDisplayName = 'Default Name';
  late String userMemberSince = 'Default Date';

  @override
  void initState() {
    super.initState();
    fetchCurrentUserDetails();
  }

  Future<void> fetchCurrentUserDetails() async {
    User? currentUser = await getCurrentUser();
    if (currentUser != null) {
      setState(() {
        userDisplayName = currentUser.displayName ?? 'Default Name';
        DateTime? userCreationDate = currentUser.metadata.creationTime;
        userMemberSince = userCreationDate != null
            ? '${userCreationDate.day}/${userCreationDate.month}/${userCreationDate.year}'
            : 'Default Date';
      });
    }
  }

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
          _resultsCount = results.length; // Update the count of results
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

  bool _isAscending = true; // Track sorting order

  void sortResults() {
    setState(() {
      _isAscending = !_isAscending; // Toggle sorting order
      _searchResults.sort((a, b) {
        // Compare prices for sorting
        var priceA = a['price'] as num;
        var priceB = b['price'] as num;
        return _isAscending
            ? priceA.compareTo(priceB)
            : priceB.compareTo(priceA);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color:
              Colors.black, // Change this color to make the back button visible
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          height: 44,
          width: MediaQuery.of(context).size.width * 0.9,
          padding: EdgeInsets.fromLTRB(17, 10, 17, 5),
          decoration: BoxDecoration(
            color: Color(0xfff5f6fa),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 11),
                width: 18,
                height: 18,
                child: SvgPicture.asset(
                  'lib/assets/search.svg',
                  width: 18,
                  height: 18,
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      color: Color(0xffa9a9a9),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 8), // Adjust vertical padding
                  ),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: Colors.black,
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      searchAds(value);
                    } else {
                      setState(() {
                        _searchResults = [];
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: 1,
            color: Colors.grey[200], // Light grey color
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 15), // Add horizontal padding
                    child: Text(
                      _resultsCount > 0
                          ? 'Showing: Found $_resultsCount results for ${_searchController.text}'
                          : 'No results found',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: sortResults,
                  icon: Icon(
                    _isAscending
                        ? Icons.arrow_downward
                        : Icons
                            .arrow_upward, // Change icon based on sorting order
                    size: 12,
                    color: Color(0xff085938),
                  ),
                  label: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Text(
                      'Sort By',
                      style: TextStyle(fontSize: 12, color: Color(0xff085938)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _searchResults.isNotEmpty
                ? ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      var ad = _searchResults[index];

                      return Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 15, 8),
                        width: double.infinity,
                        height:
                            107, // Adjusted height to accommodate the button
                        decoration: BoxDecoration(
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(8, 8, 12, 8),
                                  width: 167,
                                  height: 91,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xfff5f6fa),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ad['imageUrl'] != null
                                        ? Image.network(
                                            ad['imageUrl'],
                                            width: double.infinity,
                                            height: double.infinity,
                                            fit: BoxFit.cover,
                                          )
                                        : Center(
                                            child: Icon(
                                              Icons.image,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            ad['name'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              // Add more styling as needed
                                            ),
                                          ),
                                        ),
                                        Text(
                                          ad['price'].toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            // Add more styling as needed
                                          ),
                                        ),
                                        SizedBox(
                                            height:
                                                8), // Add space between text and button
                                        Container(
                                          width: 162,
                                          height: 42,
                                          margin: EdgeInsets.fromLTRB(0, 0, 5,
                                              0), // Adjust button margin
                                          child: TextButton.icon(
                                            onPressed: () {
                                              // Add action for the button click
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetails(
                                                      imageUrl: ad['imageUrl'],
                                                      name: ad['name'],
                                                      price: ad['price'],
                                                      category: ad['category'],
                                                      description:
                                                          ad['description'],
                                                      userDisplayName:
                                                          userDisplayName,
                                                      userMemberSince:
                                                          userMemberSince,
                                                    ),
                                                  ));
                                            },
                                            icon: Icon(
                                              Icons.arrow_right_alt,
                                              color: Color(
                                                  0xff085938), // Icon color
                                            ),
                                            label: Text(
                                              'View Full Post',
                                              style: TextStyle(
                                                color: Color(
                                                    0xff085938), // Text color
                                              ),
                                            ),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Color(
                                                  0xffe0fff2), // Button color
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('Search for an ad'),
                  ),
          ),
        ],
      ),
    );
  }
}
