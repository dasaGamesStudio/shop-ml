import 'package:flutter/material.dart';
import 'package:markethelper/mypackages/mathdgs.dart';
import 'package:markethelper/navigationSystem/waypoint_model.dart';

class NavPoint{
  static final w1 = WNode(id: "w1", position: Size(0.08 * 1080,0.1 * 1920), neighbors: [],);
  static final w2 = WNode(id: "w2", position: Size(0.225 * 1080,0.1 * 1920), neighbors: [],);
  static final w3 = WNode(id: "w3", position: Size(0.52 * 1080,0.1 * 1920), neighbors: [],);
  static final w4 = WNode(id: "w4", position: Size(0.92 * 1080,0.1 * 1920), neighbors: [],);

  static final w5 = WNode(id: "w5", position: Size(0.08 * 1080,0.21 * 1920), neighbors: [],);
  static final w6 = WNode(id: "w6", position: Size(0.92 * 1080,0.21 * 1920), neighbors: [],);

  static final w7 = WNode(id: "w7", position: Size(0.08 * 1080,0.32 * 1920), neighbors: [],);
  static final w8 = WNode(id: "w8", position: Size(0.225 * 1080,0.32 * 1920), neighbors: [],);
  static final w9 = WNode(id: "w9", position: Size(0.52 * 1080,0.32 * 1920), neighbors: [],);
  static final w10 = WNode(id: "w10", position: Size(0.92 * 1080,0.32 * 1920), neighbors: [],);

  static final w11 = WNode(id: "w11", position: Size(0.08 * 1080,0.38 * 1920), neighbors: [],);
  static final w12 = WNode(id: "w12", position: Size(0.225 * 1080,0.38 * 1920), neighbors: [],);
  static final w13 = WNode(id: "w13", position: Size(0.52 * 1080,0.38 * 1920), neighbors: [],);
  static final w14 = WNode(id: "w14", position: Size(0.92 * 1080,0.38 * 1920), neighbors: [],);

  static final w15 = WNode(id: "w15", position: Size(0.08 * 1080,0.485 * 1920), neighbors: [],);
  static final w16 = WNode(id: "w16", position: Size(0.92 * 1080,0.482 * 1920), neighbors: [],);

  static final w17 = WNode(id: "w17", position: Size(0.08 * 1080,0.61 * 1920), neighbors: [],);
  static final w18 = WNode(id: "w18", position: Size(0.225 * 1080,0.61 * 1920), neighbors: [],);
  static final w19 = WNode(id: "w19", position: Size(0.52 * 1080,0.61 * 1920), neighbors: [],);
  static final w20 = WNode(id: "w20", position: Size(0.92 * 1080,0.61 * 1920), neighbors: [],);

  static final w21 = WNode(id: "w21", position: Size(0.08 * 1080,0.68 * 1920), neighbors: [],);
  static final w22 = WNode(id: "w22", position: Size(0.225 * 1080,0.68 * 1920), neighbors: [],);
  static final w23 = WNode(id: "w23", position: Size(0.52 * 1080,0.68 * 1920), neighbors: [],);
  static final w24 = WNode(id: "w24", position: Size(0.92 * 1080,0.68 * 1920), neighbors: [],);

  static final w25 = WNode(id: "w25", position: Size(0.08 * 1080,0.785 * 1920), neighbors: [],);
  static final w26 = WNode(id: "w26", position: Size(0.92 * 1080,0.785 * 1920), neighbors: [],);

  static final w27 = WNode(id: "w27", position: Size(0.08 * 1080,0.9 * 1920), neighbors: [],);
  static final w28 = WNode(id: "w28", position: Size(0.225 * 1080,0.9 * 1920), neighbors: [],);
  static final w29 = WNode(id: "w29", position: Size(0.52 * 1080,0.9 * 1920), neighbors: [],);
  static final w30 = WNode(id: "w30", position: Size(0.92 * 1080,0.9 * 1920), neighbors: [],);

  static final w31 = WNode(id: "w31", position: Size(0.37 * 1080,0.1 * 1920), neighbors: [],);
  static final w32 = WNode(id: "w32", position: Size(0.72 * 1080,0.1 * 1920), neighbors: [],);

  static final w33 = WNode(id: "w33", position: Size(0.37 * 1080,0.32 * 1920), neighbors: [],);
  static final w34 = WNode(id: "w34", position: Size(0.72 * 1080,0.32 * 1920), neighbors: [],);

  static final w35 = WNode(id: "w35", position: Size(0.37 * 1080,0.38 * 1920), neighbors: [],);
  static final w36 = WNode(id: "w36", position: Size(0.72 * 1080,0.38 * 1920), neighbors: [],);

  static final w37 = WNode(id: "w37", position: Size(0.37 * 1080,0.61 * 1920), neighbors: [],);
  static final w38 = WNode(id: "w38", position: Size(0.72 * 1080,0.61 * 1920), neighbors: [],);

  static final w39 = WNode(id: "w39", position: Size(0.37 * 1080,0.68 * 1920), neighbors: [],);
  static final w40 = WNode(id: "w40", position: Size(0.72 * 1080,0.68 * 1920), neighbors: [],);

  static final w41 = WNode(id: "w41", position: Size(0.37 * 1080,0.9 * 1920), neighbors: [],);
  static final w42 = WNode(id: "w42", position: Size(0.72 * 1080,0.9 * 1920), neighbors: [],);

  static final List<WNode> NavPList = [NavPoint.w1,NavPoint.w2,NavPoint.w3,NavPoint.w4,NavPoint.w5, NavPoint.w6, NavPoint.w7, NavPoint.w8,NavPoint.w9,NavPoint.w10,NavPoint.w11,NavPoint.w12, NavPoint.w13, NavPoint.w14,NavPoint.w15, NavPoint.w16, NavPoint.w17,NavPoint.w18,NavPoint.w19,NavPoint.w20, NavPoint.w21,NavPoint.w22,NavPoint.w23,NavPoint.w24, NavPoint.w25,NavPoint.w26, NavPoint.w27,NavPoint.w28,NavPoint.w29,NavPoint.w30, NavPoint.w31,NavPoint.w32, NavPoint.w33,NavPoint.w34,NavPoint.w35,NavPoint.w36,NavPoint.w37,NavPoint.w38,NavPoint.w39,NavPoint.w40,NavPoint.w41,NavPoint.w42];

  static GetNavNeighbors(){
    NavPoint.NavPList.forEach((node) {
      NavPoint.NavPList.forEach((element) {
        if(element != node){
          if(MathDGS.Distance(node.position, element.position)/100 < 2.55){
            node.neighbors.add(element);
          }
        }
      });
    });
  }

}
