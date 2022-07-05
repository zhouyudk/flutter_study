import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';

class PlankHome extends StatefulWidget {
  const PlankHome({Key? key}) : super(key: key);

  @override
  State<PlankHome> createState() => _PlankHomeState();
}

class _PlankHomeState extends State<PlankHome> {
  final _colorList = [
    Colors.orange,
    Colors.redAccent,
    Colors.amber,
    Colors.blueAccent,
    Colors.cyanAccent
  ];
  Color _backgroundColor = Colors.grey.withAlpha(33);
  Color _foregroundColor = Colors.orange;
  var _milliseconds = 0;
  var _progress = 0.0;
  var _isTiming = false;
  var highestRecord = 0;

  String _formatTime(int time) {
    final milliseconds = time % 1000;
    final second = (time / 1000).truncate() % 60;
    final min = (time / 1000 / 60).truncate();
    return '${min.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}.${milliseconds.toString().padLeft(3, '0')}';
  }

  void _startTimer() {
    Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (!_isTiming) {
        timer.cancel();
        return;
      }
      setState(() {
        _milliseconds += 1;
        if ((_milliseconds / 1000).truncate() % 60 == 0 &&
            (_milliseconds / 1000).truncate() >= 60) {
          _progress = 0;
          _backgroundColor = _foregroundColor;
          _foregroundColor = _colorList.elementAt(
              (_milliseconds / 60 * 1000).truncate() % _colorList.length);
        } else {
          _progress = _milliseconds % (60 * 1000) / (60 * 1000);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Plank"),
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Colors.transparent)),
      body: _buildScaffoldBody(),
    );
  }

  Widget _buildScaffoldBody() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: CircularProgressIndicator(
                value: _progress,
                backgroundColor: _backgroundColor,
                valueColor: AlwaysStoppedAnimation(_foregroundColor),
                strokeWidth: 6,
              ),
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 200),
                child: Center(
                    child: Text(
                  '最高记录: $highestRecord',
                  style: const TextStyle(fontSize: 20, color: Colors.amber),
                )),
              )),
          GestureDetector(
            onTap: () {
              _isTiming = !_isTiming;
              if (_isTiming) {
                _startTimer();
              }
            },
            child: Text(
              _formatTime(_milliseconds),
              style: const TextStyle(fontSize: 45),
            ),
          )
        ],
      ),
    );
  }
}
