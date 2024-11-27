import 'package:isar/isar.dart';
//we can Store multiple files in our database that we want to use in our app ,to help us 
part 'app_settings.g.dart';
@Collection()
class AppSettings {
  // in this model , I only want to store the First launch date of the app , for the heatmap later on !  ,So it 'll only contain the First launch date 
  Id id=Isar.autoIncrement;
  DateTime? firstLaunchDate;
}