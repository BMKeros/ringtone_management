import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ringtone_management/ringtone_management.dart';
import 'package:audioplayer/audioplayer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AudioPlayer audioPlugin = new AudioPlayer();
  RingtoneManagement _manager = new RingtoneManagement();
  List<Map<String, dynamic>> _listRingtones = [];

  @override
  void initState() {
    super.initState();

    _manager.setRingtoneType(RingtoneManagement.TYPE_NOTIFICATION).then((data) {
      _manager.getRingtonesData.then((List<Map<String, dynamic>> data) {
        setState(() {
          _listRingtones = data;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: new Container(
          padding: new EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              new Expanded(
                child: new ListView(
                  padding: new EdgeInsets.symmetric(vertical: 8.0),
                  children: _listRingtones.toList().map((Map item) {
                    return ListTile(
                      onTap: null,
                      title: new Row(
                        children: <Widget>[
                          new Expanded(child: new Text(item['title'])),
                          new Checkbox(value: false, onChanged: (bool value) {})
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
