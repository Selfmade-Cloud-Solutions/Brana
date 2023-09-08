import 'package:flutter/material.dart';
import 'package:brana_mobile/data.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:brana_mobile/widgets/back_button.dart';
import 'package:brana_mobile/audioplayer.dart';

class BookDetail extends StatelessWidget {
  const BookDetail({
    Key? key,
    required this.book,
  }) : super(key: key);

  final Book book;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Scroll Controller
    ScrollController scrollController = ScrollController();

    // Scroll to top on widget build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(0);
    });

    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(book.image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(children: [
        // Gradient Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                const Color.fromARGB(255, 31, 28, 28).withOpacity(1),
                const Color.fromARGB(159, 224, 218, 218).withOpacity(0.7),
              ],
            ),
          ),
        ),
        NotificationListener<ScrollNotification>(
  onNotification: (ScrollNotification notification) {
    if (notification.metrics.pixels < -1000) {
      scrollController.jumpTo(-1000);
    }
    return true;
  },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, bottom: 0, right: 16, top: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 0),
                // Modified poster layout
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.6,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.9),
                            spreadRadius: 3,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        book.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  book.title,
                  style: GoogleFonts.jost(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  book.author.fullname,
                  style: GoogleFonts.jost(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const SizedBox(height: 4),
                Text(
                  book.description,
                  style: GoogleFonts.jost(
                    fontSize: 18,
                    fontWeight: FontWeight.w200,
                    color: Colors.white,
                  ),
                ),
                Container(
                  height: 200,
                  width: size.width,
                  padding: const EdgeInsets.only(
                    top: 100,
                    left: 32,
                    right: 32,
                    bottom: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.4, 20),
                          textStyle: const TextStyle(fontSize: 16),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AudioPlayerPage(),
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow_rounded, size: 30),
                        label: const Center(child: Text('Listen')),
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width * 0.4, 20),
                          textStyle: const TextStyle(fontSize: 16),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          shadowColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 5,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_add, size: 30),
                        label: const Center(child: Text('Add to Wishlist')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        )]),
    ));
  }
}
