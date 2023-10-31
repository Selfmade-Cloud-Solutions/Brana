import 'package:brana_mobile/editor_api.dart';
import 'package:brana_mobile/pages/authors/authors_solo_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/data.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/book_detail.dart';
import 'package:brana_mobile/pages/authors/authors_list.dart';
import 'package:brana_mobile/pages/recomendations/editors_picks.dart';
import 'package:brana_mobile/pages/recomendations/podcasts.dart';
import 'package:brana_mobile/pages/recomendations/children.dart';
import 'package:brana_mobile/editor_api.dart';
// import 'package:anim_search_bar/anim_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  TextEditingController textController = TextEditingController();
// API DATA

  List<dynamic> data = [];
  List<Book> books = getBookList();

  Future<List<dynamic>> fetchAudiobooks() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_audiobooks'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData['message'];
    } else {
      throw Exception('Failed to fetch audiobooks');
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }

  List<Author> authors = getAuthorList();
  bool appBarVisible = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset >= 50) {
        setState(() {
          appBarVisible = false;
        });
      } else {
        setState(() {
          appBarVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarVisible
            ? AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: branaDeepBlack,
                flexibleSpace: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Brana Audiobooks",
                      style: GoogleFonts.jost(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        height: 1,
                        color: branaWhite,
                      ),
                    ),
                  ],
                )),
              )
            : null,
        body: NotificationListener<ScrollNotification>(
            onNotification: (scrollDetails) {
              return true;
            },
            child: ListView(controller: _scrollController, children: [
              Container(
                  color: branaDeepBlack,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                              top: 0, left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: branaDeepBlack,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(40),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: kLightBlue.withOpacity(0.1),
                                spreadRadius: 38,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            color: branaDeepBlack,
                            child: SizedBox(
                              height: 300,
                              child: Container(
                                color: kLightBlue.withOpacity(0.1),
                                child: ListView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  children: buildBooks(),
                                ),
                              ),
                            )),
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
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Authors",
                                          style: GoogleFonts.jost(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: branaWhite,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const AuthorsListPage()));
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "Show all",
                                                style: GoogleFonts.jost(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                  color: branaWhite,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 8,
                                              ),
                                              const Icon(
                                                Icons.arrow_forward,
                                                size: 18,
                                                color: branaWhite,
                                              ),
                                            ],
                                          ),
                                        )
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
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: kLightBlue.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 0, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Editor's Pick",
                                  style: GoogleFonts.jost(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: branaWhite,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const EditorsPicks()));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Show all",
                                            style: GoogleFonts.jost(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: branaWhite,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            size: 18,
                                            color: branaWhite,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        // RenderRepaintBoundary#d815b
                        Container(
  color: kLightBlue.withOpacity(0.1),
  child: SizedBox(
    height: 200,
    width:80,
    child: FutureBuilder<List<Widget>>(
      future: buildRecommended(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Flexible (
            child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: snapshot.data!,
          ));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 0, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Podcasts",
                                  style: GoogleFonts.jost(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: branaWhite,
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    const Podcast()));
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            "Show all",
                                            style: GoogleFonts.jost(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: branaWhite,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            size: 18,
                                            color: branaWhite,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          color: kLightBlue.withOpacity(0.1),
                          child: SizedBox(
                            height: 200,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              // children: buildBooks(),
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
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, bottom: 0, top: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Children",
                                    style: GoogleFonts.jost(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: branaWhite,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const Children()));
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Show all",
                                              style: GoogleFonts.jost(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: branaWhite,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Icon(
                                              Icons.arrow_forward,
                                              size: 18,
                                              color: branaWhite,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          color: kLightBlue.withOpacity(0.1),
                          child: SizedBox(
                            height: 200,
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              // children: buildBooks(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ))
            ])));
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
              Flexible(
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
                    color: Colors.white70),
              ),
              Text(
                book.author.fullname,
                style: GoogleFonts.jost(
                  fontSize: 14,
                  color: branaWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ]),
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
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AuthorsSoloPage(),
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
                        "${author.books} books",
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
        ));
  }

  Future<List<Widget>> buildRecommended() async {
    List<dynamic> bookRecom = await fetchAudiobooks();
    List<Widget> list = [];
    for (var i = 0; i < bookRecom.length; i++) {
      list.add(buildBookTwo(bookRecom[i], i));
    }
    return list;
  }

  Widget buildBookTwo(dynamic audiobook, int index) {
    return FutureBuilder<List<dynamic>>(
      future: fetchAudiobooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final audiobooks = snapshot.data!;
          final filteredAudiobooks = audiobooks
              .takeWhile((audiobook) => audiobook['title'] != null)
              .toList();
          return Container(
              child: ListView.builder(
            itemCount: filteredAudiobooks.length,
            itemBuilder: (context, index) {
              final audiobook = filteredAudiobooks[index];
              // final title = audiobook['title'];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetail(book: audiobook)),
                  );
                },
                child: Container(
                  height: 200.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                              image: DecorationImage(
                                image: NetworkImage(audiobook['image'],),
                                fit: BoxFit.cover,
                              ),
                          ),
                        ),
                      const SizedBox(width: 16.0),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              audiobook['title'],
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              audiobook['author'],
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${audiobook['duration']} minutes',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ));
        
        } else if (snapshot.hasError) {
          return const Text('Failed to fetch audiobooks');
        } else {
          return const Center(child:  CircularProgressIndicator());
        }
      },
    );
  }
}
