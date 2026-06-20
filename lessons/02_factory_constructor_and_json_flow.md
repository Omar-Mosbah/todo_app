# Lesson 02: Factory Constructor and JSON Flow

## 1. What Is a Factory Constructor?

A factory constructor is a special constructor that creates an object for you.

In your todo app, it is used to create a `Task` object from saved JSON data.

Your `Task` class has this:

```dart
factory Task.fromJson(Map<String, dynamic> json) {
  return Task(
    taskName: json["taskName"],
    taskDescription: json["taskDescription"],
    isHighPriority: json["isHighPriority"],
  );
}
```

The name is:

```dart
Task.fromJson
```

You can read it like this:

```text
Create a Task from JSON data.
```

## 2. First, What Is a Constructor?

A constructor is the code used to create a new object from a class.

Your normal `Task` constructor is:

```dart
const Task({
  required this.taskName,
  required this.taskDescription,
  required this.isHighPriority,
});
```

You use it like this:

```dart
final task = Task(
  taskName: 'Study Flutter',
  taskDescription: 'Learn factory constructors',
  isHighPriority: true,
);
```

This creates a real `Task` object.

## 3. Normal Constructor vs Factory Constructor

Use the normal constructor when you already have clean values:

```dart
Task(
  taskName: 'Study Flutter',
  taskDescription: 'Learn factory constructors',
  isHighPriority: true,
)
```

Use the factory constructor when you have raw saved data:

```dart
Task.fromJson(json)
```

The raw saved data looks like this:

```dart
{
  "taskName": "Study Flutter",
  "taskDescription": "Learn factory constructors",
  "isHighPriority": true
}
```

That raw data is a `Map<String, dynamic>`.

So:

```text
normal constructor = clean values -> Task
factory constructor = raw map/json data -> Task
```

## 4. Why Did the Instructor Use It?

The instructor used `Task.fromJson()` because your app saves tasks in `SharedPreferences`.

`SharedPreferences` cannot directly save a `Task` object.

It can save simple data, like:

- `String`
- `int`
- `bool`
- `double`
- `List<String>`

So your app needs to convert between two worlds:

```text
Dart object world <-> saved JSON string world
```

In your app:

```text
Task object -> Map -> JSON string -> SharedPreferences
```

And later:

```text
SharedPreferences -> JSON string -> Map -> Task object
```

The factory constructor handles this part:

```text
Map -> Task object
```

## 5. The Two Helper Methods in `Task`

Your `Task` model has two important helpers.

### `toJson()`

```dart
Map<String, dynamic> toJson() => {
  'taskName': taskName,
  'taskDescription': taskDescription,
  'isHighPriority': isHighPriority,
};
```

This converts a `Task` object into a map.

You can read it like this:

```text
Task -> Map
```

Example:

```dart
final task = Task(
  taskName: 'Study Flutter',
  taskDescription: 'Learn JSON',
  isHighPriority: true,
);

final taskMap = task.toJson();
```

Now `taskMap` looks like:

```dart
{
  "taskName": "Study Flutter",
  "taskDescription": "Learn JSON",
  "isHighPriority": true
}
```

### `Task.fromJson()`

```dart
factory Task.fromJson(Map<String, dynamic> json) {
  return Task(
    taskName: json["taskName"],
    taskDescription: json["taskDescription"],
    isHighPriority: json["isHighPriority"],
  );
}
```

This converts a map into a `Task` object.

You can read it like this:

```text
Map -> Task
```

Example:

```dart
final taskMap = {
  "taskName": "Study Flutter",
  "taskDescription": "Learn JSON",
  "isHighPriority": true,
};

final task = Task.fromJson(taskMap);
```

Now `task` is a real `Task` object again.

## 6. Full Save Flow in Your App

This happens in `add_task.dart`.

First, the user writes the task name and description.

Then your app creates a `Task` object:

```dart
final task = Task(
  taskName: taskNameController.text,
  taskDescription: taskDescController.text,
  isHighPriority: isHighPriority,
);
```

At this moment, the data is a real Dart object:

```text
Task object
```

Then you add it to the saved list:

```dart
tasksList.add(task.toJson());
```

This is important.

You are not saving the `Task` object directly.

You are saving the result of:

```dart
task.toJson()
```

So the flow becomes:

```text
Task object -> Map
```

Then you encode the list:

```dart
final encodedTasksList = jsonEncode(tasksList);
```

Now the data becomes a string.

So the flow becomes:

```text
Task object -> Map -> JSON string
```

