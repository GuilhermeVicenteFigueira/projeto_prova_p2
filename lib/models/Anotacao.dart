class Anotacao {
  int? id;
  int personagemId; // O link com o personagem dono da anotação
  String anotacaoMainQuest;
  String anotacaoSideQuest;
  String anotacaoNPC;
  String anotacaoLore;

  // Construtor adicionado
  Anotacao({
    this.id,
    required this.personagemId,
    required this.anotacaoMainQuest,
    required this.anotacaoSideQuest,
    required this.anotacaoNPC,
    required this.anotacaoLore,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'personagemId': personagemId,
      'anotacaoMainQuest': anotacaoMainQuest,
      'anotacaoSideQuest': anotacaoSideQuest,
      'anotacaoNPC': anotacaoNPC,
      'anotacaoLore': anotacaoLore,
    };
  }
  
  factory Anotacao.fromMap(Map<String, dynamic> map) {
    return Anotacao(
      id: map['id'],
      personagemId: map['personagemId'],
      anotacaoMainQuest: map['anotacaoMainQuest'],
      anotacaoSideQuest: map['anotacaoSideQuest'],
      anotacaoNPC: map['anotacaoNPC'],
      anotacaoLore: map['anotacaoLore'],
    );
  }
}