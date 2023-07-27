class Todo{
  String id;
  String todotext;
  bool isDone;

  Todo( {this.isDone=false, required this.id, required this.todotext});

  static List<Todo> todolist(){
    return [
       Todo(id: '01', todotext: 'Morning Excercise', isDone: true ),
      Todo(id: '02', todotext: 'Buy Groceries', isDone: true ),
      Todo(id: '03', todotext: 'Check Emails', ),
      Todo(id: '04', todotext: 'Team Meeting', ),
      Todo(id: '05', todotext: 'Work on mobile apps for 2 hour', ),
      Todo(id: '06', todotext: 'Dinner with Jenny', ),
    ];

  }
}