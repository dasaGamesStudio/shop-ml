import 'package:flutter/rendering.dart';

class WNode{
  String name;
  Size? pixelPos;
  double avoidance;
  String? assignShelfID;
  String? assignSectionID;
  WNode? parentNode;
  List<ConnectedWNode>? connectedNodes;

  WNode({
    required this.name,
    this.pixelPos,
    this.assignSectionID,
    this.assignShelfID,
    this.parentNode,
    this.avoidance = 0,
    this.connectedNodes,
});
}

class ConnectedWNode{
  WNode Node;
  double distance;

  ConnectedWNode({
    required this.Node,
    required this.distance,
  });
}

class Path{
  double score;
  List<WNode> nodes;

  Path({this.score = 0, required this.nodes});
}