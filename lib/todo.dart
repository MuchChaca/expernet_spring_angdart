
class Todo {
	final int id;
	String label;
  bool isDone;

	Todo(this.id, this.label, this.isDone);

	factory Todo.fromJson(Map<String, dynamic> todo) =>
			Todo(_toInt(todo['id']), todo['label'], todo['isDone']);


	Map toJson() => {'id': id, 'label': label, 'isDone': isDone};
}

int _toInt(id) => id is int ? id : int.parse(id);