import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/constants.dart';

class RecommendedList extends StatefulWidget {
  const RecommendedList({Key? key}) : super(key: key);

  @override
  State<RecommendedList> createState() => _AudiobookListState();
}

class _AudiobookListState extends State<RecommendedList> {
  late List<dynamic> audiobooks = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_audiobooks'));
    if (response.statusCode == 200) {
      setState(() {
        audiobooks = jsonDecode(response.body)['message'];
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      itemCount: audiobooks.length,
      itemBuilder: (context, index) {
        final audiobook = audiobooks[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 150,
            height: 50,
            margin: const EdgeInsets.only(right: 5, left: 5),
            color: kLightBlue.withOpacity(0.1),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: audiobook['thumbnail'] != null
                      ? Image.network(
                          audiobook['thumbnail'],
                          width: 140,
                          height: 140,
                        )
                      : const SizedBox.shrink(),
                ),
                const SizedBox(height: 10),
                Text(
                  audiobook['title'] ?? '',
                  style: GoogleFonts.jost(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: branaGrey,
                  ),
                ),
                Text(
                  audiobook['author'] ?? '',
                  style: GoogleFonts.jost(
                    fontSize: 14,
                    color: branaWhite,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
