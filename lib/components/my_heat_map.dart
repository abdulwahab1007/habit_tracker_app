// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget{
  const MyHeatMap({
    super.key,
    required this.datasets,
    required this.startDate
    });
  final Map<DateTime, int>? datasets;
  final DateTime? startDate;
  @override
  Widget build(BuildContext context) {
    return HeatMap(
      // So there are two most important things in the heat map to remmeber , the datasets and the Colorsets 
      // Dataset rquires us a map of DateTime and an integer , that interger repreents the strength of the color whihc we have defined in the color sets 
      datasets: datasets,
      startDate: startDate,
      endDate: DateTime.now().add(Duration(days: 7)),
      showText: true,
      textColor: Colors.white,
      scrollable: true,
      defaultColor: Theme.of(context).colorScheme.secondary, //what is the default color
      size: 30,
      colorMode: ColorMode.color,
      showColorTip: false,
      colorsets: {
        1: Colors.green.shade200,
        2: Colors.green.shade300,
        3: Colors.green.shade400,
        4: Colors.green.shade500,
        5: Colors.green.shade600,
      }
      );
  }
}