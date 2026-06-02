import 'package:flutter/material.dart';

class VisorResultadoDado extends StatelessWidget {
  final int resultado;
  final bool isCritico;
  final bool isFalha;

  const VisorResultadoDado({
    super.key,
    required this.resultado,
    required this.isCritico,
    required this.isFalha,
  });

  @override
  Widget build(BuildContext context) {
    Color corDoDado = const Color(0xFF2C2C2C);
    Color corSombra = Colors.transparent;

    if (isCritico) {
      corDoDado = Colors.amberAccent;
      corSombra = Colors.amber;
    }
    if (isFalha) {
      corDoDado = Colors.redAccent;
      corSombra = Colors.red;
    }

    return Column(
      children: [
        // Texto dinâmico
        Text(
          isCritico
              ? 'ACERTO CRÍTICO!'
              : isFalha
              ? 'FALHA CRÍTICA!'
              : 'Resultado',
          style: TextStyle(
            fontSize: isCritico || isFalha ? 28 : 20,
            fontWeight: FontWeight.bold,
            color: isCritico
                ? Colors.amber
                : isFalha
                ? Colors.redAccent
                : Colors.grey,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 30),

        // A Animação isolada aqui
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          width: isCritico || isFalha ? 180 : 140,
          height: isCritico || isFalha ? 180 : 140,
          decoration: BoxDecoration(
            color: corDoDado,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCritico || isFalha
                  ? Colors.white
                  : Colors.deepPurpleAccent,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: corSombra.withOpacity(0.8),
                blurRadius: isCritico || isFalha ? 40 : 10,
                spreadRadius: isCritico || isFalha ? 15 : 2,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            resultado > 0 ? '$resultado' : '-',
            style: TextStyle(
              fontSize: 65,
              fontWeight: FontWeight.w900,
              color: isCritico || isFalha ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
