# Lesson 04: Understanding `initState()` and `setState()` in `todo_tasks.dart`

## 1. The Big Idea

In a `StatefulWidget`, Flutter gives you a `State` object that can change over time.

In your file, that state is here:

```dart
class _TodoTasksState extends State<TodoTasks> {
  List<Task> taskMapped = [];
}
```

The variable `taskMapped` is the changing data for this screen.

You can think of it like this:

```text
State = the data this screen is currently using
build() = draws the screen using that data
setState() = tells Flutter: "My data changed, draw again"
initState() = runs once when the screen starts
```

That is the main mental model to remember.

## 2. Where `initState()` Is in Your File

In [todo_tasks.dart](/abs/path/C:/Flutter_Project/todo_app/lib/screens/todo_tasks.dart:16), you have:

```dart
void initState() {
  super.initState();
  _loadTasks();
}
```

This method runs one time when the `TodoTasks` screen is created.

It does not run every time `build()` runs.

Its job is usually:

- start loading data
- prepare controllers
- start animations
- do one-time setup for the screen

In your file, `initState()` is used to load saved tasks from `SharedPreferences`.

So the meaning is:

```text
When this screen opens for the first time,
go get the saved tasks.
```

## 3. Why `super.initState()` Comes First

This line matters:

```dart
super.initState();
```

It lets Flutter do its own setup before your custom code runs.

A simple rule:

```text
When overriding initState(), call super.initState() first.
```

## 4. What Happens After `initState()` Runs

Right after `initState()`, your code calls:

```dart
_loadTasks();
```

That method is here:

```dart
void _loadTasks() async {
  final pref = await SharedPreferences.getInstance();
  final task = pref.getString('tasks');

  if (task != null) {
    final List<dynamic> tasksDecoded = jsonDecode(task);
    taskMapped = tasksDecoded
        .map((element) => Task.fromJson(element))
        .toList();
  }

  setState(() {
    taskMapped = taskMapped.where((task) => task.isDone == false).toList();
  });
}
```

The flow is:

```text
1. Screen starts
2. initState() runs once
3. _loadTasks() reads saved data
4. taskMapped gets new task values
5. setState() tells Flutter to rebuild the screen
6. build() runs again with the updated task list
```

## 5. Why `initState()` Is Better Than `build()` for Loading

It would be a bad idea to call `_loadTasks()` directly inside `build()`.

Why?

Because `build()` can run many times.

If `_loadTasks()` were inside `build()`, your app might reload saved tasks again and again.

But `initState()` runs once, so it is the right place for first-time loading.

## 6. Where `setState()` Is in Your File

Your first `setState()` is here in [todo_tasks.dart](/abs/path/C:/Flutter_Project/todo_app/lib/screens/todo_tasks.dart:34):

```dart
setState(() {
  taskMapped = taskMapped.where((task) => task.isDone == false).toList();
});
```

Your second `setState()` is here in [todo_tasks.dart](/abs/path/C:/Flutter_Project/todo_app/lib/screens/todo_tasks.dart:47):

```dart
setState(() {
  taskMapped[index!].isDone = value ?? false;
  Future.delayed(Duration(milliseconds: 500), () {
    _loadTasks();
  });
});
```

## 7. What `setState()` Really Means

`setState()` does not directly redraw the UI by itself.

It tells Flutter:

```text
The data used by this screen changed.
Please run build() again.
```

So this:

```dart
setState(() {
  taskMapped = ...
});
```

means:

```text
1. change the state
2. ask Flutter to rebuild the screen
```

## 8. How the First `setState()` Works in Your Screen

After tasks are loaded from storage, your code filters them:

```dart
taskMapped = taskMapped.where((task) => task.isDone == false).toList();
```

This keeps only tasks that are not done.

Then because that happens inside `setState()`, Flutter rebuilds the widget tree.

That rebuild updates this line:

```dart
TasksListWidget(task: taskMapped, ...)
```

So the list on the screen shows the newest value of `taskMapped`.

