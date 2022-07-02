import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/repository/pokemon_repository.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokemonRepository _pokemonRepository;

  PokemonBloc(this._pokemonRepository) : super(PokemonInitialState()) {
    on<PokemonEvent>((event, emit) async {
      if (event is LoadPokemonEvent) {
        emit(PokemonLoadingState());
        List<PokemonElement>? apiResult =
            await _pokemonRepository.getAllPokemons();
        if (apiResult == null) {
          emit(PokemonErrorState());
        } else {
          emit(PokemonLoadedState(apiResult: apiResult));
        }
      }
    });
  }
}
