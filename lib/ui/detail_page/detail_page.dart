import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_study/common/resource.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:flutter_study/ui/detail_page/detail_view_model.dart';
import 'package:flutter_study/utils/log_util.dart';
import 'package:flutter_study/values/images.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sprintf/sprintf.dart';

import '../state_mixin.dart';

class DetailPage extends StatefulWidget {
  final String newsId;

  const DetailPage({Key? key, required this.newsId}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> with SetStateSafety {
  final viewModel = DetailViewModel();
  var newsDetailResource = Resource<NewsDetailModel>.empty();

  @override
  void initState() {
    viewModel.newsDetail.listen((result) {
      setStateSafety(() {
        newsDetailResource = result;
      });
    });
    viewModel.fetchNewsDetail(widget.newsId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (newsDetailResource.status) {
      case Status.empty:
        return _buildPlaceholder();
      case Status.loading:
        return _buildPlaceholder();
      case Status.success:
        return _buildNormal();
      case Status.error:
        return _buildError();
    }
  }

  Widget _buildNormal() {
    final model = newsDetailResource.data;
    if (model == null) {
      return _buildError();
    } else {
      return ListView(
        children: [
          _header(model),
          _htmlBody(model),
        ],
      );
    }
  }

  Widget _header(NewsDetailModel model) {
    return Stack(
      children: [
        FadeInImage.assetNetwork(
            placeholder: ImageResource.placeHolder, image: model.image),
        const Positioned(
            height: 250,
            bottom: 0,
            left: 0,
            right: 0,
            child: DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                  Colors.transparent,
                  Colors.black,
                ],
                        stops: <double>[
                  0,
                  0.8
                ])))),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(model.title,
                      softWrap: true,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 1),
                    Text(
                      model.imageSource ?? "",
                      style:
                          const TextStyle(color: Colors.white30, fontSize: 15),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }

  Widget _htmlBody(NewsDetailModel model) {
    return Html(data: sprintf(htmlTemplate, [model.css.first, model.body])
        // css+model.body
        );
  }

  Widget _buildPlaceholder() {
    return Shimmer(
      gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Colors.black12,
            Colors.black12,
            Colors.white10,
            Colors.black12,
            Colors.black12
          ],
          stops: <double>[
            0.3,
            0.45,
            0.5,
            0.55,
            0.7
          ]),
      child: ListView(
        children: [
          const AspectRatio(
            aspectRatio: 1.3,
            child: SizedBox(
              width: double.infinity,
              child: DecoratedBox(
                decoration: BoxDecoration(color: Colors.black),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                    padding: EdgeInsets.only(left: 40, bottom: 10),
                    child: SizedBox(
                        width: double.infinity,
                        height: 25,
                        child: DecoratedBox(
                          decoration: BoxDecoration(color: Colors.black),
                        ))),
                ...List.generate(5, (index) => 0).map((e) => const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: SizedBox(
                          width: double.infinity,
                          height: 25,
                          child: DecoratedBox(
                            decoration: BoxDecoration(color: Colors.black),
                          )),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: ElevatedButton(
        child: Text(
          '获取失败，点击重试',
          style: Theme.of(context).textTheme.headline4,
        ),
        onPressed: () => viewModel.fetchNewsDetail(widget.newsId),
      ),
    );
  }
}

const htmlTemplate = '''
<html> \n
  <head> \n
    <style type="text/css"> \n
      <link href=%s rel="stylesheet">\n
    </style> \n
  </head> \n
  <body>
  %s
  </body>
</html>                              
''';
