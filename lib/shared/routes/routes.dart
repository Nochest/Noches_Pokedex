import 'package:flutter/cupertino.dart';
import 'package:pokedex/views/home_page.dart';
import 'package:pokedex/views/pokemon_detail_page.dart';

class AppRoutes {
  AppRoutes._();

  static final routes = <String, WidgetBuilder>{
    HomePage.route: (_) => HomePage(),
    PokemonDetailPage.route: (_) => PokemonDetailPage(),
  };
}
