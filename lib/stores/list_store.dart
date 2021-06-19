import 'package:mobx/mobx.dart';
import 'package:todomobx/stores/todo_store.dart';
part 'list_store.g.dart';

class ListStore = _ListStoreBase with _$ListStore;

abstract class _ListStoreBase with Store {
  @observable
  String newTodoTitle = '';

  @observable
  ObservableList<TodoStore> todoList = ObservableList<TodoStore>();

  @action
  void setNewTodoTitle(String value) => newTodoTitle = value;

  @action
  void addTodo() {
    if (newTodoTitle.isNotEmpty)
      todoList.insert(0, TodoStore(title: newTodoTitle));

    newTodoTitle = '';
  }

  @computed
  bool get isFormValid => newTodoTitle.isNotEmpty;
}
