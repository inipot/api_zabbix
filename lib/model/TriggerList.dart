import 'package:api_zabbix/model/Trigger.dart';

import '../Api.dart';

class TriggerList
{
  List<Trigger> triggers;

  TriggerList({this.triggers});

  factory TriggerList.fromJson(List<dynamic> parsedJson, Api api){
    List<Trigger> triggers = List<Trigger>();
    triggers = parsedJson.map((i)=>Trigger.fromJson(i, api)).toList();
    return TriggerList(triggers: triggers);
  }

}