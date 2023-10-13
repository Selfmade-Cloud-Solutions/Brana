import 'package:flutter/material.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:brana_mobile/src/theme/theme.dart';

class GenreListPage extends StatefulWidget {
  const GenreListPage({super.key});

  @override
  State<GenreListPage> createState() => _RecomendedPageState();
}

class _RecomendedPageState extends State<GenreListPage> {
  Set<BookModel> courseSet = {};

  Widget _bookList(BuildContext context) {
    courseSet.addAll(BookList.list);

    return SingleChildScrollView(
        child: Column(
            children: courseSet.map((course) {
      return _bookInfo(context, course);
    }).toList()));
  }

  Widget _card(BuildContext context, {Widget? backWidget}) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width * .34,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: backWidget,
      ),
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
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(model.duration,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        )),
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
                      if (constraints.constrainHeight(20) < 20) {
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
                Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
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
                        fontWeight: FontWeight.bold),
                  ),
                ]),
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
            ))
          ],
        ));
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
        style: TextStyle(
            color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
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
          color: Colors.white,
        ),
        flexibleSpace: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Genre Name",
              style: GoogleFonts.jost(
                fontSize: 20,
                height: 1,
                color: branaWhite,
              ),
            ),
          ],
        )),
      ),
      body: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width,
        color: kLightBlue.withOpacity(0.1),
        child: Column(
          children: <Widget>[
            _bookList(context),
            SizedBox(
                height: 40,
                width: double.infinity,
                child: Container(color: Colors.black)),
          ],
        ),
      )),
    );
  }
}
