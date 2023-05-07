import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Todo List'),
        ),
        body: TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<String> _todos = [];
  List<String> _completedTodos = [];
  bool _showCompleted = false;

  void _addTodo() {
    // show a dialog to input a new todo item
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a new todo'),
          content: TextField(
            onSubmitted: (value) {
              setState(() {
                _todos.add(value);
              });
              Navigator.of(context).pop();
            },
          ),
        );
      },
    );
  }

  void _toggleShowCompleted() {
    setState(() {
      _showCompleted = !_showCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _showCompleted ? _completedTodos.length : _todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(
                    _showCompleted ? _completedTodos[index] : _todos[index]),
                onDismissed: (direction) {
                  setState(() {
                    if (_showCompleted) {
                      // delete the completed todo item
                      _completedTodos.removeAt(index);
                    } else {
                      // move the todo item to the completed list
                      _completedTodos.add(_todos[index]);
                      _todos.removeAt(index);
                    }
                  });
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    title: Text(_showCompleted
                        ? _completedTodos[index]
                        : _todos[index]),
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FloatingActionButton(
              onPressed: _addTodo,
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: _toggleShowCompleted,
              child: Icon(_showCompleted ? Icons.list : Icons.check),
            ),
          ],
        ),
      ],
    );
  }
}
