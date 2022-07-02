import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_prueba__tecnica/bloc/pokemon/pokemon_bloc.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'dart:math' as math;

import 'package:pokedex_prueba__tecnica/widgets/widgets.dart';

import 'package:pokedex_prueba__tecnica/utils/strings.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback? drawerCallback;
  const HomeScreen({Key? key, required this.drawerCallback}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: const FloatingButtonWidget(),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: -50,
            right: -50,
            child: Transform.rotate(
              angle: 25 * math.pi / 180,
              child: Image.asset(
                'assets/pokeball.png',
                width: 200,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppBar(
                drawerCallback: widget.drawerCallback,
              ),
            ],
          ),
          Positioned(
            top: 100,
            bottom: 0,
            width: width,
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<PokemonBloc, PokemonState>(
                    builder: (context, state) {
                      if (state is PokemonInitialState) {
                        context.read<PokemonBloc>().add(LoadPokemonEvent());
                        return const CustomLoader();
                      } else if (state is PokemonLoadingState) {
                        return const CustomLoader();
                      } else if (state is PokemonErrorState) {
                        return const Center(
                          child: Text("Algo salio mal!! 😭"),
                        );
                      } else if (state is PokemonLoadedState) {
                        final pokemons = state.apiResult;

                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                          ),
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: pokemons.length,
                          itemBuilder: (context, index) {
                            final PokemonElement pokemon = pokemons[index];
                            final type = pokemon.type[0]
                                .toString()
                                .characters
                                .toString()
                                .substring(5)
                                .toCapitalized();
                            return CardPokemonWidget(
                              color: pokemon.baseColor ?? Colors.grey,
                              imgUrl: pokemon.imageUrl,
                              type: type,
                              name: pokemon.name,
                              heroTag: pokemon.name,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailScreen(
                                      heroTag: pokemon.name,
                                      color: pokemon.baseColor ?? Colors.grey,
                                      pokemon: pokemon,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }
                      return const Text('Error!!');
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}


/**
 * GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                    ),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    children: const [
                      CardPokemonWidget(
                        color: Colors.amberAccent,
                        imgUrl:
                            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png',
                        type: 'Electric',
                        name: 'Mew',
                      ),
                    ],
                  ),
 */