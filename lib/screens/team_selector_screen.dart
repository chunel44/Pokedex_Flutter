import 'package:flutter/material.dart';
import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_prueba__tecnica/bloc/bloc.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'package:pokedex_prueba__tecnica/utils/direction_pageu_route.dart';
import 'package:pokedex_prueba__tecnica/widgets/widgets.dart';

import 'package:pokedex_prueba__tecnica/utils/strings.dart';

class TeamSelectorScreen extends StatefulWidget {
  const TeamSelectorScreen({Key? key}) : super(key: key);

  @override
  State<TeamSelectorScreen> createState() => _TeamSelectorScreenState();
}

class _TeamSelectorScreenState extends State<TeamSelectorScreen> {
  final controller = DragSelectGridViewController();
  final txtController = TextEditingController();
  List<PokemonElement> selectedPokemons = [];

  @override
  void initState() {
    super.initState();
    controller.addListener(rebuild);
  }

  @override
  void dispose() {
    super.dispose();
    controller.removeListener(rebuild);
  }

  void rebuild() => setState(() {});

  @override
  Widget build(BuildContext context) {
    bool itemSelected = controller.value.isSelecting;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          itemSelected
              ? BlocBuilder<PokemonBloc, PokemonState>(
                  builder: (context, state) {
                    if (state is PokemonLoadedState) {
                      return IconButton(
                        onPressed: () async {
                          final selected = controller.value.selectedIndexes
                              .map((i) => state.apiResult[i])
                              .toList();

                          print(selected.length);

                          if (selected.length == 6) {
                            Navigator.of(context).push(
                              DirectionPageRoute(
                                  child:
                                      NameTeamScreen(selectedList: selected)),
                            );
                          } else {
                            const snackBar = SnackBar(
                              content: Text('Los equipos son de 6 Pokemones.'),
                              backgroundColor: Colors.red,
                            );
                            if (!mounted) return;
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }

                          // await alertNameTeams(
                          //   context,
                          //   selected,
                          //   txtController,
                          //   teamServices,
                          // );
                        },
                        icon: const Icon(Icons.done),
                      );
                    }
                    return Container();
                  },
                )
              : Container(),
        ],
        title: Text(
          itemSelected
              ? '${controller.value.amount} Selecionados'
              : 'Arma tu eqipo',
          style: const TextStyle(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<PokemonBloc, PokemonState>(
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

                  return DragSelectGridView(
                    gridController: controller,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.5,
                    ),
                    itemBuilder:
                        (BuildContext context, int index, bool selected) {
                      final PokemonElement pokemon = pokemons[index];
                      final type = pokemon.type[0]
                          .toString()
                          .characters
                          .toString()
                          .substring(5)
                          .toCapitalized();
                      return Stack(
                        children: [
                          CardPokemonWidget(
                            isRotate: false,
                            color: pokemon.baseColor ?? Colors.grey,
                            imgUrl: pokemon.imageUrl,
                            type: type,
                            name: pokemon.name,
                            heroTag: pokemon.name,
                            onTap: () {
                              print('object');
                            },
                          ),
                          Positioned(
                            right: 5,
                            top: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  width: selected ? 4 : 0,
                                  style: selected
                                      ? BorderStyle.solid
                                      : BorderStyle.none,
                                ),
                              ),
                              height: size.height * 0.155,
                              width: size.width * 0.48,
                            ),
                          )
                        ],
                      );
                      ;
                    },
                    itemCount: pokemons.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}
