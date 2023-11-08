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

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
          Uri.parse(
              "https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retreive_audiobook_genre?audiobook_genre=${widget.genreName}"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final message = jsonData['message'] as List;


        if (message.isNotEmpty) {
          final bookList = message
              .map((bookData) => BookModel.fromJson(bookData))
              .toList();
          setState(() {
            books = bookList;
          });
        } 
      } 
    // ignore: empty_catches
    } catch (e) {
    }
  }


  Widget _chip(String text, Color textColor, {double height = 0}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration:  BoxDecoration(
        borderRadius:  const BorderRadius.all(Radius.circular(15)),
        color:kLightBlue.withOpacity(0.1)
      ),
      child: Text(
        "$text Chapters",
        style: GoogleFonts.jost(
          color: branaWhite,
          fontSize: 12,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
  children:[
    Text(
          widget.genreName,
          style: GoogleFonts.jost(
            fontSize: 20,
            color: branaWhite,
          ),
        )],
      ),
      ),
      body: ListView.builder(
  itemCount: books.length,
  itemBuilder: (context, index) {
    return  GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookDetail(
                    title: books[index].title,
                  ),
                ),
              );
            },
            child:Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: kLightBlue.withOpacity(0.1),
        elevation: 2,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            Padding(
      padding: const EdgeInsets.symmetric( vertical:30),
      child: SizedBox(
              width: 150,
              height:120, 
              child: Image.network(books[index].thumbnail),
            )),
              Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      books[index].title,
                      style: GoogleFonts.jost(
                        fontSize: 15,
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
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 10)
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxHeight < 20) {
                      return SingleChildScrollView(
                        controller: ScrollController(),
                        child: Text(
                          books[index].description,
                          style: GoogleFonts.jost(
                            fontSize: 12,
                            height: 1,
                            color: branaWhite,
                          ),
                        ),
                      );
                    } else {
                      return Text(
                        books[index].description,
                        style: GoogleFonts.jost(
                          fontSize: 12,
                          height: 1,
                          color: branaWhite,
                        ),
                      );
                    }
                  },
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                Column(
      children: [
        Text(
          "Author ",
          style: GoogleFonts.jost(
            fontSize: 15,
            height: 1,
            color: branaWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          books[index].author,
          style: GoogleFonts.jost(
            fontSize: 15,
            height: 1,
            color: branaWhite,
          ),
        ),
      ],
    ),
    Padding(
      padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.09, vertical:10),
    child:SizedBox(
      width: MediaQuery.of(context).size.width * 0.01,
      height: 15,
      child: Container(
        decoration: BoxDecoration(
          color: branaWhite,
          borderRadius: BorderRadius.circular(20), 
        ),
      ),
    )),
    Column(
      children: [
        Text(
          "Narrator ",
          style: GoogleFonts.jost(
            fontSize: 15,
            height: 1,
            color: branaWhite,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          books[index].narrator,
          style: GoogleFonts.jost(
            fontSize: 15,
            height: 1,
            color: branaWhite,
          ),
        ),
      ],
    ),
  ],
),

              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  _chip(books[index].chapter, branaWhite, height: 5),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        )
      ],
        ),
      ),
    ));
  },
)

    );
  }
}
