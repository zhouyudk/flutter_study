import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/ui/home/home_carousel_tile.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key, required this.topNews}) : super(key: key);

  final List<TopNewsModel> topNews;

  @override
  State<HomeCarousel> createState() => _HomeCarousel();
}

class _HomeCarousel extends State<HomeCarousel> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: PageView(
          scrollDirection: Axis.horizontal,
          allowImplicitScrolling: true,
          children: [
            ...widget.topNews.map((model) => HomeCarouselTile(topNewsModel: model))
          ],
        ));
  }
}
