import 'package:flutter/material.dart';

class WorkMode extends StatelessWidget {
  const WorkMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Work Mode Activated",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
