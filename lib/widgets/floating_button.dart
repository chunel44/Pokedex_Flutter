import 'package:flutter/material.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'package:pokedex_prueba__tecnica/utils/direction_pageu_route.dart';

class FloatingButtonWidget extends StatelessWidget {
  const FloatingButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context)
            .push(DirectionPageRoute(child: const InfoTeamsScreen()));
      },
      backgroundColor: Colors.red,
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
