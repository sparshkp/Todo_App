import 'package:flutter/material.dart';
import 'package:todo_app/constants/colors.dart';

import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
 const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoList =Todo.todolist();
   List<Todo> _foundToDo = [];
  final _todocontroller =TextEditingController();
  
  var onToDoChanged;
  @override
  void initState() {
    // TODO: implement initState
    _foundToDo=todoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String url="https://images.unsplash.com/photo-1580489944761-15a19d654956?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=461&q=80";
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: buildAppBar(url),
      body: Stack(
        children: [
          Container(
            padding:  const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                      margin: const EdgeInsets.only(
                        top: 50,
                        bottom: 20,
                      ),
                      child: const Text("ToDo's",style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),),
                      ),
                      for(Todo todo in _foundToDo.reversed)
                      TodoItem(
                        todo: todo, 
                        onDeleteItem: _deleteTodoItem,
                         onToDoChanged: _handleTodoChange
                         ),
                    ],
                    
                  ),
                )
              ],
            ),
          ),
           Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                      left: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20,),
                      decoration:   BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 0.0),
                          spreadRadius: 0.0,
                          blurRadius: 10.0,
                        )],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:  TextField(
                        controller: _todocontroller,
                        decoration: const InputDecoration(
                          hintText: "Add a new item",
                          border: InputBorder.none
                        )),
                  )),
                  Container(
                    margin: const EdgeInsets.only(right: 8,bottom: 12),
                    child: FloatingActionButton(
                      onPressed: (){
                        addToDoitem(_todocontroller.text);
                      },
                      backgroundColor: tdBlue,
                      child: const Icon(Icons.add),),
                  )
              ],
            ),
            
          )
        ],
      ),
    );
  }
  void _handleTodoChange(Todo todo){
    setState(() {
      todo.isDone =! todo.isDone;
    });
  }
  void _deleteTodoItem(String id){
   setState(() {
     todoList.removeWhere((item) => item.id==id);
   });
  }
  void addToDoitem(String  todo){
     setState(() {
      todoList.add(Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todotext: todo,
      ));
    });
    _todocontroller.clear();
  }
   void _runFilter(String enteredKeyword) {
    List<Todo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todoList;
    } else {
      results = todoList
          .where((item) => item.todotext.toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }
  Widget searchBox(){
    return Container(
              padding:  const EdgeInsets.symmetric(horizontal: 15),
              decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),),
                child:  TextField(
                    onChanged: (value) => _runFilter(value),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                    prefixIcon: Icon(
                      Icons.search,
                      color: tdBlack,
                      size: 20),
                      prefixIconConstraints: BoxConstraints(
                        maxHeight: 20,
                        maxWidth: 25,
                      ),
                      border: InputBorder.none,
                      hintText: "Search",
                      hintStyle: TextStyle(color: tdGrey),
      
                  ),
                ),
                
      
            );
  }

  AppBar buildAppBar(String url) {
    return AppBar(
      elevation: 0,
      backgroundColor: tdBGColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(url),),

          
      ]),
    );
  }
}