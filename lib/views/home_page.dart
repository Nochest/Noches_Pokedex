import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon_model.dart';
import 'package:pokedex/providers/pokemon_provider.dart';
import 'package:pokedex/shared/constants/api.dart';
import 'package:pokedex/views/pokemon_detail_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);
  static const route = 'home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  void getInitData() async {
    final pokemonProvider = Provider.of<PokemonProvider>(
      context,
      listen: false,
    );
    if (pokemonProvider.pokemons.isEmpty) await pokemonProvider.getPokemons();
    setState(() {});
  }

  void getNext() {
    final pokemonProvider = Provider.of<PokemonProvider>(
      context,
      listen: false,
    );
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        pokemonProvider.getPokemons();
      }
    });
  }

  @override
  void initState() {
    getInitData();
    getNext();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      pokemonProvider.showFavorites =
                          !pokemonProvider.showFavorites;
                    });
                  },
                  child: pokemonProvider.showFavorites
                      ? Icon(Icons.cancel)
                      : Icon(
                          Icons.favorite_sharp,
                        ),
                )
              ],
            ),
          ),
        ],
      ),
      body: pokemonProvider.showFavorites &&
              pokemonProvider.favoritePokemons.isEmpty
          ? Center(
              child: Text('No hay pokemones en la lista de favoritos'),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              controller:
                  pokemonProvider.showFavorites ? null : scrollController,
              itemBuilder: (context, i) => PokemonCard(
                pokemon: pokemonProvider.showFavorites
                    ? pokemonProvider.favoritePokemons[i]
                    : pokemonProvider.pokemons[i],
              ),
              separatorBuilder: (_, __) => SizedBox(
                height: 8,
              ),
              itemCount: pokemonProvider.showFavorites
                  ? pokemonProvider.favoritePokemons.length
                  : pokemonProvider.pokemons.length,
            ),
    );
  }
}

class PokemonCard extends StatefulWidget {
  const PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);
  final PokemonModel pokemon;

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  Widget build(BuildContext context) {
    final pokemonProvider = Provider.of<PokemonProvider>(context);
    final number = widget.pokemon.url.split('/')[6];
    return Material(
      elevation: 2,
      shadowColor: Colors.blueGrey,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: ListTile(
        onTap: () async {
          await pokemonProvider.getCurrentPokemon(number).then(
              (value) => Navigator.pushNamed(context, PokemonDetailPage.route));
        },
        leading: ClipOval(
          child: FadeInImage.assetNetwork(
            width: 48,
            height: 48,
            fit: BoxFit.cover,
            placeholder: 'assets/loading.gif',
            image: '${Api.imageProvider}$number.png',
          ),
        ),
        title: Text(
          widget.pokemon.name,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(widget.pokemon.url),
        trailing: IconButton(
            onPressed: () {
              setState(() {
                widget.pokemon.favorite = !widget.pokemon.favorite;
                if (widget.pokemon.favorite) {
                  pokemonProvider.favoritePokemons.add(widget.pokemon);
                } else {
                  pokemonProvider.favoritePokemons.remove(widget.pokemon);
                }
              });
            },
            icon: Icon(
              widget.pokemon.favorite ? Icons.favorite : Icons.favorite_border,
              color: widget.pokemon.favorite ? Colors.red : Colors.grey,
            )),
      ),
    );
  }
}
