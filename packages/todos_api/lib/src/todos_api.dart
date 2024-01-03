import 'package:todos_api/todos_api.dart';

/// {@template todos_api}
/// The interface and models for an API providing access to todos.
/// {@endtemplate}
abstract class TodosApi {
  /// {@macro todos_api}
  const TodosApi();

  ///Provides [Stream] ทุกตัวของ todos
  Stream<List<Todo>> getTodos();

  ///save [todo]
  ///
  ///ถ้า [todo] พร้อมกับมี id อยู่แล้ว , มันจะไปแทนที่
  Future<void> saveTodo(Todo todo);

  ///delete [todo] กับ id ที่ได้รับ
  ///
  ///ถ้าไม่มี todo กับ id ที่มีอยู่ , จะ throw error นี่ [TodoNotFoundException]
  Future<void> deleteTodo(String id);

  ///delete all completed todos.
  ///
  ///Return number ของตัวเลขที่ถูกลบ
  Future<int> clearCompleted();

  ///set isCompleated state ของ todos ทุกตัวตาม value มีอยู่
  Future<int> completeAll({required bool isCompleted});
}

///Error throw เมื่อไม่พบ [Todo] กับ id ของมัน
class TodoNotFoundException implements Exception {}
