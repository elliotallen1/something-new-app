import 'package:flutter/material.dart';

enum Faction {
  a('Autobot', Color.fromARGB(255, 255, 0, 0), Image(image: AssetImage('assets/background.png'))), 
  d('Decepticon', Color.fromARGB(255, 112, 79, 162), Image(image: AssetImage('assets/background.png'))),
  o('Other', Color.fromARGB(255, 128, 128, 128), Image(image: AssetImage('assets/background.png')));

  const Faction(this.label, this.color, this.image);
  final String label;
  final Color color;
  final Image image;
  
}


class Toy {
  Toy({required this.name, required this.color});

  final String name;
  final Color color;
}