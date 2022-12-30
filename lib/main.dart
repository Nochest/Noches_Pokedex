import 'package:flutter/material.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/shared/routes/routes.dart';
import 'package:pokedex/shared/theme/appTheme.dart';
import 'package:pokedex/views/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokemonProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokedex',
      theme: AppTheme.ligthTheme,
      initialRoute: HomePage.route,
      routes: AppRoutes.routes,
    );
  }
}
