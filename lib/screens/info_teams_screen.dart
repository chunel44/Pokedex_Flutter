import 'package:flutter/material.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'package:pokedex_prueba__tecnica/utils/direction_pageu_route.dart';

class InfoTeamsScreen extends StatelessWidget {
  const InfoTeamsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: size.height * 0.2),
                child: Image.asset(
                  'assets/pokedex_icon.png',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: size.width * 0.1, right: size.width * 0.1, top: 30),
              child: const Text(
                'Crea un Team de 6 Pokemones y guardalo en la app',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    DirectionPageRoute(
                      child: const TeamSelectorScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_back_sharp),
                label: const Text('Comenzar'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
