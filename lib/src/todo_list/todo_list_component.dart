import 'dart:async';

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';

import 'todo_list_service.dart';

import '../../todo.dart';

@Component(
	selector: 'todo-list',
	styleUrls: ['todo_list_component.css'],
	templateUrl: 'todo_list_component.html',
	directives: [
		MaterialCheckboxComponent,
		MaterialFabComponent,
		MaterialIconComponent,
		materialInputDirectives,
		NgFor,
		NgIf,
	],
	providers: [const ClassProvider(TodoListService)],
)
class TodoListComponent implements OnInit {
	final TodoListService todoListService;

	List<Todo> items = [];
	String newTodo = '';

	TodoListComponent(this.todoListService);

	@override
	Future<Null> ngOnInit() async {
		items = (await todoListService.getTodoList()).cast<Todo>();
	}

	void add() async {
		Todo todo = (await todoListService.create(newTodo));
		items.add(todo);
		newTodo = '';
	}

	Future<Todo> remove(int index) async {
		Todo resp = (await todoListService.delete(items.elementAt(index).id));
		return items.removeAt(index);
	}
}
