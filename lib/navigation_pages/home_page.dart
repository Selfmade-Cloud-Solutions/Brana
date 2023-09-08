import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/book_detail.dart';
import 'package:anim_search_bar/anim_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
  List<Filter> filters = getFilterListHome();
  late Filter selectedFilter;

  List<Book> books = getBookList();
  List<Author> authors = getAuthorList();

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedFilter = filters[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: AnimSearchBar(
              width: 350,
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
              helpText: "Search",
              autoFocus: true,
              closeSearchOnSuffixTap: true,
              animationDurationInMilli: 1500,
              rtl: false,
              onSubmitted: (string) {},
            ),
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(40),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 8,
                  blurRadius: 12,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Discover Audiobooks",
                  style: GoogleFonts.jost(
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    height: 1,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 75),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: buildFilters(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: buildBooks(),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Authors to follow",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "Show all",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: branaPrimaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: branaPrimaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: buildAuthors(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> buildFilters() {
    List<Widget> list = [];
    for (var i = 0; i < filters.length; i++) {
      list.add(buildFilter(filters[i]));
    }
    return list;
  }

  Widget buildFilter(Filter item) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = item;
        });
      },
      child: SizedBox(
        height: 50,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 30,
                height: 3,
                color: selectedFilter == item
                    ? branaPrimaryColor
                    : Colors.transparent,
              ),
            ),
            Center(
              child: Text(
                item.name,
                style: GoogleFonts.jost(
                  color: selectedFilter == item
                      ? branaPrimaryColor
                      : Colors.grey[400],
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                ),
              ),
            )
          ],
        ),
      ),
    );
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
      child: Container(
        margin:
            EdgeInsets.only(right: 32, left: index == 0 ? 16 : 0, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 8,
                      blurRadius: 12,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                margin: const EdgeInsets.only(
                  bottom: 16,
                  top: 24,
                ),
                child: Hero(
                  tag: book.title,
                  child: Image.asset(
                    book.image,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
            Text(
              book.title,
              style: GoogleFonts.jost(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              book.author.fullname,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildAuthors() {
    List<Widget> list = [];
    for (var i = 0; i < authors.length; i++) {
      list.add(buildAuthor(authors[i], i));
    }
    return list;
  }

  Widget buildAuthor(Author author, int index) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.all(12),
      margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
      width: 255,
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
                  image: AssetImage(author.image),
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
                author.fullname,
                style: GoogleFonts.jost(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
                    "${author.books} books",
                    style: const TextStyle(
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
}
