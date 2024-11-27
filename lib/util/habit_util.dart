

 import 'package:practice_habit_tracker/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays){
  final today=DateTime.now();
  return completedDays.any((date)=>
  date.year==today.year && 
  date.month==today.month && 
  date.day==today.day
  );
}
// in here we need the helper method to prepare our heatmap dataset 

Map<DateTime,int> prepHeatMapDataset(List<Habit> habits){

  Map<DateTime,int> dataset={};
  // now go througth each habit in the Habit List 
  for(var habit in habits){
    for(var date in habit.completedDays){ //and go through to each date in the habit
      //normalize date to avoid datetime mismatch
      final normalizedDate=DateTime(date.year,date.month,date.day);
      //this is what does it mean by normalizing the date 
      /* The DateTime class in Dart includes precise time information (hours, minutes, seconds, milliseconds).
      To avoid mismatches due to time differences (e.g., 2024-11-18 10:00:00 vs. 2024-11-18 00:00:00), we normalize the date to include only the year, month, and day.
      Normalization ensures all times on the same calendar day are treated as the same date.*/

      //if the date already exists in the dataset ,increment its count to strnghtrn the color 
      if(dataset.containsKey(normalizedDate)){ //we are only ensuring here that the date exist 
        dataset[normalizedDate]=dataset[normalizedDate]! + 1; 
      }
      else{
        //else initialize it with a count of 1 
        dataset[normalizedDate]=1;
      }
    }
  }
  return dataset;
}