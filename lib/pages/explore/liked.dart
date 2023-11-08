import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/book_detail.dart';
// import 'package:brana_mobile/pages/explore/swiper.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LikedPage> {
  List<Book> books = getBookList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: branaDeepBlack,
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                "Liked",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  height: 1,
                  color: branaWhite,
                ),
              ),
            ],
          )),
        ),
        body: ListView(children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: kLightBlue.withOpacity(0.1),
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: kLightBlue.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    color: kLightBlue.withOpacity(0.1),
                    child: GridView.count(
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 3,
                      children: buildBooks()
                          .map((book) => SizedBox(
                                child: book,
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }

  List<Widget> buildBooks() {
    List<Widget> list = [];
    for (var i = 0; i < books.length; i++) {
      list.add(buildBook(books[i], i));
    }
    return list;
  }

  Widget buildBook(Book book, int index) {
    return 
    GestureDetector(
      onTap: () {
        var audiobook;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetail(title: audiobook['title'] ?? '')),
        );
      },
      child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color:
                          const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                      spreadRadius: 8,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Hero(
                  tag: book.image,
                  child: Image.asset(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width / 5,
                    book.image,
                    fit: BoxFit.cover,
                  ),
                )),
          ),
          Text(
            book.title,
            style: GoogleFonts.jost(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          Text(
            book.author.fullname,
            style: GoogleFonts.jost(
              fontSize: 14,
              color: branaWhite,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
