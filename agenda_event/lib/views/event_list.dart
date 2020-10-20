import 'package:agenda_event/entities/event.dart';
import 'package:agenda_event/helper/event_date.dart';
import 'package:agenda_event/helper/time.dart';
import 'package:agenda_event/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'event_creator.dart';

class EventList extends StatefulWidget {
  EventList({this.events, Key key, this.onEdit, }) : super(key: key);
  final List<Event> events;
  final ValueChanged<Event> onEdit;


  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  eventDateHelper helper = eventDateHelper();
  //List<EventDate> event_date_cont = List();
  List<EventDate> event_date = List();
  //DateTime eventdatecont;

  void _getAllContacts() {
    helper.getAllEventDate().then((list) {
      setState(() {
        event_date = list;
      });
    });
  }
  /*void _getEspecEventDate() {
    helper.getAllEventDate().then((list) {
      setState(() {
        event_date_cont = list;
        for(int cont = 0; cont <= event_date_cont.length;cont++){
          eventdatecont = DateTime.parse(event_date_cont[cont].dateStart);

          if(eventdatecont.day == 19){
            event_date.add(event_date_cont[cont]);
          }
        }
      });
    });
  }*/


  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.blue, // aba baixo
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8)),
              width: 120,
              height: 8,
            ),
          ),
          Expanded(
              child: event_date.isEmpty ?? true
                  ? Container(
                margin: EdgeInsets.only(top: 16),
                alignment: Alignment.topCenter,
                child: Text(
                  "Sem Eventos",
                  style: theme.textTheme.headline6
                      .copyWith(color: Colors.white),
                ),
              )
                  : RefreshIndicator(
                  child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemCount: event_date.length,
                      itemBuilder: (context, index) {
                        return _contactCard(context, index);
                      }
                  ),
                  onRefresh: _refreshEvent
              )
          )
        ],
      ),
    );
  }

  Future<Null> _refreshEvent() async {
    helper.getAllEventDate().then((list) {
      setState(() {
        event_date = list;
      });
    });
  }

  Widget _contactCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_alert,
                      color: Colors.blue,
                    ),
                    Text(
                      event_date[index].name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold,
                          color: Colors.blue
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      event_date[index].dateStart.substring(0, 16) + " às " +
                          event_date[index].dateEnd.substring(0, 16),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      event_date[index].loc,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      onTap: (){
        _showEventPage(context,eventDate: event_date[index]);
      }
    );
  }

  void _showEventPage(BuildContext context, {EventDate eventDate}) async {
    final recEventDate = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EventCreator(
              eventdate: eventDate,
            )));
    if (recEventDate != null) {
      await helper.updateEventDate(recEventDate);
      _getAllContacts();
    }
  }
}