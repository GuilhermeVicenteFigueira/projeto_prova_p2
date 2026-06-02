import 'package:flutter/material.dart';
import '../models/Personagem.dart';
import '../models/Anotacao.dart';
import '../data/database_helper.dart';
import '../widgets/anotacoes/sessao_anotacao_card.dart'; // O seu novo componente modularizado!

class AnotacoesView extends StatefulWidget {
  final Personagem personagem;

  const AnotacoesView({super.key, required this.personagem});

  @override
  _AnotacoesViewState createState() => _AnotacoesViewState();
}

class _AnotacoesViewState extends State<AnotacoesView> {
  Anotacao? _anotacaoAtual;
  bool _isLoading = true;

  final _mainQuestCtrl = TextEditingController();
  final _sideQuestCtrl = TextEditingController();
  final _npcCtrl = TextEditingController();
  final _loreCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carregarAnotacoes();
  }

  // === A MELHORIA DE MEMÓRIA (MUITO IMPORTANTE) ===
  @override
  void dispose() {
    // Mata os controladores quando a tela for fechada para não travar o celular
    _mainQuestCtrl.dispose();
    _sideQuestCtrl.dispose();
    _npcCtrl.dispose();
    _loreCtrl.dispose();
    super.dispose();
  }

  Future<void> _carregarAnotacoes() async {
    Anotacao? anotacaoSalva = await DatabaseHelper.instance.getAnotacaoDoPersonagem(widget.personagem.id!);

    if (anotacaoSalva == null) {
      final novaAnotacao = Anotacao(
        personagemId: widget.personagem.id!,
        anotacaoMainQuest: '',
        anotacaoSideQuest: '',
        anotacaoNPC: '',
        anotacaoLore: '',
      );
      await DatabaseHelper.instance.insertAnotacao(novaAnotacao);
      anotacaoSalva = await DatabaseHelper.instance.getAnotacaoDoPersonagem(widget.personagem.id!);
    }

    setState(() {
      _anotacaoAtual = anotacaoSalva;
      _mainQuestCtrl.text = _anotacaoAtual!.anotacaoMainQuest;
      _sideQuestCtrl.text = _anotacaoAtual!.anotacaoSideQuest;
      _npcCtrl.text = _anotacaoAtual!.anotacaoNPC;
      _loreCtrl.text = _anotacaoAtual!.anotacaoLore;
      _isLoading = false;
    });
  }

  Future<void> _salvarAnotacoes() async {
    if (_anotacaoAtual != null) {
      _anotacaoAtual!.anotacaoMainQuest = _mainQuestCtrl.text;
      _anotacaoAtual!.anotacaoSideQuest = _sideQuestCtrl.text;
      _anotacaoAtual!.anotacaoNPC = _npcCtrl.text;
      _anotacaoAtual!.anotacaoLore = _loreCtrl.text;

      await DatabaseHelper.instance.updateAnotacao(_anotacaoAtual!);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Diário salvo com sucesso!', style: TextStyle(fontWeight: FontWeight.bold)), 
            backgroundColor: Colors.deepPurpleAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(color: Colors.deepPurpleAccent));
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SessaoAnotacaoCard(titulo: 'Main Quest', dica: 'Progresso da campanha principal...', controlador: _mainQuestCtrl, icone: Icons.explore),
            const SizedBox(height: 16),
            SessaoAnotacaoCard(titulo: 'Side Quests', dica: 'Missões secundárias e favores...', controlador: _sideQuestCtrl, icone: Icons.map),
            const SizedBox(height: 16),
            SessaoAnotacaoCard(titulo: 'NPCs e Aliados', dica: 'Nomes de taverneiros, vilões, aliados...', controlador: _npcCtrl, icone: Icons.groups),
            const SizedBox(height: 16),
            SessaoAnotacaoCard(titulo: 'Lore e Mundo', dica: 'História do mundo, deuses, locais...', controlador: _loreCtrl, icone: Icons.auto_stories),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _salvarAnotacoes,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 8,
        icon: const Icon(Icons.save, color: Colors.white),
        label: const Text('Salvar Diário', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
      ),
    );
  }
}