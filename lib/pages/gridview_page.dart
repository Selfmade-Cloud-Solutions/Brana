import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/models/category.dart';

class GridViewPage extends StatelessWidget {
  const GridViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> list = FakeData().categoriesList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors to follow'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: AnimationLimiter(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return AnimationConfiguration.staggeredGrid(
                      columnCount: 2,
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      child: ScaleAnimation(
                          child: FadeInAnimation(
                              delay: const Duration(milliseconds: 100),
                              child: listItem(list[index]))));
                })),
      ),
    );
  }

  Widget listItem(Category category) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Image.asset(category.image,
                  width: 300, height: 130, fit: BoxFit.cover),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              category.name,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ));
  }
}
