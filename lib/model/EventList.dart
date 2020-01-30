import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/Event.dart';

class EventList
{
  List<Event> events;

  EventList({this.events});

  factory EventList.fromJson(List<dynamic> parsedJson, Api api){
    List<Event> events = List<Event>();
    events = parsedJson.map((i)=>Event.fromJson(i, api)).toList();
    return EventList(events: events);
  }

}