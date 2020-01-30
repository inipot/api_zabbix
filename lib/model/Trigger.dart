import 'dart:convert';
import 'dart:io';

import 'package:api_zabbix/Api.dart';

class Trigger
{
  String id;
  String description;
  String expression;
  Api api;

  Trigger({this.id,this.description,this.expression,this.api});

  factory Trigger.fromJson(Map<String, dynamic> parsedJson, Api api){

    //Map json = parsedJson["result"];
    //print(json.toString());
    return Trigger(id: parsedJson["triggerid"],description: parsedJson["description"],expression: parsedJson["description"],api: api);
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

  getTrigger()
  {
    Map body = {
      "jsonrpc": "2.0",
      "method": "trigger.get",
      "params": {
        "triggerids": ["123416","123432"],
        "output": "extend",
//        "filter":{
//          "value": 1
//        },
        //"selectLastEvent": "extend",
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