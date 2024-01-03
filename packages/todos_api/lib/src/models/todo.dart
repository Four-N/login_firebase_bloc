import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:todos_api/src/models/models.dart';
import 'package:uuid/uuid.dart';

part 'todo.g.dart';

@immutable
@JsonSerializable()
class Todo extends Equatable {
  Todo({
    required this.title,
    String? id,
    this.description = '',
    this.isCompleted = false,
  })  : assert(
            id == null || id.isNotEmpty, 'id must either be null oe not empty'),
        id = id ?? const Uuid().v4();

  final String title;

  final String id;

  final String description;

  final bool isCompleted;

  ///Return a copy ใน this todo พร้อมกับ ให้values updated.
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      title: title ?? this.title,
      id: id ?? this.id,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  ///Deserializes [JsonMap] ไปเป็น [Todo] .
  static Todo fromJson(JsonMap json) => _$TodoFromJson(json);

  ///Converts [Todo] ไปเป็น [JsonMap] .
  JsonMap toJson() => _$TodoToJson(this);

  @override
  List<Object?> get props => [title, id, description, isCompleted];
}
