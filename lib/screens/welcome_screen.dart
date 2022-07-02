import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_prueba__tecnica/bloc/bloc.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'package:pokedex_prueba__tecnica/services/storage_services.dart';
import 'package:pokedex_prueba__tecnica/ui/ui.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  TextEditingController nameTextField = TextEditingController();
  bool _isValidate = false;

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.redAccent,
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/pokedex.png'),
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(
              top: size.height * 0.05,
              left: size.width * 0.1,
              right: size.width * 0.1,
            ),
            child: const Text(
              'Hola Bienvenido a Pokedex, la app para saber todo acera de la 1ra generación de Pokemon\'s',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.05, vertical: 25),
              child: Column(
                children: [
                  textFieldName(),
                  const Spacer(),
                  IconButton(
                    onPressed: () async {
                      setState(() {
                        nameTextField.text.isEmpty
                            ? _isValidate = true
                            : _isValidate = false;
                      });
                      if (nameTextField.text.isEmpty) {
                        return;
                      }
                      userBloc.add(ActivateNameUser(nameTextField.text));
                      final storage = StorageServices();
                      await storage.setPage();
                      if (!mounted) return;

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NavigationDrawerScreen()));
                    },
                    icon: const Icon(Icons.navigate_next_outlined),
                    color: Global.electricColor,
                    iconSize: 50,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  TextField textFieldName() {
    return TextField(
      controller: nameTextField,
      style: const TextStyle(
          color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.white),
        focusColor: Colors.white,
        filled: true,
        errorText: _isValidate ? 'Escribe tu nombre' : null,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.white),
        ),
        labelText: 'Escribe tu nombre para Continuar',
      ),
    );
  }
}
