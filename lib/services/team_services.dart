import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';

class TeamServices {
  late List<Map<String, List<PokemonElement>>> teamsItems;

  late final FlutterSecureStorage storage;

  TeamServices() {
    storage = const FlutterSecureStorage();
  }

  setTeams({
    required String name,
    required List<PokemonElement> selected,
  }) async {
    final getData = await getTeams();
    if (getData.isEmpty) {
      Map<String, List<PokemonElement>> map = {name: selected};
      await storage.write(key: 'teams', value: json.encode(map));
    } else {
      Map<String, dynamic> map = getData;
      map.addAll({name: selected});
      await storage.write(key: 'teams', value: json.encode(map));
    }
  }

  Future<Map<String, dynamic>> getTeams() async {
    final getData = await storage.read(key: 'teams');
    return json.decode(getData ?? '{}');
  }
}
