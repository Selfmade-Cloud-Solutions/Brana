import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/pages/authors/authors_solo_page.dart';

class AuthorsListPage extends StatefulWidget {
  const AuthorsListPage({Key? key}) : super(key: key);

  @override
  _AuthorsList createState() => _AuthorsList();
}

class _AuthorsList extends State<AuthorsListPage> {
  late List<dynamic> authors = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.authors_api.retrieve_authors'));
    if (response.statusCode == 200) {
      setState(() {
        authors = jsonDecode(response.body)['message'];
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: branaDeepBlack,
      appBar: AppBar(
        title: Center(
          child: Text(
            "Authors",
            style: GoogleFonts.jost(
              fontWeight: FontWeight.w600,
              fontSize: 25,
              height: 1,
              color: branaWhite,
            ),
          ),
        ),
        backgroundColor: branaDeepBlack,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: branaWhite,
        ),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: authors.length,
        itemBuilder: (context, index) {
          final author = authors[index];
          // Check if total books is not zero before displaying the author
          if (author['total Book'] != 0) {
            return Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(right: 16, left: 0),
              width: 250,
              // height:50,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthorsSoloPage(
                        author: author['full name'] ?? '',
                        thumbnail: author['author image'],
                        totalbooks: author['total Book'].toString(),
                      ),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(0),
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        width: 75,
                        height: 75,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(author['author image']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          author['full name'],
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: branaWhite,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.library_books,
                              color: Colors.grey,
                              size: 14,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${author['total Book']} book",
                              style: GoogleFonts.jost(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            // If total books is zero, return an empty container
            return Container();
          }
        },
      ),
    );
  }
}
