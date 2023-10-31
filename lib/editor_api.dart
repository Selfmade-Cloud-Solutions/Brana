import 'dart:convert';
import 'package:brana_mobile/pages/recomendations/editors_picks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/data.dart';

Future<List<dynamic>> fetchAudiobooks() async {
  final response = await http.get(Uri.parse('https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_audiobooks'));
  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    return jsonData['message'];
  } else {
    throw Exception('Failed to fetch audiobooks');
  }
}

class AudiobookList extends StatelessWidget {
  @override

      Widget build(BuildContext context) {
    return  ListView(
        children: [
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
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 0, top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Editors Picks",
                                  style: GoogleFonts.jost(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: branaWhite,
                                  ),
                                ),
                                Row(
                                  children: [
                                    
                                      Row(
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
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Container(
                            color: kLightBlue.withOpacity(0.1),
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [builded(createElement())],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
            ]
);
}

  Widget builded(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fetchAudiobooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final audiobook = snapshot.data![index];
              final title = audiobook['title'];

              // Skip rendering if title is null
              if (title == null) {
                return const SizedBox.shrink();
              }

              return Container(
                margin: EdgeInsets.only(
                  right: 32,
                  left: index == 0 ? 16 : 0,
                  bottom: 8,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
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
                        margin: const EdgeInsets.only(
                        bottom: 16,
                        top: 24,
                      ),
                      child: Hero(
                        tag:audiobook['title'],
                        child: Image.network(
                          '${audiobook['thumbnail']}',
                          height:150,
                          width: 150,
                        )
                      ),
                      )
                      ),
                        Text(
                          audiobook['title'],
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),Text(
                          audiobook['author'],
                          style: GoogleFonts.jost(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white70,
                          ),
                        ),
                      
                  ],
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}


// void main() {
//   runApp(MaterialApp(
//     home: AudiobookList()
//     ));
//     }
      









// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:brana_mobile/constants.dart';
// import 'package:brana_mobile/data.dart';

// class EditorsPicksPage extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<EditorsPicksPage> {
//   // List data = [];
//   List<dynamic> data = [];
//   List<Book> books = getBookList();
//   Future<String> getData() async {
//     var response = await http.get(Uri.parse(
//         'https://app.berana.app/api/method/brana_audiobook.api.audiobook_api.retrieve_editors_picks'));
//     setState(() {
//       var extractdata = json.decode(response.body);
//       data = extractdata["message"];
//     });
//     return "Success";
//   }

//   @override
//   void initState() {
//     super.initState();
//     getData();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("API Data"),
//       ),
//       body: ListView.builder(
//           itemCount: data.length,
//           itemBuilder: (BuildContext context, int index) {
//             return SizedBox(
//               height: 200,
//               width: 200,
//               child: Container(
//                 color: kLightBlue.withOpacity(0.1),
//                 child: ListView(
//                   physics: const BouncingScrollPhysics(),
//                   scrollDirection: Axis.horizontal,
//                   children: buildBookEditors(),
//                 ),
//               ),
//             );
//           }),
//     );
//   }

//   List<Widget> buildBookEditors() {
//     List<Widget> list = [];
//     for (var i = 0; i < books.length; i++) {
//       list.add(buildBookEditor(books[i], i));
//     }
//     return list;
//   }

//   Widget buildBookEditor(Book book, int index) {
//     return SizedBox(
//   width: MediaQuery.of(context).size.width, // Set the width constraint
//   child: ListView.builder(
//         itemCount: data.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Container(
//             margin: EdgeInsets.only(
//                 right: 32, left: index == 0 ? 16 : 0, bottom: 8),
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color.fromARGB(255, 0, 0, 0)
//                                 .withOpacity(0.1),
//                             spreadRadius: 8,
//                             blurRadius: 5,
//                             offset: const Offset(0, 3),
//                           ),
//                         ],
//                       ),
//                       margin: const EdgeInsets.only(
//                         bottom: 16,
//                         top: 24,
//                       ),
//                       child: Hero(
//                         tag: data[index]['title'],
//                         child: Text(
//                           data[index]['title'],
//                           // fit: BoxFit.fitWidth,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text(
//                     data[index]['title'],
//                     style: GoogleFonts.jost(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white70),
//                   ),
//                   Text(
//                     data[index]['Author'],
//                     style: GoogleFonts.jost(
//                       fontSize: 14,
//                       color: branaWhite,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ]),
//           );
//         }));
//   }
// }
