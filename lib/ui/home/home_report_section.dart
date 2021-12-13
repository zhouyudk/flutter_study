import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_study/utils/date_util.dart';
import 'package:flutter_study/values/dimens.dart';
import 'package:flutter_study/models/news_model.dart';
import 'package:intl/intl.dart';

import 'home_report_tile.dart';

class HomeReportSection extends StatelessWidget {
  final List<NewsModel> dataList;
  final bool isToday;
  final String date;

  const HomeReportSection(
      {Key? key, required this.dataList, this.isToday = true, this.date = ""})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         isToday ? const SizedBox(height: 0) : _buildHeader(),
        ...dataList.map((newsModel) => HomeReportTile(newsModel: newsModel))
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
          left: Dimens.homePageHorizontalPadding, top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _formatDateString(date),
            style: const TextStyle(
                color: Colors.black38,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            width: 8,
          ),
          const Expanded(
              child: Divider(
                color: Colors.black38,
                height: 2,
              ))
        ],
      ),
    );
  }

  String _formatDateString(String dateString) {
   return DateFormat(DateUtil.MMdd).format(DateTime.parse(dateString));
  }
}
