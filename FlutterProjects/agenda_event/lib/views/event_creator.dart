import 'package:agenda_event/helper/event_date.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class EventCreator extends StatefulWidget {
  final EventDate eventDate;
  final bool userEdited; //false

  EventCreator({this.eventDate,this.userEdited});

  @override
  _EventCreatorState createState() => _EventCreatorState();
}

class _EventCreatorState extends State<EventCreator> {
  //variaveis data
  DateTime pickedDateStart;
  DateTime pickedDateEnd;
  TimeOfDay timeStart;
  TimeOfDay timeEnd;
  DateTime dateStart;
  DateTime dateEnd;

  //outras
  final nameEventController = TextEditingController();
  final locEventController = TextEditingController();
  final descEventController = TextEditingController();

  EventDate _editedEventDate;
  eventDateHelper saveEvent;


  @override
  void initState() { 
    super.initState();

    if (widget.eventDate == null) {
      _editedEventDate = EventDate();
      pickedDateStart = DateTime.now();
      pickedDateEnd = DateTime.now();
      timeStart = TimeOfDay.now();
      timeEnd = TimeOfDay.now();
    } else {
      // transformando o contato em um mapa e criando um novo contato atraves dele
      _editedEventDate = EventDate.fromMap(widget.eventDate.toMap());

      nameEventController.text = _editedEventDate.name;
      locEventController.text = _editedEventDate.loc;
      descEventController.text = _editedEventDate.desc;

      if(widget.userEdited == false){
        pickedDateStart = DateTime.now();
        pickedDateEnd = DateTime.now();
        timeStart = TimeOfDay.now();
        timeEnd = TimeOfDay.now();
      }else{
        pickedDateStart = DateTime.parse(_editedEventDate.dateStart);
        pickedDateEnd = DateTime.parse(_editedEventDate.dateEnd);
        timeStart = TimeOfDay.now();
        timeEnd = TimeOfDay.now();
      }

    }
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          //Nome Evento
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: TextField(
              controller: nameEventController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: "Nome do Evento:",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              onChanged: (text){
                if(widget.userEdited == true){
                  setState(() {
                    _editedEventDate.name = text;
                  });
                }
              },
            ),
          ),
          //Texto Data Inicio
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: Text("Data de início: ",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18
              ),
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

                leading: Icon(Icons.calendar_today, color: Colors.blue,),
                title:
                Text("${pickedDateStart.day}/${pickedDateStart.month}/${pickedDateStart.year} - ${pickedDateStart.hour}:${pickedDateStart.minute}"), //${timeStart.hour}:${timeStart.minute}
                onTap: _pickDateStart,
              ),
            ),
          ),
          //Texto Data final
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: Text("Data de término: ",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18
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
                leading: Icon(Icons.calendar_today, color: Colors.blue,),
                title: Text("${pickedDateEnd.day}/${pickedDateEnd.month}/${pickedDateEnd.year} - ${pickedDateEnd.hour}:${pickedDateEnd.minute} "),//${timeEnd.hour}:${timeEnd.minute}
                onTap: _pickDateEnd,
              ),
            ),
          ),
          //Localizacao
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: TextField(
              controller: locEventController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.gps_fixed_outlined, color: Colors.blue,),
                labelText: "Localização",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              onChanged: (text){
                if(widget.userEdited == true){
                  setState(() {
                    _editedEventDate.loc = text;
                  });
                }
              },
            ),
          ),
          //Descricao do Evento
          Padding(padding: EdgeInsets.only(left:10.0, top: 10.0,right: 10.0,bottom: 5.0),
            child: TextField(
              controller: descEventController,
              decoration: InputDecoration(
                labelText: "Descrição do Evento: ",
                labelStyle: TextStyle(color: Colors.blue),
              ),
              onChanged: (text){
                if(widget.userEdited == true){
                  setState(() {
                    _editedEventDate.desc = text;
                  });
                }
              },
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
              onPressed: (){
                _editedEventDate.name = nameEventController.text;
                _editedEventDate.dateStart = pickedDateStart.toString();
                _editedEventDate.dateEnd = pickedDateEnd.toString();
                _editedEventDate.loc = locEventController.text;
                _editedEventDate.desc = descEventController.text;
                Navigator.pop(context, _editedEventDate);
              }
            ),
          ),

        ],
      ),
      )
    );
  }

  _pickDateStart()async {
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
    _pickTimeStart(date);
  }

  _pickTimeStart(DateTime date)async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: timeStart,
    );

    if(timeOfDay != null){
      setState(() {
        timeStart = timeOfDay;

        pickedDateStart = DateTime(
            date.year,
            date.month,
            date.day,
            timeOfDay.hour,
            timeOfDay.minute
        );
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

    _pickTimeEnd(date);
  }

  _pickTimeEnd(DateTime date)async {
    TimeOfDay timeOfDay = await showTimePicker(
      context: context, 
      initialTime: timeEnd,
    );

    if(timeOfDay != null){
      setState(() {
        timeEnd = timeOfDay;

        pickedDateEnd = DateTime(
            date.year,
            date.month,
            date.day,
            timeOfDay.hour,
            timeOfDay.minute
        );
      });
    }
  }
  

}