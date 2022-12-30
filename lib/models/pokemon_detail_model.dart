// To parse this JSON data, do
//
//     final pokemonDetailModel = pokemonDetailModelFromMap(jsonString);

import 'dart:convert';

class PokemonDetailModel {
  PokemonDetailModel({
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.stats,
    required this.types,
    required this.weight,
  });

  final int baseExperience;
  final int height;
  final int id;
  final String locationAreaEncounters;
  final List<MoveElement> moves;
  final String name;
  final int order;
  final List<Stat> stats;
  final List<Type> types;
  final int weight;

  factory PokemonDetailModel.fromJson(String str) =>
      PokemonDetailModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonDetailModel.fromMap(Map<String, dynamic> json) =>
      PokemonDetailModel(
        baseExperience: json["base_experience"],
        height: json["height"],
        id: json["id"],
        locationAreaEncounters: json["location_area_encounters"],
        moves: List<MoveElement>.from(
            json["moves"].map((x) => MoveElement.fromMap(x))),
        name: json["name"],
        order: json["order"],
        stats: List<Stat>.from(json["stats"].map((x) => Stat.fromMap(x))),
        types: List<Type>.from(json["types"].map((x) => Type.fromMap(x))),
        weight: json["weight"],
      );

  Map<String, dynamic> toMap() => {
        "base_experience": baseExperience,
        "height": height,
        "id": id,
        "location_area_encounters": locationAreaEncounters,
        "moves": List<dynamic>.from(moves.map((x) => x.toMap())),
        "name": name,
        "order": order,
        "stats": List<dynamic>.from(stats.map((x) => x.toMap())),
        "types": List<dynamic>.from(types.map((x) => x.toMap())),
        "weight": weight,
      };
}

class MoveElement {
  MoveElement({
    required this.move,
  });

  final StatClass move;

  factory MoveElement.fromJson(String str) =>
      MoveElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MoveElement.fromMap(Map<String, dynamic> json) => MoveElement(
        move: StatClass.fromMap(json["move"]),
      );

  Map<String, dynamic> toMap() => {
        "move": move.toMap(),
      };
}

class StatClass {
  StatClass({
    required this.name,
    required this.url,
  });

  final String name;
  final String url;

  factory StatClass.fromJson(String str) => StatClass.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StatClass.fromMap(Map<String, dynamic> json) => StatClass(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "url": url,
      };
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  final int baseStat;
  final int effort;
  final StatClass stat;

  factory Stat.fromJson(String str) => Stat.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Stat.fromMap(Map<String, dynamic> json) => Stat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: StatClass.fromMap(json["stat"]),
      );

  Map<String, dynamic> toMap() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toMap(),
      };
}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  final int slot;
  final StatClass type;

  factory Type.fromJson(String str) => Type.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Type.fromMap(Map<String, dynamic> json) => Type(
        slot: json["slot"],
        type: StatClass.fromMap(json["type"]),
      );

  Map<String, dynamic> toMap() => {
        "slot": slot,
        "type": type.toMap(),
      };
}
