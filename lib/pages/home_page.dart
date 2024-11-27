// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:practice_habit_tracker/components/my_drawer.dart';
import 'package:practice_habit_tracker/components/my_habit_tile.dart';
import 'package:practice_habit_tracker/components/my_heat_map.dart';
import 'package:practice_habit_tracker/database/habit_database.dart';
import 'package:practice_habit_tracker/models/habit.dart';
import 'package:practice_habit_tracker/util/habit_util.dart';
 
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget{
  const HomePage({super.key});
  //will knowing heal me ?   
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //create Habit method 
  TextEditingController controller=TextEditingController();
  void createNewHabit(){
      showDialog(
        context: context, 
        builder: (context)=>AlertDialog(
          content: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Create New Habit',
              ),
          ),
          actions: [
            MaterialButton(
                onPressed: (){
                  Navigator.pop(context);
                  controller.clear();
                },
                child: Text('Cancel'),
                ),
            MaterialButton(
              onPressed: (){
                Provider.of<HabitDatabase>(context,listen: false).createHabit(controller.text);
                Navigator.pop(context);
                controller.clear();
              },
              child: Text('Create',
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary
              ),),
              ),
              //let's First get access to our Habit Database , and fetch the list of habits               
          ],
        )
        );
  }
  //UpdateHabitCompeletion 
  @override
  void initState() {
    super.initState();

    Provider.of<HabitDatabase>(context,listen: false).readHabits();
  }

  //onEdit Pressed 
  void editHabitBox(Habit habit){
    //first of all let's pre fill the controller 
    controller.text=habit.name;
    showDialog(context: context, 
    builder: (context)=>AlertDialog(
      //let's prefill the controller First 
      content: TextField(
        controller: controller,
      ),
      actions: [
        MaterialButton(
          onPressed: (){
            //get the new habit Name 
            String newHabitName=controller.text;
            //save to the sb
            context.read<HabitDatabase>().updateHabitName(habit.id, newHabitName);
            controller.clear();
            Navigator.pop(context);
          },
          child: Text('Save'),
          ),
          MaterialButton(
            onPressed: (){
              Navigator.pop(context);
              controller.clear();
            },
            child: Text('Cancel'),
            )

      ],
    )
    );
  }
  //deleteHabit BOx 
  void deleteHabitBox(Habit habit){
    showDialog(context: context, 
    builder: (context)=>AlertDialog(
      content: Text('Are you sure you want to delete?'),
      actions: [
        MaterialButton(
          onPressed: (){
            context.read<HabitDatabase>().deleteHabit(habit.id);
            Navigator.pop(context);
          },
          child: Text('Delete'),
          ),
          MaterialButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text('Cancel'),
            )
      ],
    ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          
        ),
        drawer: const MyDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewHabit,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child:  Icon(Icons.add,
          color: Theme.of(context).colorScheme.inversePrimary,),
          ),

          body: ListView(
            
            children: [
              // Heat Map body 
              _buildHeatMap(),
              // Habit list 
              _buildHabitList(),
            ],

          )
      );
  }
  //CheckHabitOnAndOff
  void checkHabitOnAndOff(bool? value,Habit habit){
    //now update the habit completion status from the database 
    if(value!=null){
      context.read<HabitDatabase>().updateHabitcompeletion(habit.id,value);
    }
  }
  // So actually we are going to make our own built -in widget 
  Widget _buildHabitList(){
    //getting access to the databse 
      HabitDatabase habitDatabase= context.watch<HabitDatabase>();
      //getting access to habits list 
      List<Habit> currentHabits=habitDatabase.currentHabits;
      
      return ListView.builder(
            shrinkWrap: true, 
            physics: NeverScrollableScrollPhysics(),
            //if you have lists inside of another lists , like nested list ,you might have problem with scrolling,that's why you have to say this 
            itemCount: currentHabits.length,
            itemBuilder: (context,index){
              final habit=currentHabits[index];
              return MyHabitTile(
                isCompleted: isHabitCompletedToday(habit.completedDays), 
                text: habit.name,
                onChanged: (value)=>checkHabitOnAndOff(value,habit),
                onEditPressed: (context)=>editHabitBox(habit),
                onDeletePressed: (context) =>deleteHabitBox(habit) ,
                );
            }
        );
  }

  //build Heat MAP 
  Widget _buildHeatMap(){
    //first of all to build the Heat map , "Fetch the Databse" 
    final habitDatabase=context.watch<HabitDatabase>();
    //get the List of the current Habits 
    final currentHabits=habitDatabase.currentHabits;

    //return the HeatMap UI 
    // ABOUT THE FUTURE BUILDER *(The FutureBuilder widget in Flutter is a powerful tool for building user interfaces that depend on asynchronous operations, such as fetching data from a server or database. It allows you to build widgets based on the state of a Future object, such as whether the operation is still running, completed successfully, or resulted in an error.**)
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstLaunchDate(), 
      builder: (context,snapshot){
        // the Future builder aitomatically listens to the future and updates the snapshot ,when the step to  listen to the future compeleted , The FutureBuilder automatically stores the firstlaunchdata to the snapshot.data  
        
        // ==> once we know that the First date is launched ,->build the heatMap 
        if(snapshot.hasData){
          return MyHeatMap(
            datasets: prepHeatMapDataset(currentHabits),//for this we willl make another helper method   
            startDate: snapshot.data!
            );
        }
        //hnadle case where no data is returned 
        else{
          return Container();
        }
      }
      );
  }
}