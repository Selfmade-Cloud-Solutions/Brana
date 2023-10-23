import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/book_detail.dart';
// import 'package:anim_search_bar/anim_search_bar.dart';

class Children extends StatefulWidget {
  const Children({super.key});

  @override
  State<Children> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Children> {
  TextEditingController textController = TextEditingController();

  List<Book> books = getBookList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: branaDeepBlack,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          flexibleSpace: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Children",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                  height: 1,
                  color: Colors.white,
                ),
              ),
            ],
          )),
        ),
        body: ListView(children: [
          Container(
              color: branaDeepBlack,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.black,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kLightBlue.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
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
              ))
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => BookDetail(book: book)),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.1),
                    spreadRadius: 8,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Padding(
                  padding: EdgeInsets.only(
                    right: MediaQuery.of(context).size.width * 0.1,
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
          ),
          Text(
            book.title,
            softWrap: true,
            style: GoogleFonts.jost(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white70),
          ),
          Text(
            book.author.fullname,
            style: GoogleFonts.jost(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
