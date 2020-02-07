import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/Host.dart';

class HostList
{
  List<Host> hosts;
  //Api api;
  HostList({this.hosts});

  factory HostList.fromJson(List<dynamic> parsedJson, Api api)
  {
    //print("Parsed Json"+parsedJson[1].toString());
    List<Host> hosts = List<Host>();
    hosts = parsedJson.map((i)=>Host.fromJson(i, api)).toList();
    //print ("Teste"+hosts.toString());
    return HostList(hosts: hosts);
  }
}