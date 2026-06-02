import 'package:flutter/material.dart';
import '../data/database_helper.dart';
import '../models/Personagem.dart';
import 'main_game_view.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Personagem> personagens = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // Sua excelente implementação para garantir a renderização segura!
    WidgetsBinding.instance.addPostFrameCallback((_) {
      atualizarLista();
    });
  }

  // Função que bate no SQLite e atualiza a tela
  Future<void> atualizarLista() async {
    final data = await DatabaseHelper.instance.getTodosPersonagens();
    setState(() {
      personagens = data;
      isLoading = false;
    });
  }

  // === ABRE A GALERIA E SALVA A FOTO ===
  Future<void> _escolherImagem(Personagem personagem) async {
    final ImagePicker picker = ImagePicker();
    
    // Abre a galeria para o jogador escolher a foto
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // Lê os bytes da imagem e converte para Base64
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      setState(() {
        personagem.fotoBase64 = base64Image;
      });

      // Salva no banco de dados e atualiza a tela
      await DatabaseHelper.instance.updatePersonagem(personagem);
      atualizarLista();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RpgNote - Meus Saves'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : personagens.isEmpty
          ? const Center(
              child: Text(
                'Nenhuma ficha encontrada.\nCrie seu primeiro personagem!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            )
          : ListView.builder(
              itemCount: personagens.length,
              itemBuilder: (context, index) {
                final personagem = personagens[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  elevation: 4,
                  color: const Color(0xFF2C2C2C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),


                    // === AVATAR ATUALIZADO  ===
                    
                    leading: InkWell(
                      onTap: () => _escolherImagem(personagem),
                      child: Stack(
                        alignment:
                            Alignment.bottomRight, 
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.deepPurple.withOpacity(0.3),
                            backgroundImage: personagem.fotoBase64.isNotEmpty
                                ? MemoryImage(
                                    base64Decode(personagem.fotoBase64),
                                  )
                                : null,
                            child: personagem.fotoBase64.isEmpty
                                ? Text(
                                    personagem.classe.isNotEmpty
                                        ? personagem.classe
                                              .substring(0, 1)
                                              .toUpperCase()
                                        : '?',
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : null,
                          ),
                          // Icone de câmera sobreposto a imagem
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.deepPurpleAccent,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    title: Text(
                      personagem.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        'PV: ${personagem.pvAtual}/${personagem.pvMax} | Classe: ${personagem.classe}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ),
                  
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                        size: 28,
                      ),
                      onPressed: () async {
                       
                        await DatabaseHelper.instance.deletePersonagem(
                          personagem.id!,
                        );
                        atualizarLista();

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${personagem.nome} foi deletado da campanha.',
                              ),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                        }
                      },
                    ),
                   
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              MainGameView(personagem: personagem),
                        ),
                      ).then((value) => atualizarLista());
                    },
                  ),
                );
              },
            ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor, 
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurpleAccent,
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            //Cria um "Personagem genérico"
            final novoPersonagem = Personagem(
              nome: 'Novo Aventureiro',
              classe: 'Sem Classe',
              raca: '', 
              idade: 0,
              altura: 0.0,
              peso: 0.0,
              forca: 10,
              destreza: 10,
              constuicao: 10,
              inteligencia: 10,
              sabedoria: 10,
              carisma: 10,
              pvMax: 10,
              pvAtual: 10,
              peMax: 5,
              peAtual: 5,
              classeArmadura: 10,
              xp: 1, 
              inventario: '',
              habilidadesEspeciais: '',
              fotoBase64: '',
            );

            // Salva no banco de dados silenciosamente e pega o ID gerado pelo SQLite
            final idGerado = await DatabaseHelper.instance.insertPersonagem(
              novoPersonagem,
            );
            novoPersonagem.id = idGerado;

            // Atualiza a lista da Home por trás dos panos
            atualizarLista();

            // Navega direto para a Ficha (MainGameView) passando o novo personagem como parâmetro!
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MainGameView(personagem: novoPersonagem),
                ),
              ).then((value) => atualizarLista());
            }
          },
          child: const Text(
            'Criar Personagem',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ), 
    );
  }
}
