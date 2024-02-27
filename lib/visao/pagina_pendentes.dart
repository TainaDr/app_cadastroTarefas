/*import 'package:flutter/material.dart';

import '../style.dart';
import 'cadastro_tarefa.dart';

class PaginaPendentes extends StatelessWidget {
  const PaginaPendentes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas Pendentes'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 100, 0, 109),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
                MaterialPageRoute(builder: (context) => PaginaPendentes()),
              );
            } else if (index == 1) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaCadastroTarefa(Tarefa())),
              );
            }
          }),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Row(
          children: [
            Text("Você tem 0 tarefas pendentes."),
            espacoEntreCampos(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                
                padding: EdgeInsets.all(14),
              ),
              child: Text('Limpar tudo', style: TextStyle(color: Colors.pink[50]),),
            )
          ],
        ),
      ),
    );
  }
}
*/