## 9. How the Second `setState()` Works in Your Screen

When the user changes a task checkbox, this code runs:

```dart
onTaskChanged: (value, index) async {
  setState(() {
    taskMapped[index!].isDone = value ?? false;
  });
}
```

This means:

```text
The user interacted with the screen.
One task changed.
Update that task in memory.
Rebuild the screen.
```

So if a checkbox becomes checked, the UI can react immediately because `setState()` tells Flutter to rebuild.

## 10. Important Difference Between `initState()` and `setState()`

This is the heart of the lesson:

| Method | Purpose |
| --- | --- |
| `initState()` | run setup code once when the screen starts |
| `setState()` | tell Flutter the screen's data changed and it should rebuild |

A simple way to remember it:

```text
initState() = start-up
setState() = update
```

## 11. What `build()` Has To Do With Both of Them

Your `build()` method is here in [todo_tasks.dart](/abs/path/C:/Flutter_Project/todo_app/lib/screens/todo_tasks.dart:40).

`build()` reads the current value of `taskMapped`:

```dart
child: TasksListWidget(task: taskMapped, ...)
```

So:

- `initState()` helps fill `taskMapped` the first time
- `setState()` tells Flutter when `taskMapped` changed
- `build()` uses the latest `taskMapped` value to draw the UI

These three parts work together.

## 12. A Beginner Analogy

Think of your screen like a whiteboard.

- `taskMapped` is the information written on the whiteboard
- `build()` is Flutter drawing the whiteboard
- `initState()` is the first time you prepare the board
- `setState()` is saying, "I changed what is written, please redraw it"

Without `setState()`, Flutter may not know the whiteboard content changed.

## 13. One Important Improvement in Your Current Code

This part works, but it is not the cleanest pattern:

```dart
setState(() {
  taskMapped[index!].isDone = value ?? false;
  Future.delayed(Duration(milliseconds: 500), () {
    _loadTasks();
  });
});
```

Why is that a little awkward?

Because the best practice is:

```text
Put only the state change inside setState().
Do async work or delayed work outside setState().
```

A cleaner version would look like this:

```dart
setState(() {
  taskMapped[index!].isDone = value ?? false;
});

Future.delayed(Duration(milliseconds: 500), () {
  _loadTasks();
});
```

Why is this cleaner?

Because `setState()` should focus on:

```text
change local state now
```

not:

```text
schedule other work for later
```

## 14. Another Small Improvement

It is also a good habit to write:

```dart
@override
void initState() {
  super.initState();
  _loadTasks();
}
```

Your method works without `@override`, but adding it helps readability and lets Dart warn you if the method name is wrong.

## 15. Predict Before Reading the Answer

Try to answer this first:

If you remove `setState()` from `_loadTasks()`, what might happen?

### Hint

Think about this question:

```text
How will Flutter know that taskMapped changed?
```

### Answer

Flutter may not rebuild the screen after the tasks are loaded.

That means `taskMapped` could contain the new data in memory, but the UI might still show the old screen until another rebuild happens.

## 16. Tiny Practice

Try to explain these two lines in your own words:

```dart
_loadTasks();
```

and

```dart
setState(() {
  taskMapped[index!].isDone = value ?? false;
});
```

Expected meaning:

```text
_loadTasks() = get saved tasks when the screen starts
setState(...) = update one task and tell Flutter to redraw the screen
```

## 17. Remember This

When you see this screen in your app, think:

```text
initState() starts the loading
taskMapped stores the current tasks
setState() announces changes
build() shows the latest tasks
```

That is how `initState()` and `setState()` work together in your `todo_tasks.dart` file.

## 18. Next Practice Step

A great next exercise would be:

1. Add a temporary `print('initState ran');` inside `initState()`
2. Add a temporary `print('build ran');` inside `build()`
3. Tap a checkbox and watch which one runs again

You should notice:

- `initState()` runs once when the screen opens
- `build()` runs many times
- `setState()` causes `build()` to run again
