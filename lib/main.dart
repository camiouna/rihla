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


//TP4
//Q1 : le filtre est conservé,l'ecran de detail est au dessus de la page d'acceuil donc la page d'acceuil reste en memoire mais dessous la page detail
//Q2 : c'est le passage de données a un ecran via son constructeur
//Q3 : sans clip behvaiour, on peut cliquer a l'espace arrondis donc clip behaviour coupe le contenu des coins pour que l'effet de touche est sous la forme de la carte
//palier 3:
//Q1 : elle demande au form d'executer le validator de chaque champ et d'afficher les erreurs si ils existent puis donne true si tous les tests sont validées sinon false
//Q2 : ils agissent pendant la saisie pour filtrer/limiter les caracteres saisies
//Q3 : dispose sert a nettoyer les controleurs quand on quitte l'ecran pour ne pas garder en memoire des objets dont on n'a plus besoin.
 //palier 4:
 //Q1 : the champ date est en readonly pour empecher la saisie au clavier, sans readonly on peut taper une date sans le datetimepicker
 //Q2 : _total est une valeur calculé a partir d'une formule,le getter recalcule sa valeur chaque fois qu'on le lit
 //palier 5:
 //Q1: aucune reservation va etre envoyée (reservation va etre envoyée null a detail screen) car lobjet n'est oas crée qu'apres validation du formulaire
 //Q2: vscode signale que la buildContext ne doit pas etre utilisé apres une operation asynchrone, mounted permet de verifier que lécran existe encore avant d'utiliser son contexte pour afficher la boite de dialogue
 //Q3: une boite de dialogue est elle aussi une route affichée au dessus de l'ecran courant

 //TP5
 //Q1 : elle renvoie 404 qui est la famille des erreurs de client
 //Q2 : le serveur
 //Q3 :  car le get recupere de données seulement, il n'envoie rien
 //palier 2:
 //Q1: fromJson est un constructeur factory car il cree et renvoie un objet destination a partir des donées json
 //Q2: on aura un erreur car prix est declarée "as int", vu que "420" est une chaine
 //Q3: getDestination fair une requete http qui prend du temps c'est pour ca qu'on a utilisé await pour attendre la resultat
 //palier 3:
 //Q1: late permet que futurdestination peut etre crée sans prendre une valeur immediatement
 //Q2: sans le test snapshop.haserror on n'aurons pas un message d'erreur affiché mais on aurons un erreur d'execution a snapshot.data!
 //Q3: non la changement de categorie seulement met a joir _categorie avec setstate puis filtrer les destinations avec _filtrer, la requete se relance seulement dans initState et a nouveau lors d'un refresh 
 