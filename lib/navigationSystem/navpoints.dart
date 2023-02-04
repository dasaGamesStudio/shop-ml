import 'package:markethelper/navigationSystem/waypoint_model.dart';

class WaypointNode {
  static final n1 = WNode(name: "n1", connectedNodes: [
    //   ConnectedWNode(Node: n2, distance: 1),
    //   ConnectedWNode(Node: n3, distance: 2),
    //   ConnectedWNode(Node: n4, distance: 1),
  ]);

  static final n2 = WNode(name: "n2", connectedNodes: [
    // ConnectedWNode(Node: n1, distance: 1),
    // ConnectedWNode(Node: n3, distance: 1),
    // ConnectedWNode(Node: n5, distance: 2),
  ]);
  static final n3 = WNode(name: "n3", connectedNodes: [
    // ConnectedWNode(Node: n1, distance: 2),
    // ConnectedWNode(Node: n2, distance: 1),
    // ConnectedWNode(Node: n5, distance: 4),
  ]);
  static final n4 = WNode(name: "n4", connectedNodes: [
    // ConnectedWNode(Node: n1, distance: 1),
    // ConnectedWNode(Node: n5, distance: 3),
  ]);
  static final n5 = WNode(name: "n5", connectedNodes: [
    // ConnectedWNode(Node: n2, distance: 2),
    // ConnectedWNode(Node: n3, distance: 4),
    // ConnectedWNode(Node: n4, distance: 3)
  ]);

  static void init() {
    n1.connectedNodes = [
      ConnectedWNode(Node: n2, distance: 1),
      ConnectedWNode(Node: n3, distance: 2),
      ConnectedWNode(Node: n4, distance: 1),
    ];
    n2.connectedNodes = [
      ConnectedWNode(Node: n1, distance: 1),
      ConnectedWNode(Node: n3, distance: 1),
      ConnectedWNode(Node: n5, distance: 2),
    ];
    n3.connectedNodes = [
      ConnectedWNode(Node: n1, distance: 2),
      ConnectedWNode(Node: n2, distance: 1),
      ConnectedWNode(Node: n5, distance: 4),
    ];
    n4.connectedNodes = [
      ConnectedWNode(Node: n1, distance: 1),
      ConnectedWNode(Node: n5, distance: 3),
    ];
    n5.connectedNodes = [
      ConnectedWNode(Node: n2, distance: 2),
      ConnectedWNode(Node: n3, distance: 4),
      ConnectedWNode(Node: n4, distance: 3)
    ];
  }
}
