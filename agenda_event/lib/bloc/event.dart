import 'dart:developer';
import 'package:agenda_event/entities/event.dart';
import 'package:agenda_event/helper/event_date.dart';


import 'base.dart';

class EventBloc extends BaseBloc<EventBundle> {
  Future<EventBundle> retrieveEvents() async {
    try {
    } catch (e) {}
    return null;
  }

  Stream startStream() {
    log("startStream: $data");

    if (data == null) {
      retrieveEvents(); //.then((value) => sink.add(value));
    }
    return stream;
  }

  Future createEvent(EventDate event, bool isEdit) async {
    try {
    } catch (e) {}
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