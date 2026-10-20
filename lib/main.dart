import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const RihlaApp());
}

class RihlaApp extends StatelessWidget {
  const RihlaApp({super.key});

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
      title: 'Rihla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0E7C86)),
      ),
      home: HomeScreen(),
    );
  }
}
//Q1: l'avatar sera a coté de "ou parter vous ajourd'hui", expanded permet que la column prend le reste de la largeur donc le texte occupe tout l'espace libre
//Q2: car statelessWidget ne doit pas avoir des valeurs qui change aprés creation
//Q3: cs.primary suit la couleur de theme actuel, colors.teal reste fixe donc si on change le seedcolor, cs.primary change mais colors.teal reste le meme.
//Q4: le decoratedBox est derriere l'image parceque les premiers elements sont dessinées en bas et les derniers en haut
//Q5: le contenu depasse les bords de clipRRect
//Q6; right 130 reserve l'espace pour le bouton decouvrir
// Q7 : Expanded donne une largeur à la Row pour que Spacer pousse le prix à droite.
// Q8 : une seul entrée Destination dans destinations.dart suffit car la boucle for dans home_screen.dart
//Q9 : sans setState, la mise a jour quand on clique sur une categorie ne sera pas effectué bien que categorie change en memoire
//Q10 : _filtrees est recalculé a chaque build pour ne pas stocker une liste pour chaque categorie 
//Q11 : HeroBanner peut rester stateless car il n'effectue pas des setState(), il se reconstruit avec les données changée, pas plus.