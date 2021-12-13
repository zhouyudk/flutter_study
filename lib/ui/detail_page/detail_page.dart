import 'package:flutter/cupertino.dart';

class DetailPage extends StatelessWidget {
  final String newsId;
  const DetailPage({Key? key, required this.newsId}): super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(child: Text("dfkajsdkfjalksdjflakjdslfkjalsdkjfla----$newsId"),);
  }
}