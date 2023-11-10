import 'package:brana_mobile/data.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class genreBookDetail extends StatelessWidget {
  final BookModel? model;

  const genreBookDetail({required this.model});

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error: Book not found'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: branaPrimaryColor,
        leading: IconButton(
          color: branaDark,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(model!.thumbnail),
            const SizedBox(height: 20),
            Text(
              model!.name,
              style: GoogleFonts.jost(
                color: branaPrimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              model!.author,
              style: GoogleFonts.jost(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                model!.description,
                style: GoogleFonts.jost(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
