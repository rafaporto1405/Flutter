import 'dart:ui';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: "Teste App", home: Home()));
}

// Widget Stateful - Possui estado interno podendo ser modificado.
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _info_text = "Pode entrar";

  void _changePeople(int delta) {
    //informa que modificou o estado.
    setState(() {
      _people += delta;

      if (_people < 0) {
        _info_text = "inválido";
      } else if (_people <= 10) {
        _info_text = "Pode entrar";
      } else {
        _info_text = "lotado";
      }
    });
  }

  // na função build chamada quando quer modificar algo do layout.
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/fundoTeste.jpg",
          fit: BoxFit.cover,
          height: 1080.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Pessoas: $_people",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                      onPressed: () {
                        _changePeople(1);
                      },
                      child: Text("+1",
                          style:
                              TextStyle(color: Colors.white, fontSize: 40.0))),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: FlatButton(
                      onPressed: () {
                        _changePeople(-1);
                      },
                      child: Text("-1",
                          style:
                              TextStyle(color: Colors.white, fontSize: 40.0))),
                ),
              ],
            ),
            Text(
              _info_text,
              style:
                  TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
            )
          ],
        )
      ],
    );
  }
}

//*Stateless - widget - não possui um estado interno;
//não vão mudar.
//- Criando um Widget Stateful -
//stful e TAB;
