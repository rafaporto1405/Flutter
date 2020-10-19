import 'package:agenda_event/entities/event.dart';
import 'package:agenda_event/helper/event_date.dart';
import 'package:agenda_event/helper/time.dart';
import 'package:agenda_event/pages/home_page.dart';
import 'package:flutter/material.dart';

import 'event_creator.dart';

class EventList extends StatefulWidget {
  EventList({this.events, Key key, this.onEdit}) : super(key: key);
  final List<Event> events;
  final ValueChanged<Event> onEdit;
  

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  DateTime pickedDateStart;
  DateTime pickedDateEnd;
  TimeOfDay timeStart;
  TimeOfDay timeEnd;
  eventDateHelper helper = eventDateHelper();
  List<EventDate> event_date = List();

  @override
  void initState() {
    super.initState();

    getAllContacts();

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
                : ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: event_date.length,
                  itemBuilder: (context, index) {
                    //getAllContacts(); retirar duvida se fica em loop ou não
                    return _contactCard(context, index);}
                )
          )
        ],
      ),
    );
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
                      Icons.add_alert ,
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
                      event_date[index].dateStart.substring(0,16) + " às " +event_date[index].dateEnd.substring(0,16) ,
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
      onTap: () {},
    );
  }

  
  void getAllContacts() {
    helper.getAllEventDate().then((list) {
      setState(() {
        event_date = list;
      });
    });
    //print(event_date);
  }



  ListView buildListView(ThemeData theme) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.events?.length ?? 0,
      itemBuilder: (context, i) {
        Event event = widget.events[i];
        return InkWell(
          onTap: () => widget.onEdit(event),
          child: Container(
            child: Stack(
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        width: 48,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 4,
                                color: Colors.white38,
                              ),
                            ),
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 4,
                                color: Colors.white38,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: buildEventDetails(event, theme),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    right: 8,
                    child: IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () => widget.onEdit(event),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }


  Card buildEventDetails(Event event, ThemeData theme) {
    DateTime startDateTime =
    DateTime.fromMillisecondsSinceEpoch(event.startDateTime);
    DateTime endDateTime =
    DateTime.fromMillisecondsSinceEpoch(event.endDateTime);

    Duration duration = endDateTime.difference(startDateTime);
    return Card(
      elevation: 0,
      color: Colors.white10,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  TimeHelper.toText(startDateTime.hour, startDateTime.minute),
                  style:
                  theme.textTheme.subtitle1.copyWith(color: Colors.white),
                ),
                Icon(
                  Icons.chevron_right,
                  size: 16,
                  color: Colors.white70,
                ),
                Text(
                  TimeHelper.toText(endDateTime.hour, endDateTime.minute),
                  style:
                  theme.textTheme.subtitle1.copyWith(color: Colors.white),
                ),
                Text(
                  " (${TimeHelper.toDurationTextByDuration(duration)})",
                  style:
                  theme.textTheme.subtitle1.copyWith(color: Colors.white70),
                ),
              ],
            ),
            Divider(
              color: Colors.white38,
            ),
            Text(
              event.subject,
              style: theme.textTheme.subtitle1
                  .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            Text(
              event.note.isNotEmpty ? event.note : "-",
              style: theme.textTheme.subtitle1.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

}
