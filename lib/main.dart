import 'package:flutter/material.dart';
import 'views/home_view.dart'; 

void main() {
  runApp(const RpgNote());
}

class RpgNote extends StatelessWidget {
  const RpgNote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RpgNote',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Um tema escuro com tons de roxo para dar uma estética de RPG
        brightness: Brightness.dark,
        primaryColor: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFF1E1E1E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            borderSide: BorderSide.none,
          ),
        ),
      
      ),
      home: HomeView(), // Define a tela de seleção de saves como a tela inicial
    );
  }
}