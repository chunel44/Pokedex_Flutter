import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_prueba__tecnica/bloc/bloc.dart';
import 'package:pokedex_prueba__tecnica/repository/repository.dart';
import 'package:pokedex_prueba__tecnica/services/services.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';

String? init;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storage = StorageServices();
  init = await storage.getPage();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(
          create: (_) => PokemonBloc(PokemonRepository()),
        ),
        BlocProvider<UserBloc>(create: (_) => UserBloc()),
      ],
      child: MaterialApp(
        title: 'Pokedex',
        debugShowCheckedModeBanner: false,
        home: init == '0' || init == null
            ? const WelcomeScreen()
            : const NavigationDrawerScreen(),
        theme: ThemeData(fontFamily: 'CircularStd'),
      ),
    );
  }
}
