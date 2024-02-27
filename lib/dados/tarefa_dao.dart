import 'dart:convert';
import 'package:aplicativo_pessoas/classes/tarefa.dart';
import 'package:dio/dio.dart';

import '../visao/utilitarios.dart';

class TarefaDAO {
  Future<bool> gravar(Tarefa tarefa) async {
    //chamada ao backend
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.extra["withCredentials"] = true;
        return handler.next(options);
      },
    ));

    Response response = await dio.post('http://localhost:8080/tarefa/gravar',
        data: {
          "id": tarefa.id,
          "nome": tarefa.nome,
          "descricao": tarefa.descricao,
          "data_limite": formatarData(tarefa.data_limite, formato: 'yyyy-MM-dd'),
        });

    if (response.statusCode == 200) {
      var responseMap = jsonDecode(response.data);
      tarefa.id = responseMap['id'];
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deletar(int id) async {
    //chamada ao backend
    Dio dio = Dio();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.extra["withCredentials"] = true;
        return handler.next(options);
      },
    ));
    Response response = await dio.post('http://localhost:8080/tarefa/deletar',
        data: {
          "id": id
        });
    return response.statusCode == 200;
  }

Future<List<Tarefa>> pesquisar(String filtro) async {
  List<Tarefa> tarefas = [];
  //chamada ao backend
  Dio dio = Dio();
  dio.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      options.extra["withCredentials"] = true;
      return handler.next(options);
    },
  ));
  Response response = await dio
      .post('http://localhost:8080/tarefa/pesquisar', data: {"filtro": filtro});
  if (response.statusCode == 200) {
    List responseMapList = jsonDecode(response.data);
    for (var dados in responseMapList) {
      Tarefa tarefa = Tarefa();
      tarefa.id = dados["id"];
      tarefa.nome = dados["nome"];
      tarefa.descricao = dados["descricao"];
      tarefa.data_limite = converterStringParaDateTime(dados["data_limite"], formato: 'yyyy-MM-dd');
      tarefas.add(tarefa);
    }
  }
  return tarefas;
}
}