import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/news_model.dart';

class HomeCarouselTile extends StatelessWidget {
  final TopNewsModel topNewsModel;

  const HomeCarouselTile({Key? key, required this.topNewsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(image: NetworkImage(topNewsModel.image), fit: BoxFit.fill),
        Positioned(
            left: 30,
            bottom: 20,
            right: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(topNewsModel.title,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(height: 5),
                Text(topNewsModel.hint,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.white70))
              ],
            ))
      ],
    );
  }
}
