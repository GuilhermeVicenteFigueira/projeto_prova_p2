import 'package:flutter/material.dart';

class Personagem {
  int? id;
  String nome;
  String classe;
  int idade;
  double altura;
  double peso;
  String raca;
  String fotoBase64;
  

// atributos
  int forca;
  int destreza;
  int constuicao;
  int inteligencia;
  int sabedoria;
  int carisma;

  // mecanicas
  int pvMax;
  int pvAtual;
  int peMax;
  int peAtual;
  int classeArmadura;
  int xp;

  String inventario;
  String habilidadesEspeciais;

  Personagem({
    this.id,
    required this.nome,
    required this.classe,
    required this.idade,
    required this.altura,
    required this.peso,
    required this.raca,
    required this.forca,
    required this.destreza,
    required this.constuicao,
    required this.inteligencia,
    required this.sabedoria,
    required this.carisma,
    required this.pvMax,
    required this.pvAtual,
    required this.peMax,
    required this.peAtual,
    required this.classeArmadura,
    required this.xp,
    required this.inventario,
    required this.habilidadesEspeciais,
    required this.fotoBase64,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'classe': classe,
      'idade': idade,
      'altura': altura,
      'fotoBase64': fotoBase64,
      'peso': peso,
      'raca': raca,
      'forca': forca,
      'destreza': destreza,
      'constuicao': constuicao,
      'inteligencia': inteligencia,
      'sabedoria': sabedoria,
      'carisma': carisma,
      'pvMax': pvMax,
      'pvAtual': pvAtual,
      'peMax': peMax,
      'peAtual': peAtual,
      'classeArmadura': classeArmadura,
      'xp': xp,
      'inventario': inventario,
      'habilidadesEspeciais': habilidadesEspeciais,
    };
  }

  factory Personagem.fromMap(Map<String, dynamic> map) {
    return Personagem(
      id: map['id'],
      nome: map['nome'],
      classe: map['classe'],
      idade: map['idade'],
      altura: map['altura'],
      peso: map['peso'],
      raca: map['raca'],
      forca: map['forca'],
      destreza: map['destreza'],
      constuicao: map['constuicao'],
      inteligencia: map['inteligencia'],
      sabedoria: map['sabedoria'],
      carisma: map['carisma'],
      pvMax: map['pvMax'],
      pvAtual: map['pvAtual'],
      peMax: map['peMax'],
      peAtual: map['peAtual'],
      classeArmadura: map['classeArmadura'],
      xp: map['xp'],
      inventario: map['inventario'],
      habilidadesEspeciais: map['habilidadesEspeciais'] ?? '',
      fotoBase64: map['fotoBase64'] ?? '',
    );
  }
}