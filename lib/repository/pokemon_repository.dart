import 'dart:convert';

import 'package:pokedex_prueba__tecnica/models/pokemon_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/utils/consts.dart';

class PokemonRepository {
  Future<List<SmallPokemon>?> getPokemons() async {
    final response = await http.Client()
        .get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=151"));
    if (response.statusCode != 200) {
      return null;
    } else {
      final list = listPokemonsFromJson(response.body);
      final pokemonList = list.results;
      return pokemonList;
    }
  }

  Future<List<PokemonElement>?> getAllPokemons() async {
    final response = await http.get(Uri.parse(ApiConsts.allPokemonsURL));
    if (response.statusCode != 200) {
      return null;
    } else {
      final list = pokemonFromJson(response.body);
      final pokemonList = list.pokemon;
      return pokemonList;
    }
  }
}
