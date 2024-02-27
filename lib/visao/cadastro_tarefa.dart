
import 'package:flutter/material.dart';
import '../classes/tarefa.dart';
import '../dados/tarefa_dao.dart';
import '../style.dart';

import '../widgets/campo_data.dart';
class TelaCadastroTarefa extends StatefulWidget {
  Function? acaoAposSalvar;
  Tarefa TarefaEmEdicao = Tarefa();

  TelaCadastroTarefa(this.TarefaEmEdicao, {this.acaoAposSalvar});

  List<String> tarefas = [];

  @override
  State<TelaCadastroTarefa> createState() => _TelaCadastroTarefaState();
  
}




  
class _TelaCadastroTarefaState extends State<TelaCadastroTarefa> {
  TextEditingController _dataController = TextEditingController();
  GlobalKey<FormState> chaveForm = GlobalKey<FormState>();

  List<Tarefa> carregarTarefas() {
    List<Tarefa> Tarefas = [];

    Tarefa tarefa1 = Tarefa();
    tarefa1.id = 1;
    tarefa1.nome = 'Tarefa de química';
    tarefa1.descricao = '30 questões eletroquímica';
    //tarefa1.data_limite = DateTime(2022);
    Tarefas.add(tarefa1);

    Tarefa tarefa2 = Tarefa();
    tarefa2.id = 2;
    tarefa2.nome = 'Prova de geografia';
    tarefa2.descricao = 'Biomas do Brasil';
    Tarefas.add(tarefa2);

    return Tarefas;
  }
@override
 

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Tarefas', style: TextStyle(color: Colors.black, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 242, 225, 255),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      /*ottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box),
              label: "Adicionar",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined),
              label: "Pendentes",
            ),
          ],
          onTap: (int index) {
            if (index == 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaCadastroTarefa(Tarefa())),
              );
            } else if (index == 1) {
             // Navigator.push(
               // context,
                //MaterialPageRoute(builder: (context) => PaginaPendentes()),
              //);
            }
          }),*/
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.data_saver_on_rounded),
          label: const Text('Salvar'),
          onPressed: () async {
            if (chaveForm.currentState != null &&
                chaveForm.currentState!.validate()) {
              chaveForm.currentState!.save();
              TarefaDAO dao = TarefaDAO();
              bool gravou = await dao.gravar(widget.TarefaEmEdicao);
              if (gravou) {
                debugPrint("SALVOU CERTO!");
                if (widget.acaoAposSalvar != null) {
                  widget.acaoAposSalvar!();
                }
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              } else {
                debugPrint("NÃO SALVOU");
              }
            }
          }),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
            key: chaveForm,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                  border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color:  Color.fromARGB(255, 0, 0, 0)),
        ),
                        //filled: true,
                        prefixIcon: const Icon(Icons.notes_rounded, color: Color.fromARGB(255, 122, 0, 152)),
                        hintText: "ex: Estudar prova de química",
                        labelText: "Nome da tarefa"),
                    keyboardType: TextInputType.text,
                    initialValue: widget.TarefaEmEdicao.nome,
                    onSaved: (value) {
                      widget.TarefaEmEdicao.nome = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide(color: const Color.fromARGB(255, 0, 0, 0)),
        ),
                        //filled: true,
                        prefixIcon: Icon(Icons.description, color: Color.fromARGB(255, 122, 0, 152)),
                        hintText: "Conteúdos: Eletroquímica",
                        labelText: "Descrição",),
                    keyboardType: TextInputType.text,
                    initialValue: widget.TarefaEmEdicao.descricao,
                    onSaved: (value) {
                      widget.TarefaEmEdicao.descricao = value;
                    },
                  ),
                ),
                Padding(
                  
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    
                  children:[
                    Container(
                      child: campoData(context,
                      
                      incluirHora: false,
                      label: 'Data limite',
                      initialValue: widget.TarefaEmEdicao.data_limite, validator: (value){
                        if (value == null || value.trim().isEmpty ){
                          return 'Informe a data limite!';
                        }
                        return null;
                      }, onChanged: (value){
                        setState((){
                          widget.TarefaEmEdicao.data_limite = value;
                        });
                      }
                      )
                    )
                  ]

                  ),
                ),
                espacoEntreCampos(),
              ],
            )),
      ),
    );
  }
}
