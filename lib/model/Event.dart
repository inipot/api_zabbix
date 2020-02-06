import 'dart:convert';
import 'dart:io';
import 'package:api_zabbix/Api.dart';


class Event
{
  String id;
  String triggerId;
  Api api;

  Event({this.api,this.triggerId,this.id});

  factory Event.fromJson(Map<String, dynamic> parsedJson, Api api){

    //Map json = parsedJson["result"];
    //print(json.toString());
    return Event(id: parsedJson["eventid"],triggerId: parsedJson["objectid"],api: api);
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



   getEventsByEventId(List eventId) async
  {
    print(api.token);
    Map body = {
      "jsonrpc": "2.0",
      "method": "event.get",
      "params": {
        "eventids": eventId,
        "output": "extend",
        "selectHosts": "extend",
        "select_acknowledges": "extend",
        //"selectTags": "extend",
        //"objectids": ["124938"],
        //"severities" : 5,
        //"sortfield": ["clock", "eventid"],
        //"sortorder": "DESC"
      },
      "auth": api.token,
      "id": 1
    };

    var resultado =  inicializa(body);
    print(resultado);
    return resultado;
  }

}