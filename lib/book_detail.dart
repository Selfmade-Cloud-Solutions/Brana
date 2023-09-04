import 'package:brana_mobile/audioplayer.dart';
import 'package:brana_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/data.dart';
import 'package:google_fonts/google_fonts.dart';

class BookDetail extends StatelessWidget {
  final Book book;

  const BookDetail({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: book.title,
            child: Image.asset(book.image, fit: BoxFit.fitWidth),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 48,
              left: 32,
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 42,
                  width: 42,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back,
                      color: kPrimaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.5,
              padding: const EdgeInsets.only(top: 64),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        right: 32,
                        left: 32,
                        bottom: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            book.title,
                            style: GoogleFonts.catamaran(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              height: 1,
                            ),
                          ),
                          Text(
                            book.author.fullname,
                            style: GoogleFonts.catamaran(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                const Row(
                                  children: <Widget>[
                                    // Icon(Icons.star, size: 20, color: kStarsColor,),
                                    // Icon(Icons.star, size: 20, color: kStarsColor,),
                                    // Icon(Icons.star, size: 20, color: kStarsColor,),
                                    // Icon(Icons.star, size: 20, color: kStarsColor,),
                                    // Icon(Icons.star_half, size: 20, color: kStarsColor,),
                                  ],
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  book.score,
                                  style: GoogleFonts.catamaran(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: Text(
                                book.description,
                                style: GoogleFonts.catamaran(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: size.width,
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 32,
                      right: 32,
                      bottom: 32,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.4, 20),
                            textStyle: const TextStyle(fontSize: 16),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                          ),
                          onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AudioPlayerPage(book: book))),
                          // onPressed: () {
                          //   // String dataToSend = "This Is the Data to send";
                          //   Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) =>
                          //           AudioPlayerPage(book: book),
                          //     ),
                          //   );
                          // },
                          icon: const Icon(Icons.play_arrow_rounded, size: 30),
                          label: const Center(child: Text('Listen')),
                        ),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.4, 20),
                            textStyle: const TextStyle(fontSize: 16),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.teal,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            elevation: 5,
                          ),
                          onPressed: () {
                            // String dataToSend = "This Is the Data to send";
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const AudioPlayerPage(),
                            //   ),
                            // );
                          },
                          // onPressed: () => Navigator.of(context).push(
                          //     MaterialPageRoute(
                          //         builder: (context) => const AudioPlayer())),
                          icon: const Icon(Icons.bookmark_add, size: 30),
                          label: const Center(child: Text('Add to Wishlist')),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.bottomLeft,
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //         left: 32, bottom: (size.height * 0.5) - (75 / 2)),
          //     child: Card(
          //       elevation: 4,
          //       margin: const EdgeInsets.all(0),
          //       clipBehavior: Clip.antiAlias,
          //       shape: const RoundedRectangleBorder(
          //         borderRadius: BorderRadius.all(
          //           Radius.circular(15),
          //         ),
          //       ),
          //       child: Container(
          //         width: 75,
          //         height: 75,
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: AssetImage(book.author.image),
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
