import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget {
  final VoidCallback? drawerCallback;
  const CustomAppBar({Key? key, required this.drawerCallback})
      : super(key: key);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.15,
      padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: widget.drawerCallback,
            child: const Icon(
              Icons.short_text_rounded,
              color: Colors.black,
              size: 25,
            ),
          ),
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                    text: 'POKEDEX',
                    style: TextStyle(
                      color: Colors.red,
                    )),
                TextSpan(
                    text: '.',
                    style: TextStyle(
                      color: Colors.white,
                    )),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
