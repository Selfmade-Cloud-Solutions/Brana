import 'package:brana_mobile/book_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
  final dynamic is_favorite; // Change the type to dynamic

  BookModel({
    required this.title,
    required this.description,
    required this.author,
    required this.narrator,
    required this.thumbnail,
    required this.chapter,
    required this.duration,
    required this.is_favorite,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) {
    dynamic is_favorite = json['is_favorite']; // Store the raw value as dynamic
    if (is_favorite is int) {
      is_favorite = is_favorite.toString(); // Convert int to String
    }

    return BookModel(
      title: json['title'] as String? ?? "",
      description: json['description'] as String? ?? "",
      author: json['author'] as String? ?? "",
      narrator: json['narrator'] as String? ?? "",
      thumbnail: json['thumbnail'] as String? ?? "",
      chapter: json['Total chapter'].toString(), // Convert int to String
      duration: json['duration'] as String? ?? "",
      is_favorite: json['duration'] as String? ?? "", 
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
    } catch (e) {}
  }

  Widget _chip(String text, Color textColor, {double height = 0}) {
    mediaSize = MediaQuery.of(context).size;
    double fontSize = mediaSize.width;
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: kLightBlue.withOpacity(0.1)),
      child: Text(
        "$text Chapters",
        style: GoogleFonts.jost(
          color: branaWhite,
          fontSize: fontSize / 30,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    double toppadding = mediaSize.height;
    double bottompadding = mediaSize.height;
    double leftpadding = mediaSize.width;
    double screenHeight = mediaSize.height;
    double screenWidth = mediaSize.width;

    double fontSize = screenWidth;
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
                        narrator: books[index].narrator,
                        is_favorite: books[index].is_favorite ?? '',
                        // chapters: books[index].chapter
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: toppadding / 30,
                      left: leftpadding / 30,
                      right: leftpadding / 30,
                      bottom: bottompadding / 30),
                  child: Card(
                    color: kLightBlue.withOpacity(0.1),
                    elevation: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: toppadding / 20,
                                horizontal: leftpadding / 70),
                            child: SizedBox(
                              width: screenWidth / 3.5,
                              height: screenHeight / 5,
                              child: CachedNetworkImage(
                                  imageUrl: books[index].thumbnail),
                            )),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: screenHeight / 100),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: toppadding / 19,
                                          left: leftpadding / 30),
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
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: toppadding / 19,
                                        left: leftpadding / 30),
                                    child: Text(
                                      books[index].duration,
                                      style: GoogleFonts.jost(
                                        color: Colors.grey,
                                        fontSize: fontSize / 25,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: screenWidth / 30)
                                ],
                              ),
                              SizedBox(
                                height: screenHeight / 250,
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                    left: leftpadding / 80,
                                    right: leftpadding / 80,
                                    top: toppadding / 100,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Text(
                                            "Author ",
                                            style: GoogleFonts.jost(
                                              fontSize: fontSize / 25,
                                              height: 1,
                                              color: branaWhite,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            books[index].author,
                                            style: GoogleFonts.jost(
                                              fontSize: fontSize / 28,
                                              height: 1,
                                              color: branaWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Narrator ",
                                            style: GoogleFonts.jost(
                                              fontSize: fontSize / 25,
                                              height: 1,
                                              color: branaWhite,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            books[index].narrator,
                                            style: GoogleFonts.jost(
                                              fontSize: fontSize / 28,
                                              height: 1,
                                              color: branaWhite,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              // SizedBox(
                              //   height: screenHeight / 100,
                              // ),
                              Container(
                                  padding: EdgeInsets.only(
                                      top: toppadding / 550,
                                      left: leftpadding / 30,
                                      right: leftpadding / 30,
                                      bottom: toppadding / 60),
                                  child: Row(
                                    children: <Widget>[
                                      _chip(books[index].chapter, branaWhite,
                                          height: screenHeight / 90),
                                      SizedBox(
                                        width: screenWidth / 30,
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
