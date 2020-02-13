import 'package:api_zabbix/Api.dart';

class Host{

  Api api;
  String id;
  String nome;

  Host({this.id,this.nome,this.api});


  factory Host.fromJson(Map<String, dynamic> parsedJson, Api api){

    //Map json = parsedJson["result"];
    //print(json);
    return Host(nome: parsedJson["host"], id: parsedJson["hostid"],api: api);
  }


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
