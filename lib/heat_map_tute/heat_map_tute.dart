import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatMapTute extends StatelessWidget{
  const HeatMapTute({super.key});
  //So spepcifically there are probably two most important porperties you need to define ni this heatmap , The datasets, and you can also say the Colorsets ,where you define the colors 
  @override
  Widget build(BuildContext context) {
    return HeatMap(
      datasets: {
        // This dataset is one of the important thing in our heatmap,and it requires a map of DataTime and an integer Map<DateTime,int>? datasets ..
        // 
        DateTime(2024,11,24): 9,  // this integer on the rihgth side tells us about 
        DateTime(2024,11,26): 9,  // the strength of the color ...GREAT ! 
        DateTime(2024,11,29): 5,
        DateTime(2024,12,9): 7,
        DateTime(2024,12,13): 9,
        DateTime(2024,12,14): 8,
      },
      colorMode: ColorMode.opacity,
      showText: false,
      scrollable: true,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 40)),
      textColor: Colors.white,
      size: 40,
      colorsets: {
        // these numbers define the strngth of the colorsets 
        1: Colors.green.shade300,
        2: Colors.green.shade400,
        3: Colors.green.shade500,
        4: Colors.green.shade600,
        5: Colors.green.shade700,
        6: Colors.green.shade800,
        7: Colors.green.shade900,
        8:  const Color.fromARGB(255, 27, 94, 31),
        9:  const Color.fromARGB(255, 30, 94, 31),
      }
      );
  }
}