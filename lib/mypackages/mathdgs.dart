import 'package:flutter/widgets.dart';
import 'dart:math';

class MathDGS {
  static double sqrMagnitude(Size a){
    return (a.width * a.width + a.height * a.height);
  }

  static double sqrDistance(Size a, Size b){
    return ((a.width - b.width)*(a.width - b.width) + (a.height - b.height)*(a.height - b.height));
  }

  static double Distance(Size a, Size b){
    return sqrt((a.width - b.width)*(a.width - b.width) + (a.height - b.height)*(a.height - b.height));
  }

  static double ManhattanDistance(Size a, Size b){
    return (a.width - b.width).abs() + (a.height - b.height).abs();
  }

}