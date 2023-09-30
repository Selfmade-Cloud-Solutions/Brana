import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:brana_mobile/data.dart';
import 'package:brana_mobile/models/category.dart';

class ListViewPage extends StatelessWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Category> list = FakeData().categoriesList;

    return Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Lorem'),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: AnimationLimiter(
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 1000),
                          child: ScaleAnimation(
                              child: FadeInAnimation(
                                  delay: const Duration(milliseconds: 100),
                                  child: listItem(list[index]))));
                    })),
          ),
        ));
  }

  Widget listItem(Category category) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              padding: const EdgeInsets.all(16),
              child: Image.asset(category.image),
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              category.name,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ));
  }
}
