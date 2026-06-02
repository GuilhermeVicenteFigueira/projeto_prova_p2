import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/dados/botao_dado.dart';
import '../widgets/dados/visor_resultado.dart'; // Importamos o novo visor animado!

class DadosView extends StatefulWidget {
  const DadosView({super.key});

  @override
  _DadosViewState createState() => _DadosViewState();
}

class _DadosViewState extends State<DadosView> {
  int _resultado = 0;
  int _ultimoDado = 20;
  bool _isCritico = false;
  bool _isFalha = false;

  void _rolarDado(int lados) {
    final random = Random();
    final resultado = random.nextInt(lados) + 1;

    setState(() {
      _ultimoDado = lados;
      _resultado = resultado;

      if (lados == 20 && resultado == 20) {
        _isCritico = true;
        _isFalha = false;
      } else if (lados == 20 && resultado == 1) {
        _isFalha = true;
        _isCritico = false;
      } else {
        _isCritico = false;
        _isFalha = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF1E1E1E), Color(0xFF121212)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          
          // === COMPONENTE VISUAL EXTRAÍDO COM PASSAGEM DE PARÂMETROS ===
          VisorResultadoDado(
            resultado: _resultado, 
            isCritico: _isCritico, 
            isFalha: _isFalha
          ),
          // ==============================================================

          const SizedBox(height: 20),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _resultado > 0 ? 'Dado Rolado: d$_ultimoDado' : 'Escolha seu dado abaixo',
              style: const TextStyle(fontSize: 16, color: Colors.white70),
            ),
          ),
          
          const Spacer(),
          const Divider(color: Colors.deepPurpleAccent, thickness: 1.5),
          const SizedBox(height: 20),
          
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: [
              BotaoDado(lados: 4, onTap: () => _rolarDado(4)),
              BotaoDado(lados: 6, onTap: () => _rolarDado(6)),
              BotaoDado(lados: 8, onTap: () => _rolarDado(8)),
              BotaoDado(lados: 10, onTap: () => _rolarDado(10)),
              BotaoDado(lados: 12, onTap: () => _rolarDado(12)),
              BotaoDado(lados: 100, onTap: () => _rolarDado(100)),
            ],
          ),
          const SizedBox(height: 16),
          
          InkWell(
            onTap: () => _rolarDado(20),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 160,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [BoxShadow(color: Colors.deepPurple, blurRadius: 10, spreadRadius: 2)],
              ),
              alignment: Alignment.center,
              child: const Text('ROLAR d20', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.5)),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}