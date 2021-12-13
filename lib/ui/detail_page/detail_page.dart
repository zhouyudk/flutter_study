import 'package:flutter/cupertino.dart';
import 'package:flutter_study/repositories/today_news_repository.dart';
import 'package:flutter_study/ui/detail_page/detail_view_model.dart';

class DetailPage extends StatelessWidget {
  final String newsId;
  DetailPage({Key? key, required this.newsId}): super(key: key);

  final viewModel = DetailViewModel();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Text("dfkajsdkfjalksdjflakjdslfkjalsdkjfla----$newsId"),);
  }
}