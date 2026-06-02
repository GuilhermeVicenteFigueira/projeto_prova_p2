import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/Personagem.dart';
import '../models/Anotacao.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('rpgnote.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Criando a Tabela de Personagens com os seus campos exatos
    await db.execute('''
      CREATE TABLE personagens (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT, classe TEXT, idade INTEGER, altura REAL, peso REAL,
        forca INTEGER, destreza INTEGER, constuicao INTEGER,
        inteligencia INTEGER, sabedoria INTEGER, carisma INTEGER,
        pvMax INTEGER, pvAtual INTEGER, peMax INTEGER,
        peAtual INTEGER, classeArmadura INTEGER, xp INTEGER,
        inventario TEXT, habilidadesEspeciais TEXT, raca TEXT, fotoBase64 TEXT
      )
    ''');

    // Criando a Tabela de Anotações com os seus campos exatos
    await db.execute('''
      CREATE TABLE anotacoes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        personagemId INTEGER,
        anotacaoMainQuest TEXT,
        anotacaoSideQuest TEXT,
        anotacaoNPC TEXT,
        anotacaoLore TEXT,
        FOREIGN KEY (personagemId) REFERENCES personagens (id) ON DELETE CASCADE
      )
    ''');
  }

  // --- Funções do Personagem ---
  Future<int> insertPersonagem(Personagem personagem) async {
    final db = await instance.database;
    return await db.insert('personagens', personagem.toMap());
  }

  Future<List<Personagem>> getTodosPersonagens() async {
    final db = await instance.database;
    final result = await db.query('personagens');
    return result.map((json) => Personagem.fromMap(json)).toList();
  }

  Future<int> updatePersonagem(Personagem personagem) async {
    final db = await instance.database;
    return await db.update(
      'personagens',
      personagem.toMap(),
      where: 'id = ?',
      whereArgs: [personagem.id],
    );
  }

  Future<int> deletePersonagem(int id) async {
    final db = await instance.database;

    await db.delete(
      'anotacoes',
      where: 'personagemId = ?',
      whereArgs: [id],
    );

    return await db.delete(
      'personagens',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // --- Funções da Anotação ---
  Future<int> insertAnotacao(Anotacao anotacao) async {
    final db = await instance.database;
    return await db.insert('anotacoes', anotacao.toMap());
  }

  Future<Anotacao?> getAnotacaoDoPersonagem(int personagemId) async {
    final db = await instance.database;
    final result = await db.query(
      'anotacoes',
      where: 'personagemId = ?',
      whereArgs: [personagemId],
    );
    if (result.isNotEmpty) {
      return Anotacao.fromMap(result.first);
    }
    return null;
  }

  Future<int> updateAnotacao(Anotacao anotacao) async {
    final db = await instance.database;
    return await db.update(
      'anotacoes',
      anotacao.toMap(),
      where: 'id = ?',
      whereArgs: [anotacao.id],
    );
  }
}