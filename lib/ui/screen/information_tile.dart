import 'package:flutter/material.dart';

class InformationTile {
  final String title;
  final List<InformationTile> tiles;

  InformationTile({
    @required this.title,
    this.tiles = const []
  });

}