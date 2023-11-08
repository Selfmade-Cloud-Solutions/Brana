// import 'package:brana_mobile/book_detail.dart';
// import 'package:brana_mobile/constants.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class BookModel {
//   final String title;
//   final String description;
//   final String author;
//   final String narrator;
//   final String thumbnail;
//   final String chapter;

//   BookModel({
//     required this.title,
//     required this.description,
//     required this.author,
//     required this.narrator,
//     required this.thumbnail,
//     required this.chapter,
//   });

//   factory BookModel.fromJson(Map<String, dynamic> json) {
//     return BookModel(
//       title: json['title'] as String? ?? "",
//       description: json['description'] as String? ?? "",
//       author: json['author'] as String? ?? "",
//       narrator: json['narrator'] as String? ?? "",
//       thumbnail: json['thumbnail'] as String? ?? "",
//       chapter:json['Total chapter'] as String? ?? "",
//     );
//   }
// }

// class BookListPage extends StatefulWidget {
//   const BookListPage({Key? key}) : super(key: key);

//   @override
//   _BookListPageState createState() => _BookListPageState();
// }

// class _BookListPageState extends State<BookListPage> {
//   List<BookModel> books = [];

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//   }

//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(Uri.parse(
//           "https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retreive_audiobook_genre?audiobook_genre=poetry"));

//       if (response.statusCode == 200) {
//         final jsonData = json.decode(response.body);
//         final message = jsonData['message'] as List;

//         if (message.isNotEmpty) {
//           final bookList =
//               message.map((bookData) => BookModel.fromJson(bookData)).toList();
//           setState(() {
//             books = bookList;
//           });
//         } else {
//           print("No books found in the message.");
//         }
//       } else {
//         print("Failed to load books. Status code: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching books: $e");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('Book List'),
//         ),
//         body: GridView.builder(
//           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 3, mainAxisSpacing: 50),
//           itemCount: books.length,
//           itemBuilder: (context, index) {
//             return AspectRatio(
//                 aspectRatio: 1,
//                 child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BookDetail(
//                             title: books[index].title,
//                           ),
//                         ),
//                       );
//                     },
//                     child: Container(
//                       width: MediaQuery.of(context).size.width * 0.3,
//                       height: MediaQuery.of(context).size.height * 0.3,
//                       margin: const EdgeInsets.only(right: 5, left: 5),
//                       color: kLightBlue.withOpacity(0.1),
//                       child: Column(
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.only(top: 10),
//                             child: books[index].thumbnail != null
//                                 ? Image.network(books[index].thumbnail,
//                                     width: 70, height: 70)
//                                 : const SizedBox.shrink(),
//                           ),
//                           Flexible(
//                               child: Text(
//                             books[index].title,
//                             style: GoogleFonts.jost(
//                               fontSize: 16,
//                               fontWeight: FontWeight.bold,
//                               color: branaGrey,
//                             ),
//                           )),
//                           Flexible(
//                               child: Text(
//                             books[index].description,
//                             style: GoogleFonts.jost(
//                               fontSize: 14,
//                               color: branaWhite,
//                             ),
//                           )),
//                         ],
//                       ),
//                     )));
//           },
//         )

//         // ListView.builder(
//         //   itemCount: books.length,
//         //   itemBuilder: (context, index) {
//         //     return ListTile(
//         //       title: Text(books[index].title),
//         //       subtitle: Text(books[index].description),
//         //     );
//         //   },
//         // ),
//         );
//   }
// }
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookModel {
  final String name;
  final String description;
  final String author;
  final String duration;
  final String chapters;
  final String narrator;
  final String thumbnail;

  BookModel({
    required this.name,
    required this.description,
    required this.author,
    required this.duration,
    required this.chapters,
    required this.narrator,
    required this.thumbnail,
  });
}

class BookList {
  static List<BookModel> list = [];

  static Future<void> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(
          "https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retreive_audiobook_genre?audiobook_genre=poetry"));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        if (jsonData is List) {
          list = jsonData.map((bookData) {
  final bookModel = BookModel(
    name: bookData['title'] ?? "",
    description: bookData['description'] ?? "",
    author: bookData['author'] ?? "",
    duration: bookData['duration'] ?? "",
    chapters: "Total chapter: ${bookData['Total chapter']}",
    narrator: bookData['narrator'] ?? "",
    thumbnail: bookData['thumbnail'] ?? "",
  );

            print("Fetched Book: ${bookModel.name}");
            print('geel');
            // Print other fields if needed

            return bookModel;
          }).toList();
        }
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      print('Error fetching books: $e');
    }
  }
}

class GenreListPage extends StatefulWidget {
  const GenreListPage({super.key, required this.genreName});
  final String genreName;
  @override
  State<GenreListPage> createState() => _RecomendedPageState();
}

class _RecomendedPageState extends State<GenreListPage> {
  late Future<void> fetchBooksFuture;
  @override
  void initState() {
    super.initState();
    fetchBooksFuture = BookList.fetchBooks();
  }

  Widget _bookList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: BookList.list.length,
      itemBuilder: (context, index) {
        return _bookInfo(context, BookList.list[index]);
      },
    );
  }

  Widget _card(BuildContext context, {Widget? backWidget}) {
  return Card(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    ),
    child: backWidget,
  );
}

  Widget _bookInfo(BuildContext context, BookModel model) {
  return SizedBox(
    height: 170,
    width: MediaQuery.of(context).size.width - 20,
    child: Row(
      children: <Widget>[
        AspectRatio(
          aspectRatio: .7,
          child: _card(
            context,
            backWidget: Image.asset(model.thumbnail),
          ),
        ),
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
                      model.name,
                      style: GoogleFonts.jost(
                        fontSize: 15,
                        height: 1,
                        color: branaWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    model.duration,
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
                          model.description,
                          style: GoogleFonts.jost(
                            fontSize: 12,
                            height: 1,
                            color: branaWhite,
                          ),
                        ),
                      );
                    } else {
                      return Text(
                        model.description,
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
                  Expanded(
                    child: Text(
                      model.author,
                      style: GoogleFonts.jost(
                        fontSize: 15,
                        height: 1,
                        color: branaWhite,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "Narrator ${model.narrator}",
                    style: GoogleFonts.jost(
                      fontSize: 15,
                      height: 1,
                      color: branaWhite,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  _chip(model.chapters, branaWhite, height: 5),
                  const SizedBox(
                    width: 10,
                  ),
                  // _chip(model.episodes, branaWhite, height: 5),
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}
  Widget _chip(String text, Color textColor,
      {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: GoogleFonts.jost(
            color: isPrimaryCard ? branaWhite : textColor, fontSize: 12),
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: branaWhite,
        ),
        flexibleSpace: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.genreName,
                style: GoogleFonts.jost(
                  fontSize: 20,
                  height: 1,
                  color: branaWhite,
                ),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: fetchBooksFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading indicator.
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            // Data is ready, build your list here.
            return _bookList(context);
          }
        },
      ),
    );
  }}
