import 'package:flutter/material.dart';

class AlertDialogWidget {
  static AlertDialog alertSchedule(
    String title,
    List<Widget> children,
    List<Widget>? actions,
    BuildContext context,
  ) {
    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Text(
          title,
          style: const TextStyle(color: Colors.black),
          textAlign: TextAlign.center,
        ),
      ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: children,
        ),
      ),
      actions: actions,
      titlePadding: const EdgeInsets.all(0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
    );
  }
}
