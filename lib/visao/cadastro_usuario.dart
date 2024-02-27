/*import 'package:aplicativo_pessoas/classes/usuario.dart';
import 'package:flutter/material.dart';

import '../style.dart';
import 'cadastro_tarefa.dart';

class TelaCadastroUsuario extends StatefulWidget {
  Usuario usuarioEmEdicao = Usuario();

  TelaCadastroUsuario({super.key});

  @override
  State<TelaCadastroUsuario> createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  var chaveForm = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.data_saver_on_rounded),
        label: const Text('Criar conta'),
        onPressed: () {
          if (chaveForm.currentState != null &&
              chaveForm.currentState!.validate()) {
            chaveForm.currentState!.save();
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaCadastroTarefa()),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 120, left: 12, right: 12),
        child: Form(
          key: chaveForm,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.person),
                    hintText: "Usuario da Silva",
                    labelText: "Nome Completo",
                  ),
                  keyboardType: TextInputType.text,
                  initialValue: widget.usuarioEmEdicao.nome,
                  onSaved: (value){
                    widget.usuarioEmEdicao.nome = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.email),
                    hintText: "usuario@usuario.com",
                    labelText: "Email",
                  ),
                  keyboardType: TextInputType.text,
                  initialValue: widget.usuarioEmEdicao.email,
                  onSaved: (value){
                    widget.usuarioEmEdicao.email = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    filled: true,
                    prefixIcon: Icon(Icons.password_sharp),
                    hintText: "********",
                    labelText: "Senha",
                  ),
                  keyboardType: TextInputType.text,
                  initialValue: (widget.usuarioEmEdicao.senha ?? 0) > 0 ? widget.usuarioEmEdicao.senha.toString() : '',
                  onSaved: (value){
                    widget.usuarioEmEdicao.senha = int.tryParse(value ?? '') ;
                  },
                ),
              ),
              espacoEntreCampos(),
            ],
          ),
        ),
      ),
    );
  }
}*/