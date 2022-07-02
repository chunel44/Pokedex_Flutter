import 'package:flutter/material.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'package:pokedex_prueba__tecnica/utils/direction_pageu_route.dart';
import 'package:pokedex_prueba__tecnica/widgets/widgets.dart';

import '../services/team_services.dart';
import 'package:pokedex_prueba__tecnica/utils/strings.dart';

class TeamsScreen extends StatefulWidget {
  final Map<String, dynamic> teams;
  const TeamsScreen({Key? key, required this.teams}) : super(key: key);

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  final teamServices = TeamServices();
  Map<String, dynamic> teams = {};
  @override
  void initState() {
    super.initState();
    teams = widget.teams;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Mis Equipos',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment:
            teams.isEmpty ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          teams.isEmpty
              ? const Center(
                  child: Text(
                  'No hay ningun Equipo :(',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ))
              : ListView.builder(
                  itemCount: teams.length,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String name = teams.keys.elementAt(index);
                    List<PokemonElement> pokemonList =
                        List<PokemonElement>.from(
                            teams[name].map((i) => PokemonElement.fromJson(i)));
                    if (teams.isEmpty) {
                      return const Center(
                        child: CustomLoader(),
                      );
                    } else {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.red,
                          child: Text(
                            name.substring(0, 2).toUpperCase(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        title: Text(
                          name.toCapitalized(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_outlined),
                        onTap: () {
                          Navigator.of(context).push(
                            DirectionPageRoute(
                              child: MyTeamListScreen(
                                  list: pokemonList, name: name),
                            ),
                          );
                        },
                      );
                    }
                  },
                )
        ],
      ),
    );
  }
}
