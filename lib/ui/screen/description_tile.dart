import 'package:flutter/material.dart';

class DescriptionTile {
  final String title;
  final List<DescriptionTile> tiles;

  DescriptionTile({
    @required this.title,
    this.tiles = const []
  });

}