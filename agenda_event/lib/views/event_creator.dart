import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class EventCreator extends StatefulWidget {
  @override
  _EventCreatorState createState() => _EventCreatorState();
}

class _EventCreatorState extends State<EventCreator> {

  final _tileController = TextEditingController();
  final _titleFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _tileController,
              focusNode: _titleFocus,
              decoration: InputDecoration(labelText: "Título", ),
            ),
          ),
          Padding(padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: _tileController,
              focusNode: _titleFocus,
              decoration: InputDecoration(labelText: "Título", ),
            ),
          ),
        ],
      ),
    );
  }
}
