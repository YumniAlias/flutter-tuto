import 'package:flutter/material.dart';
import 'package:flutter_tut/data/constants.dart';
import 'package:flutter_tut/views/pages/course_page.dart';
import 'package:flutter_tut/views/widgets/container_widget.dart';
import 'package:flutter_tut/views/widgets/hero_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> list = [
      KValue.keyConcepts,
      KValue.cleanUi,
      KValue.fixBugs,
      KValue.basicLayout,
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0,),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.0,),
            HeroWidget(title: 'Flutter Mapp', nextPage: CoursePage()),
            SizedBox(height: 5.0,),
            ...List.generate(list.length, (index) {
              return ContainerWidget(
                title: list.elementAt(index),
                description: 'This is a description',
              );
            }),
          ],
        ),
      ),
    );
  }
}
