import 'package:flutter/material.dart';
import '../models/Personagem.dart';
import '../data/database_helper.dart';

class DialogHelpers {
  
  static void editarNumero({
    required BuildContext context,
    required String titulo,
    required int valorAtual,
    required Personagem personagem,
    required Function(int) onSave,
    required VoidCallback onUpdateTela,
  }) {
    final TextEditingController ctrl = TextEditingController(text: valorAtual.toString());
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar $titulo'),
        content: TextField(
          controller: ctrl,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () async {
              int? novoValor = int.tryParse(ctrl.text);
              if (novoValor != null) {
                onSave(novoValor);
                await DatabaseHelper.instance.updatePersonagem(personagem);
                onUpdateTela(); // Atualiza a tela (setState)
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  static void editarStatusDuplo({
    required BuildContext context,
    required String titulo,
    required int valorAtual,
    required int valorMax,
    required Personagem personagem,
    required Function(int, int) onSave,
    required VoidCallback onUpdateTela,
  }) {
    final TextEditingController atualCtrl = TextEditingController(text: valorAtual.toString());
    final TextEditingController maxCtrl = TextEditingController(text: valorMax.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar $titulo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: atualCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor Atual', border: OutlineInputBorder())),
            const SizedBox(height: 16),
            TextField(controller: maxCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Valor Máximo (Permanente)', border: OutlineInputBorder())),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () async {
              int? novoAtual = int.tryParse(atualCtrl.text);
              int? novoMax = int.tryParse(maxCtrl.text);
              if (novoAtual != null && novoMax != null) {
                onSave(novoAtual, novoMax);
                await DatabaseHelper.instance.updatePersonagem(personagem);
                onUpdateTela();
              }
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  static void editarTextoCurto({
    required BuildContext context,
    required String titulo,
    required String textoAtual,
    required Personagem personagem,
    required Function(String) onSave,
    required VoidCallback onUpdateTela,
  }) {
    final TextEditingController ctrl = TextEditingController(text: textoAtual);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar $titulo'),
        content: TextField(controller: ctrl, decoration: const InputDecoration(border: OutlineInputBorder())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () async {
              onSave(ctrl.text);
              await DatabaseHelper.instance.updatePersonagem(personagem);
              onUpdateTela();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  static void editarTextoLongo({
    required BuildContext context,
    required String titulo,
    required String textoAtual,
    required Personagem personagem,
    required Function(String) onSave,
    required VoidCallback onUpdateTela,
  }) {
    final TextEditingController ctrl = TextEditingController(text: textoAtual);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Editar $titulo'),
        content: TextField(controller: ctrl, maxLines: 6, decoration: const InputDecoration(border: OutlineInputBorder())),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
            onPressed: () async {
              onSave(ctrl.text);
              await DatabaseHelper.instance.updatePersonagem(personagem);
              onUpdateTela();
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Salvar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}