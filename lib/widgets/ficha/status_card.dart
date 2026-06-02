import 'package:flutter/material.dart';

class StatusCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final Color cor;
  final VoidCallback onTap;

  const StatusCard({
    super.key,
    required this.titulo,
    required this.valor,
    required this.cor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: cor.withOpacity(0.1),
          border: Border.all(color: cor.withOpacity(0.5), width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(titulo, style: TextStyle(fontSize: 16, color: cor, fontWeight: FontWeight.bold)),
                const SizedBox(width: 4),
                Icon(Icons.edit, size: 14, color: cor),
              ],
            ),
            const SizedBox(height: 6),
            Text(valor, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}