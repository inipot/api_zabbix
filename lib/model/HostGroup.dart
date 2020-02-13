import 'dart:convert';
import 'dart:io';
import 'package:api_zabbix/Api.dart';

class HostGroup
{

  Api api;
  String nome;
  String id;

  //HostGroup.api({this.api});

   inicializa(Map body) async
  {

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
    ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(api.url));
    request.headers.set('content-type', 'application/json-rpc');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    String stringResult = await response.transform(utf8.decoder).join();
    Map mapResult = json.decode(stringResult);
    return mapResult["result"];
  }

  HostGroup({this.nome,this.id,this.api});

  factory HostGroup.fromJson(Map<String, dynamic> parsedJson, Api api){

    //Map json = parsedJson["result"];
    //print(json.toString());
    return HostGroup(nome: parsedJson["name"], id: parsedJson["groupid"], api: api);
  }

   getHostGroupsToJson() async {

      print(api.token);
      Map body = {
        "jsonrpc": "2.0",
        "method": "hostgroup.get",
        "params": {

        },
        "auth": api.token,
        "id": 1
      };

   var resultado = inicializa(body);
   print(resultado);
   return resultado;
  }

  getHostGroupsByHostnameToJson(String hostids) async {

    print(api.token);
    Map body = {
      "jsonrpc": "2.0",
      "method": "hostgroup.get",
      "params": {
        "output": "extend",
        "hostids": [hostids],
      },
      "auth": api.token,
      "id": 1
    };

    var resultado = inicializa(body);
    print(resultado);
    return resultado;
  }

}