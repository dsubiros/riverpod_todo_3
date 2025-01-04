import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_todo_3/src/todos/todo.dart';
import 'package:riverpod_todo_3/src/todos/todo_state.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

const _uuid = Uuid();

@riverpod
class TodoNotifier extends _$TodoNotifier {
  @override
  TodoState build() {
    return const TodoState(items: []);
  }

  Future<void> add(String description) async {
    state = state.copyWith(isLoading: true);
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 5));

    await AsyncValue.guard(() async {
      state = state.copyWith(
        isLoading: false,
        items: [
          ...state.items,
          Todo(id: _uuid.v4(), description: description),
        ],
      );
    });
  }

  Future<void> remove(Todo target) async {
    state = state.copyWith(isLoading: true);
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 5));

    AsyncValue.guard(() async {
      state = state.copyWith(
          isLoading: false,
          items: state.items.where((item) => item.id != target.id).toList());
    });
  }

  Future<void> edit(String id, String description) async {
    state = state.copyWith(isLoading: true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    AsyncValue.guard(() async {
      state = state.copyWith(
          isLoading: false,
          items: state.items
              .map((item) => item.id != id
                  ? item.copyWith(description: description)
                  : item)
              .toList());
    });
  }

  Future<void> toggle(String id) async {
    state = state.copyWith(isLoading: true);
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 2));

    AsyncValue.guard(() async {
      state = state.copyWith(
          isLoading: false,
          items: state.items
              .map((item) => item.id != id
                  ? item.copyWith(isCompleted: !item.isCompleted)
                  : item)
              .toList());
    });
  }
}
