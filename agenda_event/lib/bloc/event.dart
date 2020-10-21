import 'dart:developer';
import 'package:agenda_event/helper/event_date.dart';
import 'package:agenda_event/views/event_creator.dart';
import 'package:flutter/material.dart';
import 'base.dart';

class EventBloc extends BaseBloc<EventBundle> {
  Map<DateTime, List<EventDate>> events = {};
  eventDateHelper helper = eventDateHelper();
  List<EventDate> eventDate = List();
  DateTime actDate;

  Future<EventBundle> retrieveEvents() async {
    try {

    } catch (e) {}
    return null;
  }
  void searchDate(DateTime dateSelect) {
    actDate = dateSelect;
    helper.getEspecEventDate(dateSelect).then((list) {
      eventDate = list;
      testMap(dateSelect);
    });
  }
  void testMap(DateTime dateSelect){

    for(int count =0; count < eventDate.length; count++){
      DateTime date = DateTime.parse(eventDate[count].dateStart);
      date = DateTime(date.year, date.month, date.day);

      if(events.containsKey(date)){
        events[date] = eventDate;
      }else{
        events[dateSelect] = eventDate;
      }
    }
    print(events);
  }

  Future createEvent(BuildContext context,EventDate event, bool isEdit) async {
    try {
      final recEventDate = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventCreator(
                eventDate: event,
                userEdited: isEdit,
              )));
      if (recEventDate != null) {
        if (event != null) {
          await helper.updateEventDate(recEventDate);
        } else {
          await helper.saveEventDate(recEventDate);
        }
        searchDate(actDate);
      }
    } catch (e) {}
  }
  void deleteEvent(int index) {
    helper.deleteEventDate(index);
  }

  Stream startStream() {
    log("startStream: $data");

    if (data == null) {
      retrieveEvents(); //.then((value) => sink.add(value));
    }
    return stream;
  }

}

Map<DateTime, List<EventDate>> toMap(List<EventDate> events) {
  Map<DateTime, List<EventDate>> eventMap = {};
  log("toMap: ${events.length}");

  events.forEach((element) {
    if (element.dateStart == null) return;
    DateTime dateTime =
    DateTime.fromMillisecondsSinceEpoch(int.parse(element.dateStart));

    dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day);
    log("E: ${element.dateStart} $dateTime");

    eventMap[dateTime] ??= [];
    eventMap[dateTime].add(element);
  });
  return eventMap.map((key, value) => MapEntry(
      key, value..sort((v1, v2) => int.parse(v1.dateStart) - int.parse(v2.dateStart))));
}

class EventBundle {
  final Map<DateTime, List<EventDate>> eventMap;

  EventBundle({this.eventMap});
}