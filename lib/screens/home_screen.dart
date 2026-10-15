import 'package:flutter/material.dart';

import '../data/destinations.dart';
import '../widgets/destination_card.dart';
import '../widgets/hero_banner.dart';
import '../widgets/home_header.dart';
import '../widgets/search_box.dart';
import '../widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            HomeHeader(prenom: 'Sami'),
            SearchBox(),
            SizedBox(height: 10),
            HeroBanner(destination: destinations.first),
            SectionTitle(title: 'Catégories'),
            SectionTitle(title: 'Populaires', action: 'Voir tout'),
            for (var d in destinations) DestinationCard(destination: d),
          ],
        ),
      ),
    );
  }
}
