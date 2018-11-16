import 'dart:async';
import 'dart:convert';

import '../../todo.dart';

import 'package:angular/core.dart';

import 'package:http/http.dart';

/// Mock service emulating access to a to-do list stored on a server.
@Injectable()
class TodoListService {
	static final _headers = {'Content-Type': 'application/json'};
	static const _url = 'http://localhost:9090/todo'; // URL to web API
	final Client _http;

	TodoListService(this._http);
	
	// List<String> mockTodoList = <String>[];

	// Future<List<String>> getTodoList() async => mockTodoList; // @deprecated

	Future<List<Todo>> getTodoList() async {
		try {
			final response = await _http.get(_url + "/all");
			final todos = (_extractData(response) as List)
					.map((value) => Todo.fromJson(value))
					.toList();
			return todos;
		} catch (e) {
			throw _handleError(e);
		}
	}

	Future<Todo> create(String label) async {
		try {
			final response = await _http.post(_url + "/new",
					headers: _headers, body: json.encode({'label': label}));
			return Todo.fromJson(_extractData(response));
		} catch (e) {
			throw _handleError(e);
		}
	}

	Future<void> delete(int id) async {
		try {
			await _http.delete(_url + "/delete?id=" + id.toString(),
					headers: _headers);
			// return Todo.fromJson(_extractData(response));
		} catch (e) {
			throw _handleError(e);
		}
	}

	Exception _handleError(dynamic e) {
		print(e); // for demo purposes only
		return Exception('Server error; cause: $e');
	}

	dynamic _extractData(Response resp) => json.decode(resp.body);
}
