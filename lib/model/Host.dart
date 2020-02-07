import 'package:api_zabbix/Api.dart';
import 'package:api_zabbix/model/HostGroup.dart';

class Host{

  Api api;
  String id;
  String nome;

  Host({this.id,this.nome,this.api});


  factory Host.fromJson(Map<String, dynamic> parsedJson, Api api){

    //Map json = parsedJson["result"];
    return Host(nome: parsedJson["name"], id: parsedJson["groupid"], api: api);
  }

  List<HostGroup> hostGroups;

  Future<dynamic> getHosts() async {


    print(api.token);
    Map body = {
      "jsonrpc": "2.0",
      "method": "host.get",
      "params": {
        "filter": {
          "host": "KUROMORI"
        }
      },
      "auth": api.token,
      "id": 1
    };

    return api.inicializa(body);
  }
}
