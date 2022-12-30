import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokemon_detail_model.dart';
import 'package:pokedex/models/pokemon_list_model.dart';
import 'package:pokedex/shared/constants/api.dart';

class PokemonService {
  Future<PokemonListModel?> getPokemons(String offSet) async {
    Map<String, dynamic> params = {
      'offset': offSet,
      'limit': '20',
    };
    try {
      final url = Uri.http(
        Api.baseUrl,
        '${Api.apiVersion}${Api.pokemon}',
        params,
      );
      var response = await http.get(url);
      final result = PokemonListModel.fromJson(response.body);
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<PokemonDetailModel?> getPokemon(String number) async {
    try {
      final url = Uri.http(
        Api.baseUrl,
        '${Api.apiVersion}${Api.pokemon}/$number',
      );
      var response = await http.get(url);
      final result = PokemonDetailModel.fromJson(response.body);
      return result;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