Finally, you save the string:

```dart
await pref.setString("tasks", encodedTasksList);
```

Complete save flow:

```text
User input
-> Task object
-> task.toJson()
-> Map
-> jsonEncode()
-> JSON string
-> SharedPreferences
```

## 7. Full Load Flow in Your App

This happens in `home_screen.dart`.

First, your app reads the saved string:

```dart
final task = pref.getString('tasks');
```

At this point, `task` is a `String?`.

Then you decode it:

```dart
final List<dynamic> tasksDecoded = jsonDecode(task ?? "[]");
```

Now the saved JSON string becomes a Dart list.

But it is not a `List<Task>` yet.

It is a `List<dynamic>`, and each item inside it is a map.

Example:

```dart
[
  {
    "taskName": "Study Flutter",
    "taskDescription": "Learn factory constructors",
    "isHighPriority": true
  }
]
```

Then you use `.map()`:

```dart
taskMapped = tasksDecoded.map((taskelement) {
  return Task.fromJson(taskelement);
}).toList();
```

This means:

```text
For every decoded task map,
use Task.fromJson(),
create a real Task object,
collect all Task objects into a list.
```

Complete load flow:

```text
SharedPreferences
-> JSON string
-> jsonDecode()
-> List<dynamic>
-> each item is a Map
-> Task.fromJson()
-> List<Task>
```

## 8. Why Not Write the Conversion Directly in `HomeScreen`?

Without `Task.fromJson()`, you would write this in `home_screen.dart`:

```dart
taskMapped = tasksDecoded.map((taskelement) {
  return Task(
    taskName: taskelement["taskName"],
    taskDescription: taskelement["taskDescription"],
    isHighPriority: taskelement["isHighPriority"],
  );
}).toList();
```

This works, but it puts model conversion logic inside the screen.

With `Task.fromJson()`, the screen becomes cleaner:

```dart
taskMapped = tasksDecoded.map((taskelement) {
  return Task.fromJson(taskelement);
}).toList();
```

Now the `Task` class is responsible for knowing how to build a task from saved data.

That is better because:

- The code is easier to read.
- The conversion logic is in one place.
- If the `Task` fields change later, you update `task.dart`.
- Your screen focuses on showing the UI, not converting data.

## 9. Why Is It Called `factory`?

You can think of a factory like a place that produces objects.

A car factory produces cars.

A `Task.fromJson` factory produces `Task` objects from JSON maps.

```text
JSON map goes in -> Task object comes out
```

In code:

```dart
final task = Task.fromJson(taskMap);
```

This line says:

```text
Use the Task factory to create a Task from this map.
```

## 10. Important Detail: The Keys Must Match

This part depends on matching names:

```dart
taskName: json["taskName"],
taskDescription: json["taskDescription"],
isHighPriority: json["isHighPriority"],
```

These keys must match the keys in `toJson()`:

```dart
'taskName': taskName,
'taskDescription': taskDescription,
'isHighPriority': isHighPriority,
```

If you save with this key:

```dart
'isHighPriority'
```

you must read with this key:

```dart
json["isHighPriority"]
```

If the spelling is different, Dart may read `null`, and your app can get an error.

## 11. A Safer Version

Because `jsonDecode()` gives you dynamic data, this version is safer:

```dart
taskMapped = tasksDecoded.map((taskelement) {
  return Task.fromJson(taskelement as Map<String, dynamic>);
}).toList();
```

This line:

```dart
taskelement as Map<String, dynamic>
```

tells Dart:

```text
Treat this decoded item as a map with string keys.
```

That matches what `Task.fromJson()` expects:

```dart
Map<String, dynamic> json
```

## 12. The Full Picture

Here is the full cycle:

```text
1. User types task details.
2. App creates a Task object.
3. task.toJson() converts Task into a Map.
4. jsonEncode() converts the Map/list into a String.
5. SharedPreferences saves the String.
6. HomeScreen reads the String.
7. jsonDecode() converts the String back into List<dynamic>.
8. .map() goes through each decoded item.
9. Task.fromJson() converts each Map into a Task object.
10. .toList() creates a List<Task>.
11. HomeScreen can display the tasks.
```

## 13. Remember This

Use:

```dart
Task(...)
```

when you already have normal values.

Use:

```dart
task.toJson()
```

when you want to save a task.

Use:

```dart
Task.fromJson(...)
```

when you want to load a saved task.

The most important idea:

```text
toJson() sends the object out to storage.
fromJson() brings the object back from storage.
```
