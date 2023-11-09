import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:brana_mobile/constants.dart";
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/book_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthorsSoloPage extends StatefulWidget {
  const AuthorsSoloPage(
      {Key? key,
      required this.author,
      required this.thumbnail,
      required this.totalbooks})
      : super(key: key);
  final String author;
  final String thumbnail;
  final String totalbooks;

  @override
  _AuthorsSoloPage createState() => _AuthorsSoloPage();
}

class _AuthorsSoloPage extends State<AuthorsSoloPage> {
  late List<dynamic> audiobooks = [];
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.authors_api.retrieve_author?author_id=${widget.author}'));
    if (response.statusCode == 200) {
      setState(() {
        audiobooks = jsonDecode(response.body)['message'];
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
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: branaWhite,
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              widget.author,
              style: GoogleFonts.jost(
                fontWeight: FontWeight.w600,
                fontSize: 25,
                height: 1,
                color: branaWhite,
              ),
            )
          ]),
        ),
        body: Container(
            color: kLightBlue.withOpacity(0.1),
            child: ListView(children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  buildAuthorImage(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: buildAuthorBooks(context),
              )
            ])));
  }

  Widget buildAuthorImage() {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        color: branaDeepBlack,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: size.width,
      // height:50,
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
                  image: NetworkImage(widget.thumbnail),
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
                widget.author,
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
                    "${widget.totalbooks} book",
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
    );
  }

  Widget buildAuthorBooks(BuildContext context) {
    double containerWidth = MediaQuery.of(context).size.width * 0.3;
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10),
          itemCount: audiobooks.length,
          itemBuilder: (context, index) {
            final audiobook = audiobooks[index];
            return AspectRatio(
                aspectRatio: 1,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetail(
                            title: audiobook['title'] ?? '',
                            author: audiobook['author'] ?? '',
                            description: audiobook['description'] ?? '',
                            thumbnail: audiobook['thumbnail'] ?? '',
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.3,
                      margin: const EdgeInsets.only(right: 5, left: 5),
                      color: kLightBlue.withOpacity(0.1),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: audiobook['thumbnail'] != null
                                ? Image.network(audiobook['thumbnail'],
                                    width: containerWidth * 1.2,
                                    height: containerWidth * 1.2)
                                : const SizedBox.shrink(),
                          ),
                          
                          Flexible(
                              child: Text(
                            audiobook['title'] ?? '',
                            style: GoogleFonts.jost(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: branaGrey,
                            ),
                          )),
                          Flexible(
                              child: Text(
                            audiobook['Author'] ?? '',
                            style: GoogleFonts.jost(
                              fontSize: 14,
                              color: branaWhite,
                            ),
                          )),
                        ],
                      ),
                    )));
          },
        ));
  }
}
