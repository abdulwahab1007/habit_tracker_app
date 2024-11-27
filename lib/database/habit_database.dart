import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practice_habit_tracker/models/app_settings.dart';
import 'package:practice_habit_tracker/models/habit.dart';
 
 

class HabitDatabase extends ChangeNotifier{
  // We 'll divider this HabitDatabase into two sections 
  static late Isar isar;
  //Database Initialization 
  static Future<void> initialize()async{
    //fetch the directory 
      final dir= await getApplicationDocumentsDirectory();
      isar=await Isar.open(
      [HabitSchema,AppSettingsSchema], 
      directory: dir.path
      );       
      
  }
  // saving the First Launch date of the app 
  Future<void> saveFirstLaunchDate()async{
    //check if it's saved already or not 
    final existingSettings=await isar.appSettings.where().findFirst();
    if(existingSettings==null){
      //if there is no settings are saved then save the Firstlaunch date 
      final settings=AppSettings()..firstLaunchDate=DateTime.now();
      //now save it to the db 
      await isar.writeTxn(()=>isar.appSettings.put(settings));
    }
  }
  //getter for the FirstLaunch date for the app 
  Future<DateTime?> getFirstLaunchDate()async{
    final existingSettings=await isar.appSettings.where().findFirst();
    return existingSettings?.firstLaunchDate;
  }

  //CRUD X Operations
    List<Habit> currentHabits=[];
  //create a new Habit 
  Future<void> createHabit(String habitName)async{
    Habit habit=Habit()..name=habitName..completedDays=[];
    //save the habit to the db 
    await isar.writeTxn(()=>isar.habits.put(habit));
    // read the habits now 
    readHabits();
  }
  //read habits 
  Future<void> readHabits()async{
    //for reading the habits I need to First fetch all the habits 
  List<Habit> existingHabits=await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(existingHabits);
    notifyListeners();
  }

  //Update the Completion status of the habit 
 Future<void> updateHabitcompeletion(int id, bool isCompleted)async{
    //firstly fetch the specific habit from the database 
    final habit=await isar.habits.get(id);
    //now update the completion status
    if(habit!=null){
      await isar.writeTxn(() async{
        // If the habit is completed --> add the current date to the compeleted days list 
        if(isCompleted && !habit.completedDays.contains(DateTime.now())){
            final today=DateTime.now();
            //add the current date if its not already in the list 
            habit.completedDays.add(
              DateTime(
                today.year,
                today.month,
                today.day
                ),
            );
        }
        else{
            // remove the current date if the habit is marked as not compeleted ! 
            // IMP NOTE :
            //The date in removeWhere((date) => ...) is a placeholder variable that represents each individual item in the completedDays list as removeWhere iterates through it.//
            
            habit.completedDays.removeWhere((date)=>
              date.year==DateTime.now().year &&
              date.month==DateTime.now().month && 
              date.day== DateTime.now().day
            );
        }
        //save the updated habits to the db 
        await isar.habits.put(habit);  //this is fucking nessessary fucker ! 
      }
      );
    }
    //re read the notes 
    await readHabits();
  }

  //Update the Name of the Habit  
  Future<void> updateHabitName(int id, String newName)async{
    //Firstly fetch the habit 
    final habit=await isar.habits.get(id);
    if(habit!=null){
      habit.name=newName;
      await isar.writeTxn(()=>isar.habits.put(habit));
    }
    //re read the habits 
    await readHabits();
  }
  // Delete the habit 
  Future<void> deleteHabit(int id)async {
    await  isar.writeTxn(()=>isar.habits.delete(id));
    await readHabits();
  }
   
}