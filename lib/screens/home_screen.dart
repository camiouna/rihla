import 'package:flutter/material.dart';
import 'package:tp3/models/destination.dart';

import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/section_title.dart';
import '../services/api_service.dart';
class ErreurReseau extends StatelessWidget{
  final String message;
  final VoidCallback onRessayer;
  const ErreurReseau({super.key,required this.message,required this.onRessayer});
  @override 
  Widget build(BuildContext context){
    return Center(
      child: Column(
        children: [
          Icon(
            Icons.cloud_off,
            color: Theme.of(context).colorScheme.error,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(message, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          const Text('Vérifiez que json-server est lancé.'),
          const SizedBox(height: 12),
          FilledButton.tonalIcon(
            onPressed: onRessayer,
            icon: const Icon(Icons.refresh),
            label: const Text('Réessayer'),
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _categorie = 'Tout';
  int _onglet = 0;

  late Future<List<Destination>> _futurDestinations;

  @override
  void initState(){
    super.initState();
    _futurDestinations=ApiService.getDestinations();
  }
  List<Destination> _filtrer(List<Destination> toutes)=>_categorie=="Tout" ? toutes : toutes.where((d)=>d.categorie==_categorie).toList();
  Future<void> _recharger() async {
    final futur = ApiService.getDestinations();
    setState(() {
      _futurDestinations = futur;
    });
    try {
      await futur;
    } catch(_){

    }
  }

  Widget _construireExplorer(){
    return FutureBuilder<List<Destination>>(
      future: _futurDestinations, 
      builder: (context,snapshot){
      if (snapshot.connectionState==ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      if(snapshot.hasError){
        return ErreurReseau(
          message: 'Erreur de chargement des destinations.',
          onRessayer: _recharger,
        );
      }
      final destinations = snapshot.data!;
      return RefreshIndicator(
        onRefresh: _recharger,
        child: _construireAccueil(destinations)
      );
    });
  }
  Widget _construireAccueil(List<Destination> destinations){
    final filtrees=_filtrer(destinations);
    if (destinations.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 160),
          Center(child: Text('Aucune destination disponible.')),
        ],
      );
    }
      return ListView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                  for (final c in <String>{'Tout', ...destinations.map((d) => d.categorie)})
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
            for (final d in filtrees) DestinationCard(key: ValueKey(d.id),destination: d),
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
        child: _onglet==0? _construireExplorer():Text("bientot disponible"),
      ),
    );
  }
}
