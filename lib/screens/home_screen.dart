import 'package:flutter/material.dart';
import 'package:tp3/models/destination.dart';

import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = 'Tout';
  int _onglet = 0;

  List<Destination> get _filtrees {
    if (_categorie == 'Tout') {
      return destinations;
    }

    return destinations
        .where((destination) => destination.categorie == _categorie)
        .toList();
  }
  Widget _construireAccueil(){
      return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            HomeHeader(prenom: 'Sami'),
            SearchBox(),
            const SizedBox(height: 10),
            HeroBanner(destination: destinations.first),
            SectionTitle(title: 'Catégories'),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final c in categories)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(c),
                        // TODO 2 : vrai seulement pour la catégorie choisie.
                        selected: _categorie == c,
                        onSelected: (_) {
                          // TODO 3 : mémoriser la catégorie choisie avec setState.
                          setState(() {
                            _categorie = c;
                          });
                        },
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SectionTitle(title: 'Populaires', action: 'Voir tout'),
            for (var d in _filtrees) DestinationCard(key: ValueKey(d.nom),destination: d),
          ],
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(icon: Icon(Icons.explore),label:"explore"),
        NavigationDestination(icon: Icon(Icons.favorite),label:"favorited"),
        NavigationDestination(icon: Icon(Icons.person),label:"profile"),
      ],onDestinationSelected: (selectedIndex) {
        setState(() {
          _onglet = selectedIndex;
        });
      },
      ),
      body: SafeArea(
        child: _onglet==0? _construireAccueil():Center(child:Text("Bientot disponible")),
      ),
    );
  }
}
