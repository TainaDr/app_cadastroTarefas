import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

import 'apis/api_cadastro.dart';

// Configure routes.
final _router = Router()
  ..get('/', _rootHandler)
  ..post('/tarefa/gravar', gravarTarefa)
  ..post('/tarefa/deletar', deletarTarefa)
  ..post('/tarefa/pesquisar', pesquisarTarefa);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}


Map<String, Object> corsHeader = {
  'Access-Control-Allow-Origin': 'http://localhost:64233',
  'Access-Control-Allow-Methods': 'OPTIONS, GET, POST',
  'Access-Control-Allow-Headers': 'content-type, authorization, accept, access-control-allow-origin',
  'Access-Control-Allow-Credentials': 'true'
};
final corsMidleware = createMiddleware(requestHandler: (Request request) {
  return (request.method == 'OPTIONS') ? Response.ok('', headers: corsHeader) : null;
}, responseHandler: (Response response) {
  Map<String, Object> headers = {};
  headers.addAll(response.headers);
  headers.addAll(corsHeader);
  return response.change(headers: headers);
});

void main(List<String> args) async {
  // Use any available host or container IP (usually `0.0.0.0`).
  final ip = InternetAddress.anyIPv4;

  // Configure a pipeline that logs requests.
  final handler = Pipeline().addMiddleware(logRequests()).addMiddleware(corsMidleware). addHandler(_router);

  // For running in containers, we respect the PORT environment variable.
  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
