import 'package:flutter/material.dart';

class SessaoAnotacaoCard extends StatelessWidget {
  final String titulo;
  final String dica;
  final TextEditingController controlador;
  final IconData icone;

  const SessaoAnotacaoCard({
    super.key,
    required this.titulo,
    required this.dica,
    required this.controlador,
    required this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: const Color(0xFF2C2C2C),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(color: Colors.deepPurpleAccent.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icone, color: Colors.deepPurpleAccent, size: 24),
                const SizedBox(width: 8),
                Text(
                  titulo.toUpperCase(),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2),
                ),
              ],
            ),
            const Divider(color: Colors.deepPurpleAccent, height: 24, thickness: 1),
            TextField(
              controller: controlador,
              maxLines: 5,
              style: const TextStyle(color: Colors.white70, height: 1.5),
              decoration: InputDecoration(
                hintText: dica,
                hintStyle: const TextStyle(color: Colors.white30),
                filled: true,
                fillColor: Colors.black12,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}