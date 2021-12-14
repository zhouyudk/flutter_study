import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/utils/log_util.dart';

class HomeReportTile extends StatelessWidget {
  final NewsModel newsModel;
  final Function(String) onTileClicked;

  const HomeReportTile({Key? key, required this.newsModel, required this.onTileClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      //加上此项 点击空白区域才能响应
      // behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child:  Padding(
        padding: const EdgeInsets.only(left: 24, top: 15, right: 24, bottom: 15),
        child: SizedBox(
          height: 100,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        newsModel.title,
                        maxLines: 2,
                        //文本超长时添加省略号
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        newsModel.hint,
                        style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            color: Colors.black45),
                      )
                    ],
                  )),
              const SizedBox(width: 15),
              AspectRatio(
                  aspectRatio: 1,
                  child: Image(image: NetworkImage(newsModel.images.first)))
            ],
          ),
        ),
      ),
    );
  }

  _onTap() {
    onTileClicked(newsModel.id.toString());
  }
}
