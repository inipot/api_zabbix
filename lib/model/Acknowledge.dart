import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/Event.dart';
import 'package:api_zabbix/model/Trigger.dart';

class Acknowledge
{
  String id;
  String message;
  int action;
  Event event;
  Trigger trigger;
  String userId;
  Api api;

  Acknowledge({this.id,this.userId,this.message,this.api});

  factory Acknowledge.fromJson(Map<String, dynamic> parsedJson, Api api){

    //Map json = parsedJson["result"];
    //print(json.toString());
    return Acknowledge
      (id: parsedJson["acknowledgeid"],userId: parsedJson["userid"],message: parsedJson["message"],api: api);
  }

}