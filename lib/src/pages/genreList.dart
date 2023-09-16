import 'package:flutter/material.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/constants.dart';
// import 'package:brana_mobile/src/theme/theme.dart';

class RecomendedPage extends StatefulWidget {
  const RecomendedPage({super.key});

  @override
  State<RecomendedPage> createState() => _RecomendedPageState();
}

class _RecomendedPageState extends State<RecomendedPage> {
  Widget _header(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return ClipRRect(
        child: Container(
      height: 60,
      width: width,
      decoration: BoxDecoration(
        color: branaPrimaryColor,
      ),
    ));
  }

  Set<CourseModel> courseSet = {};

  Widget _courseList(BuildContext context) {
    courseSet.addAll(CourseList.list);

    return SingleChildScrollView(
        child: Column(
            children: courseSet.map((course) {
      return _courceInfo(context, course);
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

  Widget _courceInfo(BuildContext context, CourseModel model) {
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
                      child: Text(model.name,
                          style: TextStyle(
                              color: branaPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(model.duration,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        )),
                    const SizedBox(width: 10)
                  ],
                ),
                Text(
                  model.author,
                  style: TextStyle(fontSize: 14, color: branaPrimaryColor),
                ),
                const SizedBox(height: 15),
                Text(model.description, style: const TextStyle(fontSize: 14)),
                const SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    _chip(model.chapters, branaPrimaryColor, height: 5),
                    const SizedBox(
                      width: 10,
                    ),
                    _chip(model.episodes, branaPrimaryColor, height: 5),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _header(context),
            const SizedBox(height: 20),
            _courseList(context)
          ],
        ),
      ),
    );
  }
}
