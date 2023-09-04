import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:brana_mobile/constants.dart';
import 'package:brana_mobile/screens/details_screens_series.dart'; // Import the SeriesDetailScreen

class TrendingSliderSeries extends StatelessWidget {
  const TrendingSliderSeries({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeriesDetailScreen(
                    series:
                        snapshot.data[itemIndex], // Pass the Podcasts object
                  ),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 200,
                width: 150,
                child: Image.network(
                  '${Constants.imageUrl}${snapshot.data[itemIndex].posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          viewportFraction: 0.65,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 2),
          enlargeCenterPage: true,
          pageSnapping: true,
        ),
      ),
    );
  }
}
