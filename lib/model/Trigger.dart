import 'dart:convert';
import 'dart:io';
import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/HostList.dart';

class Trigger
{
  String id;
  String description;
  String expression;
  HostList hosts;
  Api api;
  String lastEvent;

  Trigger({this.id,this.description,this.expression,this.lastEvent,this.hosts,this.api});

  factory Trigger.fromJson(Map<String, dynamic> parsedJson, Api api){

    //Map json = parsedJson["result"];
    //print(parsedJson["hosts"][0]["hostid"].toString());
    return Trigger
      (id: parsedJson["triggerid"],description: parsedJson["description"],expression: parsedJson["description"],
        lastEvent: parsedJson["lastEvent"]["eventid"],hosts: HostList.fromJson(parsedJson["hosts"], api),api: api);
  }


  inicializa(Map body) async
  {

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(api.url));
    request.headers.set('content-type', 'application/json-rpc');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    print(response.statusCode);
    String stringResult = await response.transform(utf8.decoder).join();
    //print(stringResult);
    Map mapResult = json.decode(stringResult);
    return mapResult["result"];
  }

  getTriggerWithProblemWithLastEvent()
  {
    Map body = {
      "jsonrpc": "2.0",
      "method": "trigger.get",
      "params": {
        //"triggerids": ["124938"],
        "output": "extend",
        "filter":{
          "value": 1
        },
        "selectLastEvent": "extend",
        "selectHosts": "extend",
        "sortfield": "priority",
        "sortorder": "DESC"
      },
      "auth": api.token,
      "id": 1
    };

    var resultado = inicializa(body);
    print(resultado);
    return resultado;
  }

}