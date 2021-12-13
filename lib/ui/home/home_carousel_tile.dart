import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/news_model.dart';

class HomeCarouselTile extends StatelessWidget {
  final TopNewsModel topNewsModel;
  final Function(String) onTileClicked;

  const HomeCarouselTile({Key? key, required this.topNewsModel, required this.onTileClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        //加上此项 点击空白区域才能响应
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image(
                image: NetworkImage(topNewsModel.image),
                fit: BoxFit.fill,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) =>
                loadingProgress == null
                    ? child
                    : const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: ColoredBox(color: Colors.grey),
                ),
              ),
            ),
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
        )
      );
  }

  _onTap() {
    onTileClicked(topNewsModel.id.toString());
  }
}
