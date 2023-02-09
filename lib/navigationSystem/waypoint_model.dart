import 'package:flutter/rendering.dart';

class WNode {
  String id;
  Size position;
  double gCost;
  double fCost;

  bool isWalkable;

  WNode? connection;
  List<WNode> neighbors;

  WNode({
    required this.id,
    this.position = Size.zero,
    this.gCost = 0,
    this.fCost = double.maxFinite,
    this.isWalkable = true,
    this.connection,
    required this.neighbors,
  });

}

class Path {
  double score;
  List<WNode> nodes;

  Path({this.score = 0, required this.nodes});
}