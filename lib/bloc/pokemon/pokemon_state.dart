part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  const PokemonState();

  @override
  List<Object> get props => [];
}

class PokemonInitialState extends PokemonState {}

class PokemonLoadingState extends PokemonState {}

class PokemonLoadedState extends PokemonState {
  final List<PokemonElement> apiResult;
  const PokemonLoadedState({
    required this.apiResult,
  });
}

class PokemonErrorState extends PokemonState {}
