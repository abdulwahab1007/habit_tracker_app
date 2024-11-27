// So in the models , we need two models , that 'll help us to Achieve the functionality we want in our app , ( a habit model and an App settings model),
// an App settigns model to Store the first launch date of the app.
import 'package:isar/isar.dart';

part 'habit.g.dart';
@Collection()
class Habit {
  Id id=Isar.autoIncrement;
  late String name;
  late List<DateTime> completedDays;
  // So here the DataTime class 
  //DateTime(year,month,day)
}

