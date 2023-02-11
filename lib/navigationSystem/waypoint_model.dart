import 'package:flutter/rendering.dart';

class WNode {
  String id;
  Size position;
  double gCost;
  double hCost;

  bool walkable;

  WNode? parent;
  List<WNode> neighbors;

  WNode({
    required this.id,
    this.position = Size.zero,
    this.gCost = double.maxFinite,
    this.hCost = double.maxFinite,
    this.walkable = true,
    this.parent,
    required this.neighbors,
  });

  double getF(){
    return gCost + hCost;
  }

  void setGCost(double g) => gCost = g;
  void setHCost(double h) => hCost = h;

}

class Path {
  double score;
  List<WNode> nodes;

  Path({this.score = 0, required this.nodes});
}