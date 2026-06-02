import 'package:flutter/material.dart';
import '../models/Personagem.dart';
import '../utils/dialog_helpers.dart'; // Importa a nossa ferramenta de pop-ups
import '../widgets/ficha/atributo_card.dart';
import '../widgets/ficha/status_card.dart'; // Importa o novo botão de Status

class FichaView extends StatefulWidget {
  final Personagem personagem;

  const FichaView({super.key, required this.personagem});

  @override
  _FichaViewState createState() => _FichaViewState();
}

class _FichaViewState extends State<FichaView> {
  void _atualizarTela() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.personagem;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // CABEÇALHO PRINCIPAL DA FICHA
          Card(
            elevation: 4,
            color: Colors.deepPurple.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () => DialogHelpers.editarTextoCurto(
                      context: context,
                      titulo: 'Nome do Personagem',
                      textoAtual: p.nome,
                      personagem: p,
                      onSave: (val) => p.nome = val,
                      onUpdateTela: _atualizarTela,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            p.nome.isEmpty ? "Sem Nome" : p.nome,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.edit, size: 18, color: Colors.grey),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => DialogHelpers.editarTextoCurto(
                          context: context,
                          titulo: 'Classe',
                          textoAtual: p.classe,
                          personagem: p,
                          onSave: (val) => p.classe = val,
                          onUpdateTela: _atualizarTela,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Classe: ${p.classe.isEmpty ? "Não definida" : p.classe}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        '   |   ',
                        style: TextStyle(color: Colors.white30, fontSize: 16),
                      ),
                      InkWell(
                        onTap: () => DialogHelpers.editarNumero(
                          context: context,
                          titulo: 'Nível/XP',
                          valorAtual: p.xp,
                          personagem: p,
                          onSave: (val) => p.xp = val,
                          onUpdateTela: _atualizarTela,
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Nível: ${p.xp}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.white70,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  InkWell(
                    onTap: () => DialogHelpers.editarTextoCurto(
                      context: context,
                      titulo: 'Raça',
                      textoAtual: p.raca,
                      personagem: p,
                      onSave: (val) => p.raca = val,
                      onUpdateTela: _atualizarTela,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Raça: ${p.raca.isEmpty ? "Não definida" : p.raca}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.edit, size: 14, color: Colors.white70),
                      ],
                    ),
                  ),

                  const Divider(height: 30, color: Colors.deepPurpleAccent),

                  // STATUS DE COMBATE - PV, PE, CA
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatusCard(
                        titulo: 'PV',
                        valor: '${p.pvAtual}/${p.pvMax}',
                        cor: Colors.redAccent,
                        onTap: () => DialogHelpers.editarStatusDuplo(
                          context: context,
                          titulo: 'Pontos de Vida',
                          valorAtual: p.pvAtual,
                          valorMax: p.pvMax,
                          personagem: p,
                          onSave: (atual, max) {
                            p.pvAtual = atual;
                            p.pvMax = max;
                          },
                          onUpdateTela: _atualizarTela,
                        ),
                      ),
                      StatusCard(
                        titulo: 'PE',
                        valor: '${p.peAtual}/${p.peMax}',
                        cor: Colors.blueAccent,
                        onTap: () => DialogHelpers.editarStatusDuplo(
                          context: context,
                          titulo: 'Pontos de Esforço',
                          valorAtual: p.peAtual,
                          valorMax: p.peMax,
                          personagem: p,
                          onSave: (atual, max) {
                            p.peAtual = atual;
                            p.peMax = max;
                          },
                          onUpdateTela: _atualizarTela,
                        ),
                      ),
                      StatusCard(
                        titulo: 'CA',
                        valor: '${p.classeArmadura}',
                        cor: Colors.orangeAccent,
                        onTap: () => DialogHelpers.editarNumero(
                          context: context,
                          titulo: 'Classe de Armadura',
                          valorAtual: p.classeArmadura,
                          personagem: p,
                          onSave: (val) => p.classeArmadura = val,
                          onUpdateTela: _atualizarTela,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Atributos',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // GRADE DE ATRIBUTOS
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            childAspectRatio: 0.9,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              AtributoCard(
                nomeAtributo: 'Força',
                valor: p.forca,
                onTap: () => DialogHelpers.editarNumero(
                  context: context,
                  titulo: 'Força',
                  valorAtual: p.forca,
                  personagem: p,
                  onSave: (val) => p.forca = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
              AtributoCard(
                nomeAtributo: 'Destreza',
                valor: p.destreza,
                onTap: () => DialogHelpers.editarNumero(
                  context: context,
                  titulo: 'Destreza',
                  valorAtual: p.destreza,
                  personagem: p,
                  onSave: (val) => p.destreza = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
              AtributoCard(
                nomeAtributo: 'Constituição',
                valor: p.constuicao,
                onTap: () => DialogHelpers.editarNumero(
                  context: context,
                  titulo: 'Constituição',
                  valorAtual: p.constuicao,
                  personagem: p,
                  onSave: (val) => p.constuicao = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
              AtributoCard(
                nomeAtributo: 'Inteligência',
                valor: p.inteligencia,
                onTap: () => DialogHelpers.editarNumero(
                  context: context,
                  titulo: 'Inteligência',
                  valorAtual: p.inteligencia,
                  personagem: p,
                  onSave: (val) => p.inteligencia = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
              AtributoCard(
                nomeAtributo: 'Sabedoria',
                valor: p.sabedoria,
                onTap: () => DialogHelpers.editarNumero(
                  context: context,
                  titulo: 'Sabedoria',
                  valorAtual: p.sabedoria,
                  personagem: p,
                  onSave: (val) => p.sabedoria = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
              AtributoCard(
                nomeAtributo: 'Carisma',
                valor: p.carisma,
                onTap: () => DialogHelpers.editarNumero(
                  context: context,
                  titulo: 'Carisma',
                  valorAtual: p.carisma,
                  personagem: p,
                  onSave: (val) => p.carisma = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // CAMPO DE HABILIDADES ESPECIAIS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Habilidade Especial',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.deepPurpleAccent),
                onPressed: () => DialogHelpers.editarTextoLongo(
                  context: context,
                  titulo: 'Habilidade Especial',
                  textoAtual: p.habilidadesEspeciais,
                  personagem: p,
                  onSave: (val) => p.habilidadesEspeciais = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => DialogHelpers.editarTextoLongo(
              context: context,
              titulo: 'Habilidade Especial',
              textoAtual: p.habilidadesEspeciais,
              personagem: p,
              onSave: (val) => p.habilidadesEspeciais = val,
              onUpdateTela: _atualizarTela,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
              ),
              child: Text(
                p.habilidadesEspeciais.isEmpty
                    ? 'Nenhuma habilidade especial. Clique para adicionar.'
                    : p.habilidadesEspeciais,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 24),

          // CAMPO DE INVENTÁRIO
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Inventário',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.deepPurpleAccent),
                onPressed: () => DialogHelpers.editarTextoLongo(
                  context: context,
                  titulo: 'Inventário',
                  textoAtual: p.inventario,
                  personagem: p,
                  onSave: (val) => p.inventario = val,
                  onUpdateTela: _atualizarTela,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () => DialogHelpers.editarTextoLongo(
              context: context,
              titulo: 'Inventário',
              textoAtual: p.inventario,
              personagem: p,
              onSave: (val) => p.inventario = val,
              onUpdateTela: _atualizarTela,
            ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2C2C2C),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.deepPurple.withOpacity(0.5)),
              ),
              child: Text(
                p.inventario.isEmpty
                    ? 'Inventário vazio. Clique para adicionar itens.'
                    : p.inventario,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
