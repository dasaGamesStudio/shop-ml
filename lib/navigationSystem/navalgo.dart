import 'package:markethelper/navigationSystem/navpoints.dart';
import 'package:markethelper/navigationSystem/waypoint_model.dart';

class NavSys{
  static FindPath(startNode, endNode){
    WaypointNode.init();
    startNode.parentNode = startNode;
    var paths = <Path>[];
    var successPaths = <Path>[];

    startNode.connectedNodes?.forEach((connectedNode) {
      paths.add(Path(nodes: [startNode, connectedNode.Node], score: connectedNode.distance + connectedNode.Node.avoidance));
    });
    paths.forEach((path) {
      if (path.nodes.last == endNode){
        successPaths.add(path);
        print("match: " + path.nodes.last.name);
      }
    });
    paths.sort((a, b) => a.score.compareTo(b.score)); // This will sort the paths list in ascending order of the score
  }
}