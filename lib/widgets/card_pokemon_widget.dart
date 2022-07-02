import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokedex_prueba__tecnica/utils/utils.dart';

class CardPokemonWidget extends StatelessWidget {
  final Color color;
  final String imgUrl;
  final String type;
  final String name;
  final String heroTag;
  final bool isRotate;
  final Function()? onTap;
  const CardPokemonWidget({
    Key? key,
    required this.color,
    required this.imgUrl,
    required this.type,
    required this.name,
    required this.heroTag,
    this.onTap,
    this.isRotate = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: InkWell(
        onTap: onTap,
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: -10,
                  right: -10,
                  child: Transform.rotate(
                    angle: isRotate ? Util.next(0, 360) * math.pi / 180 : 0.0,
                    child: Image.asset(
                      'assets/pokeball.png',
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Hero(
                    tag: heroTag,
                    child: CachedNetworkImage(
                      imageUrl: imgUrl,
                      height: 100,
                      fit: BoxFit.fitHeight,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 55,
                  left: 15,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.black.withOpacity(0.5)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10.0,
                        right: 10,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(color: Colors.white, shadows: [
                          BoxShadow(
                              color: Colors.blueGrey,
                              offset: Offset(0, 0),
                              spreadRadius: 1.0,
                              blurRadius: 15)
                        ]),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 15,
                  child: Text(
                    name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                        shadows: [
                          BoxShadow(
                              color: Color.fromARGB(255, 0, 0, 0),
                              offset: Offset(0, 0),
                              spreadRadius: 1.0,
                              blurRadius: 15)
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
