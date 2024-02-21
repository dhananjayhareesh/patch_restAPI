import 'package:flutter/material.dart';
import 'package:patch_imp/controller/todo_controller.dart';
import 'package:patch_imp/models/todo.dart';
import 'package:patch_imp/repository/todo_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var todoController = TodoController(TodoRepository());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent[100],
        title: Text('Rest API'),
      ),
      body: FutureBuilder(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('error'),
            );
          }
          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Todo todo = Todo(userId: 3, title: 'sample post', completed: false);
          todoController.postTodo(todo).then((value) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(milliseconds: 1000),
                content: Text(value == 'true'
                    ? 'Todo added successfully'
                    : 'Failed to add todo'),
              ),
            );
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var todo = snapshot.data?[index];
            return Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(flex: 1, child: Text('${todo?.id}')),
                  Expanded(flex: 3, child: Text('${todo?.title}')),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              todoController
                                  .updatePatchCompleted(todo!)
                                  .then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    content: Text(value == 'true'
                                        ? 'Todo patched successfully'
                                        : 'Failed to patch todo'),
                                  ),
                                );
                              });
                            },
                            child: buildCallContainer(
                                'patch', Colors.orangeAccent),
                          ),
                          InkWell(
                              onTap: () {
                                todoController
                                    .updateputCompleted(todo!)
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      content: Text(value == 'true'
                                          ? 'put successful'
                                          : 'Failed to update todo'),
                                    ),
                                  );
                                });
                              },
                              child:
                                  buildCallContainer('put', Colors.pinkAccent)),
                          InkWell(
                              onTap: () {
                                todoController.deleteTodo(todo!).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(milliseconds: 1000),
                                      content: Text(value == 'true'
                                          ? 'Todo deleted successfully'
                                          : 'Failed to delete todo'),
                                    ),
                                  );
                                });
                              },
                              child:
                                  buildCallContainer('del', Colors.redAccent)),
                        ],
                      )),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.5,
              height: 0.5,
            );
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(child: Text('$title')),
    );
  }
}
