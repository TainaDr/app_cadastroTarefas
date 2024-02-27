import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:postgres/postgres.dart';

import 'database/conexao.dart';

Future<Response> gravarTarefa(Request request) async {
  String corpoRequisicao = await request.readAsString();
  //print(corpoRequisicao);
  Map dados = jsonDecode(corpoRequisicao);
  try {
    PostgreSQLConnection _conexaoPostgreSQL = await getConexao();
    await _conexaoPostgreSQL.transaction((ctx) async {
      if (dados['id'] != null && dados['id'] > 0) {
        await ctx.query("update Tarefa set nome = @nome, descricao = @descricao, data_limite = @data_limite where id = @id",
            substitutionValues: {
              "nome": dados['nome'],
              'descricao': dados['descricao'],
              'data_limite': dados['data_limite'],
              'id': dados['id']
            });
      } else {
        PostgreSQLResult result = await ctx.query(
            "insert into tarefa (nome, descricao, data_limite) values (@nome, @descricao, @data_limite) returning id",
            substitutionValues: {"nome": dados['nome'], 'descricao': dados['descricao'], 'data_limite': dados['data_limite']});
        dados['id'] = result.first[0];
      }
    });
    return Response.ok(jsonEncode({'id': dados['id']}));
  } catch (erro) {
    return Response.internalServerError(body: 'ERRO: $erro');
  }
}

Future<Response> deletarTarefa(Request request) async {
  String corpoRequisicao = await request.readAsString();
  Map dados = jsonDecode(corpoRequisicao);
  try {
    PostgreSQLConnection _conexaoPostgreSQL = await getConexao();
    await _conexaoPostgreSQL.transaction((ctx) async {
      await ctx.query("delete from Tarefa where id = @id", substitutionValues: {'id': dados['id']});
    });
    return Response.ok(jsonEncode({'id': dados['id']}));
  } catch (erro) {
    return Response.internalServerError(body: 'ERRO: $erro');
  }
}

Future<Response> pesquisarTarefa(Request request) async {
  String corpoRequisicao = await request.readAsString();
  print(corpoRequisicao);
  Map dados = jsonDecode(corpoRequisicao);
  try {
    PostgreSQLConnection _conexaoPostgreSQL = await getConexao();
    List<Map<String, Map<String, dynamic>>> results = await _conexaoPostgreSQL.mappedResultsQuery(
        "select id, nome, descricao, to_char(data_limite, 'yyyy-MM-dd') as data_limite from tarefa where nome ilike @filtro",
        substitutionValues: {'filtro': "%${dados['filtro']}%"});

    List dadosConsulta = [];
    for (var linhaDados in results) {
      dadosConsulta.add({
        "id": linhaDados['tarefa']?['id'],
        "nome": linhaDados['tarefa']?['nome'],
        "descricao": linhaDados['tarefa']?['descricao'],
        "data_limite": linhaDados['']?['data_limite'],
      });
    }

    return Response.ok(jsonEncode(dadosConsulta));
  } catch (erro) {
    return Response.internalServerError(body: 'ERRO: $erro');
  }
}
