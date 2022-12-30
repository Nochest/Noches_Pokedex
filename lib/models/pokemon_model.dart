import 'dart:convert';

class PokemonModel {
  PokemonModel({
    required this.name,
    required this.url,
    this.favorite = false,
  });

  final String name;
  final String url;
  bool favorite;

  factory PokemonModel.fromJson(String str) =>
      PokemonModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PokemonModel.fromMap(Map<String, dynamic> json) => PokemonModel(
        name: json['name'],
        url: json['url'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'url': url,
      };
}
