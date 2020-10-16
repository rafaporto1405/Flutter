import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class EventCreator extends StatefulWidget { 

  @override
  _EventCreatorState createState() => _EventCreatorState();
}

class _EventCreatorState extends State<EventCreator> {
  DateTime pickedDateStart;
  DateTime pickedDateEnd;
  TimeOfDay timeStart;
  TimeOfDay timeEnd;

  @override
  void initState() { 
    super.initState();
    pickedDateStart = DateTime.now();
    pickedDateEnd = DateTime.now();
    timeStart = TimeOfDay.now();
    timeEnd = TimeOfDay.now();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Evento"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Nome Evento
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Nome do Evento:",
                labelStyle: TextStyle(color: Colors.blue),
              )
            ),
          ),
          //Data Inicio
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: Container(
              alignment: Alignment.center,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
                  width: 2.0, 
                  color: Colors.blue,             
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
                )
              ),
              child: ListTile(
                title: Text("Data de início: ${pickedDateStart.day}/${pickedDateStart.month}/${pickedDateStart.year}"),
                trailing: Icon(Icons.calendar_today, color: Colors.blue,),
                onTap: _pickDate,
              ),
            ),
          ),
          //Data Final
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: Container(
              alignment: Alignment.center,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
                  width: 2.0, 
                  color: Colors.blue,             
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
                )
              ),
              child: ListTile(
                title: Text("Data de término: ${pickedDateEnd.day}/${pickedDateEnd.month}/${pickedDateEnd.year}"),
                trailing: Icon(Icons.calendar_today, color: Colors.blue,),
                onTap: _pickDateEnd,
              ),
            ),
          ),
          //Horario Inicio
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: Container(
              alignment: Alignment.center,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
                  width: 2.0, 
                  color: Colors.blue,             
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
                )
              ),
              child: ListTile(
                title: Text("Horário de início: ${timeStart.hour}:${timeStart.minute}"),
                trailing: Icon(Icons.calendar_today, color: Colors.blue,),
                onTap: _pickTimeStart,
              ),
            ),
          ),
          //Horario Final
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: Container(
              alignment: Alignment.center,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.white,
                  border: Border.all(
                  width: 2.0, 
                  color: Colors.blue,             
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0)
                )
              ),
              child: ListTile(
                title: Text("Horário de término: ${timeEnd.hour}:${timeEnd.minute}"),
                trailing: Icon(Icons.calendar_today, color: Colors.blue,),
                onTap: _pickTimeEnd,
              ),
            ),
          ),
          //Localizacao
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.gps_fixed_outlined, color: Colors.blue,),
                labelText: "Localização",
                labelStyle: TextStyle(color: Colors.blue),
              )
            ),
          ),
          //Descricao do Evento
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Descrição do Evento: ",
                labelStyle: TextStyle(color: Colors.blue),
              )
            ),
          ),
          //criar evento
          Padding(padding: EdgeInsets.only(left:10.0, top: 20.0,right: 10.0,bottom: 5.0),
            child: RaisedButton(
              child: const Text('Criar Evento', style: TextStyle(color: Colors.white, fontSize: 20),),
              color: Colors.blue,
              elevation: 10.0,
              splashColor: Colors.blueAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.only(top:20.0, left:30.0,right: 30.0, bottom: 20.0),
              onPressed: (){}
            ),
          ),

        ],
      ),
      )
    );
  }

  _pickDate()async {
    DateTime date = await showDatePicker(
      context: context, 
      initialDate: pickedDateStart,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5)
    );

    if(date != null){
      setState(() {
        pickedDateStart = date;
      });
    }
  }

    _pickDateEnd()async {
    DateTime date = await showDatePicker(
      context: context, 
      initialDate: pickedDateEnd,
      firstDate: DateTime(DateTime.now().year-5),
      lastDate: DateTime(DateTime.now().year+5)
    );

    if(date != null){
      setState(() {
        pickedDateEnd = date;
      });
    }
  }

  _pickTimeStart()async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context, 
      initialTime: timeStart,
    );

    if(timeOfDay != null){
      setState(() {
        timeStart = timeOfDay;
      });
    }
  }

  _pickTimeEnd()async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context, 
      initialTime: timeEnd,
    );

    if(timeOfDay != null){
      setState(() {
        timeEnd = timeOfDay;
      });
    }
  }
  

}