import 'package:flutter/material.dart';
import 'package:brana_mobile/navigation_pages/genreList.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/pages/explore/latest.dart';
import 'package:brana_mobile/pages/explore/liked.dart';
import 'package:brana_mobile/pages/explore/wishlist.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<ExplorePage> {
  final CategoriesScroller categoriesScroller = const CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Book> books = getBookList();
  List<Author> authors = getAuthorList();
  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = booksExplore;
    List<Widget> listItems = [];
    for (var post in responseList) {
      listItems.add(GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const GenreListPage()),
            );
          },
          child: Container(
              height: 130,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  color: branaDarkBlue,
                  boxShadow: [
                    BoxShadow(
                        color:
                            const Color.fromARGB(255, 3, 3, 3).withAlpha(100),
                        blurRadius: 10.0),
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post["genre"],
                          style: GoogleFonts.jost(
                            fontWeight: FontWeight.w400,
                            fontSize: 28,
                            height: 1,
                            color: branaWhite,
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Text(
                            post["subGenre"],
                            style: GoogleFonts.jost(
                              fontWeight: FontWeight.w200,
                              fontSize: 17,
                              height: 1,
                              color: branaWhite,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    Image.asset(
                      "assets/books/${post["image"]}",
                      height: double.infinity,
                    )
                  ],
                ),
              ))));
    }
    setState(() {
      itemsData = listItems;
    });
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {
      double value = controller.offset / 119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: branaDeepBlack,
          flexibleSpace: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Explore Audiobooks",
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
        body: Container(
          color: branaDeepBlack,
          child: Scaffold(
            backgroundColor: branaDeepBlack,
            body: SizedBox(
              height: size.height,
              child: Column(
                children: <Widget>[
                  Container(
                      width: size.width,
                      alignment: Alignment.topCenter,
                      child: categoriesScroller),
                  Expanded(
                      child: ListView.builder(
                          controller: controller,
                          itemCount: itemsData.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            double scale = 1.0;
                            if (topContainer > 0.9) {
                              scale = index + 0.9 - topContainer;
                              if (scale < 0) {
                                scale = 0;
                              } else if (scale > 1) {
                                scale = 1;
                              }
                            }
                            return Opacity(
                              opacity: scale,
                              child: Transform(
                                transform: Matrix4.identity()
                                  ..scale(scale, scale),
                                alignment: Alignment.bottomCenter,
                                child: Align(
                                    heightFactor: 0.7,
                                    alignment: Alignment.topCenter,
                                    child: itemsData[index]),
                              ),
                            );
                          })),
                ],
              ),
            ),
          ),
        ));
  }
}

class CategoriesScroller extends StatelessWidget {
  const CategoriesScroller({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            children: <Widget>[
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LikedPage()),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: const BoxDecoration(
                        color: branaDarkBlue,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Liked",
                            style: GoogleFonts.jost(
                                fontSize: 25,
                                color: branaWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "14 Books",
                            style: GoogleFonts.jost(
                              fontSize: 16,
                              color: branaWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LatestPage()),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: const BoxDecoration(
                        color: branaDarkBlue,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Latest",
                            style: GoogleFonts.jost(
                                fontSize: 25,
                                color: branaWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "20 Books",
                            style: GoogleFonts.jost(
                              fontSize: 16,
                              color: branaWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WishlistPage()),
                    );
                  },
                  child: Container(
                    width: 150,
                    height: 100,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: const BoxDecoration(
                        color: branaDarkBlue,
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Wishlist",
                            style: GoogleFonts.jost(
                                fontSize: 25,
                                color: branaWhite,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "20 Books",
                            style: GoogleFonts.jost(
                              fontSize: 16,
                              color: branaWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
