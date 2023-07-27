import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';
import 'package:todo_app/model/todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({super.key, required this.todo,  required this.onToDoChanged,  required this.onDeleteItem});
  final Todo todo;
  final onToDoChanged;
  final onDeleteItem;
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: ListTile(
         onTap: () {
           onToDoChanged(todo);
         },
         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
         tileColor: Colors.white,
         leading:  Icon(
          todo.isDone? Icons.check_box :Icons.check_box_outline_blank_outlined,
          color: tdBlue,),
          title: 
              Text(todo.todotext,
             style:  TextStyle(
              fontSize: 16,
              color: Colors.black,
              decoration: todo.isDone?TextDecoration.lineThrough:null,
            ),
            ),
          trailing: IconButton(
            onPressed: () {
             onDeleteItem(todo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: tdRed,
              ),
          )
         
      ),
      );
  }
}