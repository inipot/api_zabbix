import 'package:api_zabbix/Api.dart';

class HostGroup
{
  Api api;
  String nome;
  String id;

  //HostGroup.api({this.api});

  HostGroup({this.nome,this.id,this.api});

  factory  HostGroup.fromJson(Map<String, dynamic> parsedJson){

    Map json = parsedJson["result"];
    return HostGroup(nome: json["name"], id: json["groupid"]);
  }

  Future<dynamic> getHostGroups() async {

    print(api.token);
    Map body = {
      "jsonrpc": "2.0",
      "method": "hostgroup.get",
      "params": {

      },
      "auth": api.token,
      "id": 1
    };

    return api.inicializa(body);
  }
}