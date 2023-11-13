import 'dart:convert';
import 'package:brana_mobile/pages/authors/authors_solo_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:brana_mobile/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AuthorList extends StatefulWidget {
  const AuthorList({Key? key}) : super(key: key);

  @override
  _AuthorsList createState() => _AuthorsList();
}

class _AuthorsList extends State<AuthorList> {
  late List<dynamic> authors = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.authors_api.retrieve_authors'));
    if (response.statusCode == 200) {
      if (mounted) { // Check if the widget is still mounted before calling setState
        setState(() {
          authors = jsonDecode(response.body)['message'];
        });
      }
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: authors.length,
      itemBuilder: (context, index) {
        final author = authors[index];
        if (author['total Book'] != 0) {
          return GestureDetector(
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
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
              ),
              padding: const EdgeInsets.all(12),
              margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
              width: 250,
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
                    child: SizedBox(
                      width: 75,
                      height: 75,
                      child: CachedNetworkImage(
                        imageUrl: author['author image'],
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
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
          return Container();
        }
      },
    );
  }
}