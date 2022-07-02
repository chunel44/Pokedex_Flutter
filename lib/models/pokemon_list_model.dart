// To parse this JSON data, do
//
//     final listPokemons = listPokemonsFromJson(jsonString);

import 'dart:convert';

ListPokemons listPokemonsFromJson(String str) =>
    ListPokemons.fromJson(json.decode(str));

String listPokemonsToJson(ListPokemons data) => json.encode(data.toJson());

class ListPokemons {
  ListPokemons({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<SmallPokemon> results;

  factory ListPokemons.fromJson(Map<String, dynamic> json) => ListPokemons(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<SmallPokemon>.from(
            json["results"].map((x) => SmallPokemon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class SmallPokemon {
  final String name;
  final int id;

  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

  SmallPokemon({
    required this.name,
    required this.id,
  });

  factory SmallPokemon.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    final url = json['url'] as String;
    final id = int.parse(url.split('/')[6]);

    return SmallPokemon(
      name: name,
      id: id,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };

  SmallPokemon copyWith({
    String? name,
    int? id,
  }) {
    return SmallPokemon(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }
}
