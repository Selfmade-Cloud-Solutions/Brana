import 'package:brana_mobile/Api/home/recommended_api.dart';
import 'package:brana_mobile/Api/home/editorspick_api.dart';
import 'package:brana_mobile/Api/home/children_api.dart';
import 'package:brana_mobile/Api/home/authors_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/pages/authors/authors_list.dart';
import 'package:brana_mobile/pages/recomendations/editors_picks.dart';
import 'package:brana_mobile/pages/recomendations/podcasts.dart';
import 'package:brana_mobile/pages/recomendations/children.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate data loading for 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: branaDeepBlack,
        appBar: AppBar(
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
        body:  isLoading
          ? const Center(
              // Display a circular preloader if isLoading is true
              child: CircularProgressIndicator(
                color: branaWhite,
              ),
            )
          : SingleChildScrollView(
              child:Container(
                  color: branaDeepBlack,
                  
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 210, child: RecommendedList()),
                        // Author
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: const SizedBox(
                                        height: 100, child: AuthorList()),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
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
                        const SizedBox(height: 5),
                        const SizedBox(height: 200, child: EditorsPickList()),
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

                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(height: 200, child: ChildrenList()),

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
                        const SizedBox(
                          height: 5,
                        ),
                        const SizedBox(height: 200, child: ChildrenList()),
                      ],
                    ),
                  )
            ));
  }
}
