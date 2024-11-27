// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:practice_habit_tracker/database/habit_database.dart';
import 'package:practice_habit_tracker/pages/home_page.dart';

import 'package:practice_habit_tracker/theme/theme_provider.dart';
import 'package:provider/provider.dart';

/* so here we are going to make an app which we can say a Habit tracker app ,and we are going to use an ISAR database in it , ,that's is the real challenge, and challenges make us more stronger than ever we think we are ! ,We 'll take it and do it absolutely inshAllah ,no matter what it takes  
*/

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  // save the First launch date of the app ,
  await HabitDatabase().saveFirstLaunchDate();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>ThemeProvider()),
      ChangeNotifierProvider(create: (context)=>HabitDatabase()),
    ],
    child: const MyApp(),
    )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const  HomePage(),
      theme: Provider.of<ThemeProvider>(context).themedata,
    );
  }
}
