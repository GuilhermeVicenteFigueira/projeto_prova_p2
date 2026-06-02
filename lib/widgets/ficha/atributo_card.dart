import 'package:flutter/material.dart';

class AtributoCard extends StatefulWidget {
  final String nomeAtributo;
  final int valor;
  final VoidCallback onTap;

  const AtributoCard({
    super.key,
    required this.nomeAtributo,
    required this.valor,
    required this.onTap,
  });

  @override
  State<AtributoCard> createState() => _AtributoCardState();
}

class _AtributoCardState extends State<AtributoCard> {
  // Variável para controlar se o botão está sendo clicado/focado
  bool _isHoveredOrPressed = false;

  @override
  Widget build(BuildContext context) {
    // AnimatedScale cria o efeito de "afundar" o botão suavemente
    return AnimatedScale(
      scale: _isHoveredOrPressed ? 0.95 : 1.0,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      child: Card(
        elevation: _isHoveredOrPressed ? 8 : 4,
        color: const Color(0xFF2C2C2C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          // A borda fica com a cor mais forte quando pressionada
          side: BorderSide(
            color: Colors.deepPurpleAccent.withOpacity(_isHoveredOrPressed ? 0.8 : 0.4), 
            width: 1.5
          ),
        ),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(12),
          // onHighlightChanged detecta o toque do dedo no celular
          onHighlightChanged: (isHighlighted) {
            setState(() {
              _isHoveredOrPressed = isHighlighted;
            });
          },
          // onHover detecta se o jogador passar o mouse por cima (caso rode no PC)
          onHover: (isHovered) {
            setState(() {
              _isHoveredOrPressed = isHovered;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        widget.nomeAtributo.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurpleAccent,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  widget.valor.toString(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}