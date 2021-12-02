import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key, required this.title, required this.month, required this.day}) : super(key: key);
  final String title;
  final String month;
  final String day;
  @override
  State<CustomAppBar> createState() => _CustomAppBar();
}

class _CustomAppBar extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
      return SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Column(
              children: [
                Text(widget.day),
                Text(widget.month)
              ],
            ),
          ],
        ),
      );
  }

}