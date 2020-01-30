import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/HostGroup.dart';

class HostGroupList
{
   List<HostGroup> hostGroups;
   //Api api;
   HostGroupList({this.hostGroups});

   factory HostGroupList.fromJson(List<dynamic> parsedJson, Api api)
   {
     //print("Parsed Json"+parsedJson[1].toString());
     List<HostGroup> hostGroups = List<HostGroup>();
     hostGroups = parsedJson.map((i)=>HostGroup.fromJson(i, api)).toList();
     //print ("Teste"+hostGroups.toString());
     return HostGroupList(hostGroups: hostGroups);
   }

}