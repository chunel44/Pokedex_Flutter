import 'package:flutter/material.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/widgets/widgets.dart';

import 'package:pokedex_prueba__tecnica/utils/strings.dart';

class MyTeamListScreen extends StatelessWidget {
  final List<PokemonElement> list;
  final String name;

  const MyTeamListScreen({Key? key, required this.list, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        title: Text(
          'Equipo: $name',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            GridView.builder(
              itemCount: list.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (_, index) {
                final PokemonElement pokemon = list[index];
                final type = pokemon.type[0]
                    .toString()
                    .characters
                    .toString()
                    .substring(5)
                    .toCapitalized();
                return CardPokemonWidget(
                  color: pokemon.baseColor ?? Colors.grey,
                  imgUrl: pokemon.imageUrl,
                  type: type,
                  name: pokemon.name,
                  heroTag: pokemon.name,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
