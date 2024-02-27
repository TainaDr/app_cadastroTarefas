import 'package:aplicativo_pessoas/dados/tarefa_dao.dart';
import 'package:aplicativo_pessoas/visao/cadastro_tarefa.dart';
import 'package:flutter/material.dart';

import '../classes/tarefa.dart';

class TelaPesquisaTarefa extends StatefulWidget {
  const TelaPesquisaTarefa({super.key});

  @override
  State<TelaPesquisaTarefa> createState() => _TelaPesquisaTarefaState();
}

class _TelaPesquisaTarefaState extends State<TelaPesquisaTarefa> {
  FocusNode focusNodeCampoPesquisa = FocusNode();
  TextEditingController controladorCampoFiltro = TextEditingController();
  List<Tarefa> tarefaPesquisadas = [];

  Future<List<Tarefa>> pesquisarTarefas(String filtro) async {
    TarefaDAO dao = TarefaDAO();
    tarefaPesquisadas = await dao.pesquisar(filtro);
    return tarefaPesquisadas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Color.fromARGB(255, 76, 0, 82),
  title: const Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.note_alt_outlined, color: Colors.white,),
        Center(
          child: Text(
            "Lista de tarefas",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
            
          ),
        ),
    ],
  ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 60),
          child: Center(
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: (String texto) {
                    setState(() {
                      pesquisarTarefas(texto);
                    });
                  },
                  controller: controladorCampoFiltro,
                  decoration: const InputDecoration(
                      filled: true,
                      prefixIcon: Icon(Icons.search),
                      hintText: "ex: Estudar prova de química",
                      labelText: "Filtro de Pesquisa"),
                )),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    TelaCadastroTarefa(Tarefa(), acaoAposSalvar: () {
                      setState(() {
                        pesquisarTarefas(controladorCampoFiltro.text);
                      });
                    })));
          },
          child: Icon(Icons.add)),
      body: FutureBuilder(
        future: pesquisarTarefas(controladorCampoFiltro.text),
        builder: (BuildContext context, AsyncSnapshot<List<Tarefa>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Carregando dados, aguarde...'),
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao acrregar dados, tente novamente...'),
            );
          }
          tarefaPesquisadas = snapshot.data as List<Tarefa>;
          return ListView.builder(
              itemCount: tarefaPesquisadas.length,
              itemBuilder: (context, indice) {
                return ListTile(
                  tileColor: indice % 2 == 0
                      ? Color.fromARGB(255, 241, 211, 246)
                      : Color.fromARGB(255, 244, 244, 244),
                  title: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tarefaPesquisadas[indice].nome ?? '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              tarefaPesquisadas[indice].descricao ?? '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              tarefaPesquisadas[indice].data_limite != null
                                  ? tarefaPesquisadas[indice]
                                      .data_limite
                                      .toString()
                                  : 'Data não disponível',
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => TelaCadastroTarefa(
                                        tarefaPesquisadas[indice],
                                        acaoAposSalvar: () {
                                      setState(() {
                                        pesquisarTarefas(
                                            controladorCampoFiltro.text);
                                      });
                                    })));
                          },
                          icon: Icon(Icons.edit,
                              color: Color.fromARGB(255, 43, 0, 69))),
                      IconButton(
                          onPressed: () async {
                            TarefaDAO dao = TarefaDAO();
                            if (await dao
                                .deletar(tarefaPesquisadas[indice].id)) {
                              setState(() {
                                pesquisarTarefas(controladorCampoFiltro.text);
                              });
                            }
                          },
                          icon: Icon(Icons.delete,
                              color: Color.fromARGB(255, 130, 1, 83))),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
