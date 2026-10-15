import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String prenom;

  const HomeHeader({
    super.key,
    required this.prenom,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ahlan, $prenom',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Où partez-vous aujourd'hui ?",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 26,
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            prenom[0].toUpperCase(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ),
      ],
    );
  }
}

//Q1: l'avatar sera a coté de "ou parter vous ajourd'hui", expanded permet que la column prend le reste de la largeur donc le texte occupe tout l'espace libre
//Q2: car statelessWidget ne doit pas avoir des valeurs qui change aprés creation
//Q3: cs.primary suit la couleur de theme actuel, colors.teal reste fixe donc si on change le seedcolor, cs.primary change mais colors.teal reste le meme.
