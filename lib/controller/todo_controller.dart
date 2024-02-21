import 'package:patch_imp/models/todo.dart';
import 'package:patch_imp/repository/repository.dart';

class TodoController {
  final Repository _repository;

  TodoController(this._repository);

  //get
  Future<List<Todo>> fetchTodoList() async {
    return _repository.getTodoList();
  }

  Future<String> updatePatchCompleted(Todo todo) async {
    return _repository.patchCompleted(todo);
  }

  Future<String> updateputCompleted(Todo todo) async {
    return _repository.putCompleted(todo);
  }

  Future<String> deleteTodo(Todo todo) {
    return _repository.deleteTodo(todo);
  }

  Future<String> postTodo(Todo todo) {
    return _repository.postTodo(todo);
  }
}
