import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/utils/utils.dart';
import 'package:pokedex_prueba__tecnica/utils/strings.dart';

class DetailScreen extends StatelessWidget {
  final String heroTag;
  final PokemonElement pokemon;
  final Color color;

  const DetailScreen({
    Key? key,
    required this.heroTag,
    required this.pokemon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: color,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 0,
              left: 5,
              child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pokemon.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "#${pokemon.num}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            Positioned(
              top: height * 0.10,
              right: -30,
              child: Transform.rotate(
                angle: Util.next(0, 360) * 3.1415 / 180,
                child: Image.asset(
                  'assets/pokeball.png',
                  height: 200,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                width: width,
                height: height * 0.6,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: const Text(
                                'Name',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17),
                              ),
                            ),
                            Text(
                              pokemon.name,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: const Text(
                                'Height',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17),
                              ),
                            ),
                            Text(
                              pokemon.height,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: const Text(
                                'Weight',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17),
                              ),
                            ),
                            Text(
                              pokemon.weight,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.3,
                              child: const Text(
                                'Spawn Time',
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 17),
                              ),
                            ),
                            Text(
                              pokemon.spawnTime,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    width: width * 0.3,
                                    child: const Text(
                                      'Weakness',
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 17),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: SizedBox(
                                    width: width * 0.3,
                                    child: const Text(
                                      'Types',
                                      style: TextStyle(
                                          color: Colors.blueGrey, fontSize: 17),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: pokemon.weaknesses.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          pokemon.weaknesses[index].name
                                              .toCapitalized(),
                                          style: TextStyle(
                                              color: PokemonElement.color(
                                                      type: pokemon
                                                          .weaknesses[index]
                                                          .name
                                                          .toCapitalized()) ??
                                                  Colors.grey,
                                              fontSize: 17),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Flexible(
                                  child: ListView.builder(
                                    itemCount: pokemon.type.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          pokemon.type[index].name
                                              .toCapitalized(),
                                          style: TextStyle(
                                              color: PokemonElement.color(
                                                      type: pokemon
                                                          .type[index].name
                                                          .toCapitalized()) ??
                                                  Colors.grey,
                                              fontSize: 17),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       SizedBox(
                      //         width: width * 0.3,
                      //         child: const Text('Pre Evolution', style: TextStyle(color: Colors.blueGrey, fontSize: 17),),
                      //       ),
                      //       Container(
                      //           child: widget.pokemonDetail['prev_evolution'] != null ?
                      //           SizedBox(
                      //             height: 20,
                      //             width: width * 0.55,
                      //             child: ListView.builder(
                      //               scrollDirection: Axis.horizontal,
                      //               itemCount: widget.pokemonDetail['prev_evolution'].length,
                      //               itemBuilder: (context, index){
                      //                 return Padding(
                      //                   padding: const EdgeInsets.only(left:8.0),
                      //                   child: Text(widget.pokemonDetail['prev_evolution'][index]['name'], style: TextStyle(color: Colors.black, fontSize: 17),),
                      //                 );
                      //               },
                      //             ),
                      //           ): Text("Just Hatched", style: TextStyle(color: Colors.black, fontSize: 17),)
                      //       ),

                      //     ],
                      //   ),
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Row(
                      //     children: [
                      //       Container(
                      //         width: width * 0.3,
                      //         child: Text('Next Evolution', style: TextStyle(color: Colors.blueGrey, fontSize: 17),),
                      //       ),
                      //       Container(
                      //         child: widget.pokemonDetail['next_evolution'] != null ?
                      //             SizedBox(
                      //               height: 20,
                      //               width: width * 0.55,
                      //               child: ListView.builder(
                      //                 scrollDirection: Axis.horizontal,
                      //                 itemCount: widget.pokemonDetail['next_evolution'].length,
                      //                 itemBuilder: (context, index){
                      //                   return Padding(
                      //                     padding: const EdgeInsets.only(right:8.0),
                      //                     child: Text(widget.pokemonDetail['next_evolution'][index]['name'], style: TextStyle(color: Colors.black, fontSize: 17),),
                      //                   );
                      //                 },
                      //               ),
                      //             ): Text("Maxed Out", style: TextStyle(color: Colors.black, fontSize: 17),)
                      //       ),

                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: (height * 0.08),
              left: (width / 2) - 150,
              child: Hero(
                tag: heroTag,
                child: CachedNetworkImage(
                  height: 300,
                  imageUrl: pokemon.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
