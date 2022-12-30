import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_detail_model.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/services/pokemon_service.dart';

class PokemonProvider extends ChangeNotifier {
  int _offSet = 0;
  int get offSet => _offSet;
  set offSet(int value) {
    _offSet = value;
    notifyListeners();
  }

  bool _showFavorites = false;
  bool get showFavorites => _showFavorites;
  set showFavorites(bool value) {
    _showFavorites = value;
    notifyListeners();
  }

  List<PokemonModel> _pokemons = [];
  List<PokemonModel> get pokemons => _pokemons;
  set pokemons(List<PokemonModel> value) {
    _pokemons = value;
    notifyListeners();
  }

  List<PokemonModel> _favoritePokemons = [];
  List<PokemonModel> get favoritePokemons => _favoritePokemons;
  set favoritePokemons(List<PokemonModel> value) {
    _favoritePokemons = value;
    notifyListeners();
  }

  PokemonDetailModel? _currentPokemon;
  PokemonDetailModel? get currentPokemon => _currentPokemon;
  set currentPokemon(PokemonDetailModel? value) {
    _currentPokemon = value;
    notifyListeners();
  }

  Future<void> getPokemons() async {
    try {
      final result = await PokemonService().getPokemons(offSet.toString());
      if (result!.results.isNotEmpty) {
        _pokemons.addAll(result.results);
        offSet += 20;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCurrentPokemon(String number) async {
    try {
      final result = await PokemonService().getPokemon(number);
      if (result != null) {
        _currentPokemon = result;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
}
