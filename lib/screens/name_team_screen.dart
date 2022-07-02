import 'package:flutter/material.dart';
import 'package:pokedex_prueba__tecnica/models/pokemon_model.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'package:pokedex_prueba__tecnica/services/services.dart';

class NameTeamScreen extends StatefulWidget {
  final List<PokemonElement> selectedList;

  const NameTeamScreen({Key? key, required this.selectedList})
      : super(key: key);

  @override
  State<NameTeamScreen> createState() => _NameTeamScreenState();
}

class _NameTeamScreenState extends State<NameTeamScreen> {
  final _controller = TextEditingController();

  bool _validate = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final teamServices = TeamServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.grey[50],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(top: size.height * 0.15),
                child: Image.asset(
                  'assets/evee.gif',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: size.width * 0.1,
                right: size.width * 0.1,
                bottom: size.height * 0.05,
                top: size.height * 0.02,
              ),
              child: const Text(
                'Nombre del Equipo:',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: TextField(
                autofocus: true,
                controller: _controller,
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.black),
                  focusColor: Colors.black,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  filled: true,
                  labelText: 'Ejmplo: Halo',
                  errorText: _validate ? 'Esribe el nombre del Equipo' : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async {
                    setState(() {
                      _controller.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                    });

                    if (_controller.text.isEmpty) {
                      return;
                    }

                    await teamServices.setTeams(
                        name: _controller.text, selected: widget.selectedList);
                    const snackBar = SnackBar(
                      content: Text('Equipo Agregado!'),
                    );
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NavigationDrawerScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save),
                  label: const Text('Guardar Equipo'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String? get _errorText {
    final text = _controller.value.text;

    if (text.isEmpty) {
      return 'Esribe el nombre del Equipo';
    }
    if (text.length < 4) {
      return 'El nombre debe tener al menos 4 letras';
    }
    // return null if the text is valid
    return null;
  }
}
