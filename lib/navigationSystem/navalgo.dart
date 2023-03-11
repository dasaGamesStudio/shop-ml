
import 'package:markethelper/mypackages/mathdgs.dart';
import 'package:markethelper/navigationSystem/waypoint_model.dart';

class NavSys {
  static List<WNode> NavPath = [];
  static FindPath(WNode startNode,WNode endNode) {
    List<WNode> openSet = [];
    openSet.add(startNode);
    List<WNode> closedSet = [];

    while (openSet.isNotEmpty){
      WNode currentNode = openSet[0];
      for(int i =1; i < openSet.length; i++){
        if(openSet[i].getF() < currentNode.getF() || openSet[i].getF() == currentNode.getF() && openSet[i].hCost < currentNode.hCost){
          currentNode = openSet[i];
        }
      }

      openSet.remove(currentNode);
      closedSet.add(currentNode);

      if(currentNode == endNode){
        print("Found The Target Node");
        ReConstructPath(startNode, endNode);
        //return;
        break;
      }

      for(int i = 0; i < currentNode.neighbors.length; i++){
        var neighbor = currentNode.neighbors[i];
        if(!neighbor.walkable || closedSet.contains(neighbor)){
          continue;
        }
        double newMovementCostToNeighbor = currentNode.gCost + MathDGS.ManhattanDistance(currentNode.position, neighbor.position);
        if(newMovementCostToNeighbor < neighbor.gCost || !openSet.contains(neighbor)){
          neighbor.setGCost(newMovementCostToNeighbor);
          neighbor.setHCost(MathDGS.ManhattanDistance(neighbor.position, endNode.position));
          neighbor.parent = currentNode;

          if(!openSet.contains(neighbor)){
            openSet.add(neighbor);
          }
        }
      }
    }

  }

  static ReConstructPath(WNode startNode, WNode endNode){
    List<WNode> path = [];

    WNode? currentNode = endNode;
    double distance = 0;
    while(currentNode != startNode){
      path.add(currentNode!);
      currentNode = currentNode?.parent;
    }
    path.add(startNode);

    path = List.from(path.reversed);
    NavPath = path;
    NavPath.forEach((element) {
      print(element.id);
    });
  }
}
