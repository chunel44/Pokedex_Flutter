import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex_prueba__tecnica/bloc/bloc.dart';
import 'package:pokedex_prueba__tecnica/screens/screens.dart';
import 'package:pokedex_prueba__tecnica/services/services.dart';
import 'package:pokedex_prueba__tecnica/utils/animation_page_route.dart';

class NavigationDrawerScreen extends StatefulWidget {
  const NavigationDrawerScreen({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerScreen> createState() => _NavigationDrawerScreenState();
}

class _NavigationDrawerScreenState extends State<NavigationDrawerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Duration duration = const Duration(milliseconds: 500);
  late Animation<double> scaleAnimation;

  bool drawerOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          const DrawerBody(),
          AnimatedPositioned(
            duration: duration,
            top: 0,
            bottom: 0,
            left: drawerOpen ? size.width * 0.55 : 0.0,
            right: drawerOpen ? size.width * -0.45 : 0.0,
            child: ScaleTransition(
              scale: scaleAnimation,
              child: GestureDetector(
                onTap: () {
                  if (drawerOpen) {
                    setState(() {
                      drawerOpen = false;
                      _animationController.reverse();
                    });
                  }
                },
                child: AbsorbPointer(
                  absorbing: drawerOpen,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(drawerOpen ? 50.0 : 0.0),
                    child: HomeScreen(
                      drawerCallback: () {
                        setState(() {
                          drawerOpen = true;
                          _animationController.forward();
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerBody extends StatefulWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  final teamServices = TeamServices();
  final storage = StorageServices();
  Map<String, dynamic> teams = {};
  String name = '';

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    teams = await teamServices.getTeams();
    name = await storage.getUser() ?? 'User';
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.only(
          left: 30,
          top: 30 * 2,
          bottom: 30 * 3,
        ),
        child: SizedBox(
          width: size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<UserBloc, UserState>(
                builder: (context, state) {
                  return Text(
                    'Hola ${state.name ?? name}!!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) =>
                    //                 const NavigationDrawerScreen()));
                    //   },
                    //   child: Row(
                    //     children: const [
                    //       Icon(
                    //         Icons.home_rounded,
                    //         color: Colors.yellow,
                    //       ),
                    //       SizedBox(
                    //         width: 10,
                    //       ),
                    //       Text(
                    //         'Home',
                    //         style: TextStyle(color: Colors.white),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          AnimationPageRoute(
                            widget: TeamsScreen(
                              teams: teams,
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.person_rounded,
                            color: Colors.yellow,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Equipos',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
