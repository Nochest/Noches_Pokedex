import 'dart:convert';

import 'package:pokedex/models/pokemon_model.dart';

class PokemonListModel {
  PokemonListModel({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  final int count;
  final String? next;
  final String? previous;
  final List<PokemonModel> results;

  factory PokemonListModel.fromJson(String str) =>
      PokemonListModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonListModel.fromMap(Map<String, dynamic> json) =>
      PokemonListModel(
        count: json['count'],
        next: json['next'],
        previous: json['previous'],
        results: List<PokemonModel>.from(
            json['results'].map((x) => PokemonModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': List<dynamic>.from(results.map((x) => x.toMap())),
      };
}
