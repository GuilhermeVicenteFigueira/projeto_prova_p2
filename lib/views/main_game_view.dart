import 'package:flutter/material.dart';
import '../models/Personagem.dart';
import 'dados_view.dart';
import 'ficha_view.dart';
import 'anotacoes_view.dart';

class MainGameView extends StatefulWidget {
  final Personagem personagem;

  const MainGameView({super.key, required this.personagem});

  @override
  _MainGameViewState createState() => _MainGameViewState();
}

class _MainGameViewState extends State<MainGameView> {
  int _indiceAtual = 0;

  late List<Widget> _telas;

  @override
  void initState() {
    super.initState();
    _telas = [
      FichaView(personagem: widget.personagem),
      const DadosView(),
      AnotacoesView(personagem: widget.personagem),
    ];
  }

  void _aoTocarNaAba(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.personagem.nome} - ${widget.personagem.classe}'),
        centerTitle: true,
      ),
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _indiceAtual,
        onTap: _aoTocarNaAba,
        selectedItemColor: Colors.deepPurpleAccent,
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFF2C2C2C),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Ficha',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.casino),
            label: 'Dados',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Anotações',
          ),
        ],
      ),
    );
  }
}