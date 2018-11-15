
class Todo {
	final int id;
	String label;

	Todo(this.id, this.label);

	factory Todo.fromJson(Map<String, dynamic> todo) =>
			Todo(_toInt(todo['id']), todo['label']);


	Map toJson() => {'id': id, 'label': label};
}

int _toInt(id) => id is int ? id : int.parse(id);