import 'package:api_zabbix/model/Acknowledge.dart';
import 'package:api_zabbix/Api.dart';


class AcknowledgeList
{
  List<Acknowledge> acknowledges;

  AcknowledgeList({this.acknowledges});

  factory AcknowledgeList.fromJson(List<dynamic> parsedJson, Api api)
  {
    //print("Parsed Json"+parsedJson[1].toString());
    List<Acknowledge> acknowledges = List<Acknowledge>();
    acknowledges = parsedJson.map((i)=>Acknowledge.fromJson(i, api)).toList();
    //print ("Teste"+hostGroups.toString());
    return AcknowledgeList(acknowledges: acknowledges);
  }

}