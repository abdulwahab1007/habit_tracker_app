// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget{
  const MyHabitTile({
    super.key,
    required this.isCompleted,
    required this.text,
    required this.onChanged,
    required this.onEditPressed,
    required this.onDeletePressed
    });
  final bool isCompleted;
  final String text;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? onEditPressed;
  final void Function(BuildContext)? onDeletePressed;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(
          motion:  StretchMotion(), 
          children: [
              SlidableAction(
                onPressed: onEditPressed,
                borderRadius: BorderRadius.circular(8.0),
                backgroundColor: Colors.grey.shade800,
                icon: Icons.settings,
                ),
                SlidableAction(
                onPressed: onDeletePressed,
                borderRadius: BorderRadius.circular(8.0),
                backgroundColor: Colors.red,
                icon: Icons.delete,
                )
          ]
          ),
        child: GestureDetector(
          onTap: (){
            if(onChanged!=null){
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: isCompleted ?Colors.green :Theme.of(context).colorScheme.secondary ,
            ),
            child: ListTile(
              title: Text(text),
              leading: Checkbox(
                activeColor: Colors.green,
                value: isCompleted, 
                onChanged: onChanged,
                ),
            ),
            
          ),
        ),
      ),
    );
  }
  
}