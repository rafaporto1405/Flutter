import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class GifPage extends StatelessWidget {

  final Map _gifData;
  //construtor que vai receber o dado
  GifPage(this._gifData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_gifData["title"], style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,  
        actions: <Widget>[
          IconButton(icon: Icon(Icons.share), 
            onPressed: (){
              Share.share(_gifData["images"]["fixed_height"]["url"]);
            }
          )
        ],     
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Image.network(_gifData["images"]["fixed_height"]["url"]),
      ),
    );
  }
}