import 'package:brana_mobile/book_detail.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookModel {
  final String title;
  final String description;
  final String author;
  final String narrator;
  final String thumbnail;
  final String chapter;
  final String duration;

  BookModel({
    required this.title,
    required this.description,
    required this.author,
    required this.narrator,
    required this.thumbnail,
    required this.chapter,
    required this.duration,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      author: json['author'] as String? ?? "",
      narrator: json['narrator'] as String? ?? "",
      thumbnail: json['thumbnail'] as String? ?? "",
      chapter: json['Total chapter'].toString(), // Convert int to String
      duration: json['duration'] as String? ?? "",
    );
  }
}

class GenreListPage extends StatefulWidget {
  final String genreName;
  const GenreListPage({Key? key, required this.genreName}) : super(key: key);

  @override
  _GenreListPageState createState() => _GenreListPageState();
}

class _GenreListPageState extends State<GenreListPage> {
  List<BookModel> books = [];
  late Size mediaSize;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(
          "https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retreive_audiobook_genre?audiobook_genre=${widget.genreName}"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final message = jsonData['message'] as List;

        if (message.isNotEmpty) {
          final bookList =
              message.map((bookData) => BookModel.fromJson(bookData)).toList();
          setState(() {
            books = bookList;
          });
        }
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  Widget _chip(String text, Color textColor, {double height = 0}) {
    mediaSize = MediaQuery.of(context).size;
    double leftpadding = mediaSize.width;
    double screenHeight = mediaSize.height;
    double fontSize = mediaSize.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: leftpadding / 20, vertical: screenHeight / 90),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: kLightBlue.withOpacity(0.1)),
      child: Text(
        "$text Chapters",
        style: GoogleFonts.jost(
          color: branaWhite,
          fontSize: fontSize / 35,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    double toppadding = mediaSize.height;
    double leftpadding = mediaSize.width;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;
    double fontSize = mediaSize.width;
    return Scaffold(
        backgroundColor: branaDeepBlack,
        appBar: AppBar(
          backgroundColor: branaDeepBlack,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: branaWhite),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.genreName,
                style: GoogleFonts.jost(
                  fontSize: fontSize / 17,
                  color: branaWhite,
                ),
              )
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: books.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetail(
                        title: books[index].title,
                        author: books[index].author,
                        description: books[index].description,
                        thumbnail: books[index].thumbnail,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(top: toppadding / 80),
                  child: Card(
                    color: kLightBlue.withOpacity(0.1),
                    elevation: 2,
                    child: Padding(
                      padding: EdgeInsets.only(top: toppadding / 180),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: toppadding / 20),
                              child: SizedBox(
                                width: screenWidth / 3.9,
                                height: screenHeight / 6,
                                child: Image.network(books[index].thumbnail),
                              )),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: screenHeight / 70,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        books[index].title,
                                        style: GoogleFonts.jost(
                                          fontSize: fontSize / 25,
                                          height: 1,
                                          color: branaWhite,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      books[index].duration,
                                      style: GoogleFonts.jost(
                                        color: Colors.grey,
                                        fontSize: fontSize / 30,
                                      ),
                                    ),
                                    SizedBox(width: screenWidth / 30)
                                  ],
                                ),
                                SizedBox(
                                  height: screenHeight / 40,
                                ),
                                Container(
                                  height: screenHeight / 15,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: leftpadding / 40,
                                  ),
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      final maxLines =
                                          constraints.maxHeight ~/ 12;

                                      return SingleChildScrollView(
                                        controller: ScrollController(),
                                        child: Text(
                                          books[index].description,
                                          maxLines: maxLines > 3 ? 3 : maxLines,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.jost(
                                            fontSize: fontSize / 35,
                                            height: 1,
                                            color: branaWhite,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: leftpadding / 40,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          children: [
                                            Text(
                                              "Author ",
                                              style: GoogleFonts.jost(
                                                fontSize: fontSize / 30,
                                                height: 1,
                                                color: branaWhite,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              books[index].author,
                                              style: GoogleFonts.jost(
                                                fontSize: fontSize / 30,
                                                height: 1,
                                                color: branaWhite,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: leftpadding / 10,
                                                vertical: toppadding / 40),
                                            child: SizedBox(
                                              width: screenWidth / 190,
                                              height: screenHeight / 30,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: branaWhite,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                            )),
                                        Column(
                                          children: [
                                            Text(
                                              "Narrator ",
                                              style: GoogleFonts.jost(
                                                fontSize: fontSize / 30,
                                                height: 1,
                                                color: branaWhite,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              books[index].narrator,
                                              style: GoogleFonts.jost(
                                                fontSize: fontSize / 30,
                                                height: 1,
                                                color: branaWhite,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                                SizedBox(
                                  height: screenHeight / 180,
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: toppadding / 190),
                                    child: Row(
                                      children: <Widget>[
                                        _chip(books[index].chapter, branaWhite,
                                            height: screenHeight / 40),
                                        SizedBox(
                                          width: screenWidth / 3,
                                        ),
                                      ],
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }
}
