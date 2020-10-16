import 'package:agenda_event/bloc/event.dart';
import 'package:agenda_event/views/event_creator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calendar.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin  {
  final EventBloc _eventBloc = EventBloc();
  PersistentBottomSheetController _bottomSheetController;

  List<DateTime> _selectedDates = [];

  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    dateTime.subtract(Duration(days: dateTime.weekday));
    _selectedDates.add(DateTime(dateTime.year, dateTime.month, dateTime.day));

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (c) => _eventBloc..register(context),
      child: Scaffold(   
        appBar: AppBar(
          centerTitle: true,
          title: Text("Agenda",textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w200, fontSize: 36.0 ),
          ),
          backgroundColor: Colors.blue,
          shadowColor: Colors.transparent,
        ),         
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false, //new line
        body: StreamBuilder<EventBundle>(           
            stream: _eventBloc.startStream(),
            builder: (context, snapshot) {
              return CalendarPage(
                events: _eventBloc.data?.eventMap ?? {},
                selectedDates: _selectedDates,
              );
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: _createEvent,
          child: Icon(Icons.add, color: Colors.blue,),
        )
      ),
    );
  }

  void _createEvent() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EventCreator(
        ))
    );
  }

  
}
