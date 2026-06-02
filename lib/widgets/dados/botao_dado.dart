import 'package:flutter/material.dart';

class BotaoDado extends StatelessWidget {
  final int lados;
  final VoidCallback onTap;

  const BotaoDado({
    super.key,
    required this.lados,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(16),
      ),
      onPressed: onTap,
      child: Text(
        'd$lados',
        style: const TextStyle(
          fontSize: 22, 
          fontWeight: FontWeight.bold, 
          color: Colors.white,
        ),
      ),
    );
  }
}