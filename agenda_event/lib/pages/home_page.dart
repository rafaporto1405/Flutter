import 'package:agenda_event/bloc/event.dart';
import 'package:agenda_event/helper/event_date.dart';
import 'package:agenda_event/views/event_creator.dart';
import 'package:agenda_event/views/event_list.dart';
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
  //EventList eventListPage;
  EventList eventList = EventList();

  eventDateHelper helper = eventDateHelper();
  List<EventDate> event_date = List();


  final EventBloc _eventBloc = EventBloc();
  List<DateTime> _selectedDates = [];


  @override
  void initState() {
    DateTime dateTime = DateTime.now();
    dateTime.subtract(Duration(days: dateTime.weekday));
    _selectedDates.add(DateTime(dateTime.year, dateTime.month, dateTime.day));

    super.initState();
    _getAllEventdate();
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
          child: Icon(Icons.add, color: Colors.blue,),
          onPressed: () {
            //_ExcluirEvent();
            _testedbConsole();
            _showContactPage();

          },
        )
      ),
    );
  }

  //_showContactPage();

  void _showContactPage({EventDate eventDate}) async {
    final recEventDate = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventCreator(
              eventdate: eventDate,
            )));
    if (recEventDate != null) {
      if (eventDate != null) {
        await helper.updateEventDate(recEventDate);
      } else {
        await helper.saveEventDate(recEventDate);
      }
      _getAllContacts();
    }
  }
  void _getAllContacts() {
    helper.getAllEventDate().then((list) {
      setState(() {
        event_date = list;
      });
    });
  }
  void _getAllEventdate() {
    helper.getAllEventDate().then((list) {
      setState(() {
        event_date = list;
      });
    });
  }
  


  void _testedbConsole(){
    helper.getAllEventDate().then((list){print(list);} );
    //print(event_date);

    //eventList.getAllContacts();
  }

  void _testedb(){
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () { },
    );

    AlertDialog dialogDb = AlertDialog(
      title: Text("Pesquisa DB"),
      content: Text("Nome do evento: " + event_date[0].name), //contacts[index].name
      actions: [
      okButton,
    ],
    );
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
      return dialogDb;
      },
    );
  }
  
  void _ExcluirEvent(){
    helper.deleteEventDate(13);
  }
}
