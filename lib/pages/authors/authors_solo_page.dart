import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:brana_mobile/constants.dart";
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/book_detail.dart';

class AuthorsSoloPage extends StatefulWidget {
  const AuthorsSoloPage({super.key});

  @override
  _AuthorsSoloPage createState() => _AuthorsSoloPage();
}

class _AuthorsSoloPage extends State<AuthorsSoloPage> {
  List<Book> books = getBookList();
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
          flexibleSpace: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Author Name",
                style: GoogleFonts.jost(
                  fontWeight: FontWeight.w900,
                  fontSize: 25,
                  height: 1,
                  color: branaWhite,
                ),
              ),
            ],
          )),
        ),
        body: Container(
            color: kLightBlue.withOpacity(0.1),
            child: ListView(children: [
              Stack(
                alignment: Alignment.centerLeft,
                children:[
              buildAuthorImage(),
            ]),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: buildAuthorBooks(),
              )
            ]
            )
            )
            );
  }


  Widget buildAuthorImage() {
  return ClipRRect(
              borderRadius: BorderRadius.circular(30),
                child: Container(
                decoration: const BoxDecoration(
    image: DecorationImage(
      image: NetworkImage('https://i.guim.co.uk/img/media/0fb8f397b68134c1cea91aa0ec858c27ba982c12/619_0_5963_3580/master/5963.jpg?width=620&dpr=1&s=none'),
      fit: BoxFit.cover,
    )),
      height: 110,
child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Container(
        padding: const EdgeInsets.only(left: 10),
        child: const CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250'),
        ),
      ),
      Column(
    mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      "Author Name",
      style: GoogleFonts.jost(
        fontWeight: FontWeight.w400,
        fontSize: 28,
        height: 1,
        color: Colors.black,
      ),
    ),
    Text(
      "Books:4",
      style: GoogleFonts.jost(
        fontWeight: FontWeight.w400,
        fontSize: 20,
        height: 1,
        color: Colors.black,
      ),
    ),
  ],
)

    ],
  )));
}


  Widget buildAuthorBooks() => SizedBox(
        height: MediaQuery.of(context).size.height,
        child: GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 3,
          children: buildBooks()
              .map((book) => SizedBox(
                    child: book,
                  ))
              .toList(),
        ),
      );
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Hero(
              tag: book.image,
              child: Image.asset(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width / 5,
                book.image,
                fit: BoxFit.cover,
              ),
            ),
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
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
