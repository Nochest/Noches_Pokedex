import 'package:flutter/material.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/shared/constants/api.dart';
import 'package:provider/provider.dart';

class PokemonDetailPage extends StatefulWidget {
  const PokemonDetailPage({Key? key}) : super(key: key);
  static const route = 'pokemon_detail_page';
  @override
  State<PokemonDetailPage> createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> {
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(pokemonProvider.currentPokemon!.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.red.shade500,
                        Colors.amber.shade500,
                      ],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: FadeInImage.assetNetwork(
                        width: MediaQuery.of(context).size.height / 2.5,
                        height: MediaQuery.of(context).size.height / 2.5,
                        fit: BoxFit.cover,
                        placeholder: 'assets/loading.gif',
                        image:
                            '${Api.imageProvider}${pokemonProvider.currentPokemon!.id.toString()}.png',
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Types',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...pokemonProvider.currentPokemon!.types.map(
                    (e) => Text(
                      e.type.name,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                'Stats',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Column(
                children: [
                  ...pokemonProvider.currentPokemon!.stats.map((e) => Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                e.stat.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Spacer(),
                              Container(
                                alignment: Alignment.centerRight,
                                padding: const EdgeInsets.only(right: 8),
                                height: 16,
                                width: (e.baseStat / 100.0) * 100,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  e.baseStat.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
