# Lesson 01: Understanding `.map()` in Dart

## 1. What Is `.map()`?

`.map()` is a method used to go through a collection of items and transform each item into something else.

You can think of it like a small machine:

```text
Input list:  [task data, task data, task data]
Machine:     .map()
Output list: [Task widget, Task widget, Task widget]
```

In Flutter, this is very useful because we often have a list of data and want to turn it into a list of widgets.

## 2. Is `.map()` a Function or a Method?

`.map()` is a method.

A method is a function that belongs to an object.

Example:

```dart
tasksDecoded.map((taskJson) {
  return taskJson;
});
```

Here:

- `tasksDecoded` is the object.
- `.map()` is the method called on that object.
- `(taskJson) { return taskJson; }` is a function passed into `.map()`.

So `.map()` itself is a method, but it receives a function.

## 3. What Objects Can Use `.map()`?

Most commonly, `.map()` is used with collection objects, especially:

- `List`
- `Set`
- `Iterable`

In your todo app, this variable is a list:

```dart
List<dynamic> tasksDecoded = [];
```

That means you can use:

```dart
tasksDecoded.map(...)
```

because `tasksDecoded` is a list.

## 4. Tiny Dart Example

Imagine you have this list:

```dart
final numbers = [1, 2, 3];
```

You can use `.map()` to double every number:

```dart
final doubledNumbers = numbers.map((number) {
  return number * 2;
}).toList();

print(doubledNumbers);
```

The result is:

```text
[2, 4, 6]
```

Line by line:

```dart
final numbers = [1, 2, 3];
```

This creates a list of numbers.

```dart
numbers.map((number) {
```

This tells Dart: "Go through each number in the list."

```dart
return number * 2;
```

For each number, return a new doubled number.

```dart
}).toList();
```

Turn the result back into a normal list.

## 5. Why Do We Use `.toList()`?

In Dart, `.map()` does not directly return a `List`.

It returns an `Iterable`.

For beginners, you can think of an `Iterable` as something Dart can loop through, but it is not exactly the same as a normal list.

So when you want a real list, you write:

```dart
.toList()
```

Example:

```dart
final taskNames = ['Study', 'Code', 'Sleep'];

final textWidgets = taskNames.map((name) {
  return Text(name);
}).toList();
```

Now `textWidgets` is a list of `Text` widgets.

## 6. What Is the Difference Between `Iterable` and `List`?

Both `Iterable` and `List` can hold many items.

The simple difference is:

```text
Iterable = something you can go through one item at a time
List     = something you can go through, and also access by position
```

You can think of an `Iterable` like a line of people walking past you.

You can see each person one by one:

```text
first person -> second person -> third person
```

A `List` is more like a numbered shelf:

```text
position 0: first task
position 1: second task
position 2: third task
```

Because a `List` has positions, you can ask for a specific item directly.

Example:

```dart
final taskNames = ['Pray', 'Study Flutter', 'Clean room'];

print(taskNames[0]);
print(taskNames[1]);
```

The result is:

```text
Pray
Study Flutter
```

This works because `taskNames` is a `List`.

## 7. Why Does `.map()` Return an `Iterable`?

When you use `.map()`, Dart gives you an `Iterable` first:

```dart
final taskNames = ['Pray', 'Study Flutter', 'Clean room'];

final textWidgets = taskNames.map((name) {
  return Text(name);
});
```

Here, `textWidgets` is an `Iterable<Text>`.

It is like Dart saying:

```text
I know how to create these Text widgets one by one when you need them.
```

But many Flutter widget properties want a real `List`.

For example, `Column.children` expects:

```dart
List<Widget>
```

That is why we add `.toList()`:

```dart
final textWidgets = taskNames.map((name) {
  return Text(name);
}).toList();
```

Now `textWidgets` is a `List<Text>`.

## 8. Tiny Comparison Example

Here is an example without `.toList()`:

```dart
final names = ['Ahmed', 'Sara', 'Omar'];

final result = names.map((name) {
  return name.toUpperCase();
});

print(result);
```

The result looks like this:

```text
(AHMED, SARA, OMAR)
```

Notice the round brackets:

```text
( )
```

That usually tells you this is an `Iterable`.

Now add `.toList()`:

```dart
final names = ['Ahmed', 'Sara', 'Omar'];

final result = names.map((name) {
  return name.toUpperCase();
}).toList();

print(result);
```

The result looks like this:

```text
[AHMED, SARA, OMAR]
```

Notice the square brackets:

```text
[ ]
```

That tells you this is a `List`.

## 9. Quick Table

| Question | `Iterable` | `List` |
| --- | --- | --- |
| Can it hold many items? | Yes | Yes |
| Can you loop through it? | Yes | Yes |
| Can you use `.map()` on it? | Yes | Yes |
| Can you use `[0]` to get the first item? | Not usually | Yes |
| Does Flutter `Column.children` accept it directly? | No | Yes |

So for Flutter widgets, this is very common:

```dart
children: items.map((item) {
  return Text(item);
}).toList(),
```

## 10. Connecting `.map()` to Your Todo App

In your app, you save tasks in `SharedPreferences`.

When you read them back, you decode them here in `home_screen.dart`:

```dart
final task = pref.getString('tasks');
tasksDecoded = jsonDecode(task ?? "[]");
```

The decoded data looks like a list of task maps:

```dart
[
  {
    "taskName": "Study Flutter",
    "taskDescription": "Learn the map method",
    "isHighPrioirty": true
  }
]
```

Each item is one saved task.

You can use `.map()` to turn each saved task into a `Task` object:

```dart
final tasks = tasksDecoded.map((taskJson) {
  return Task(
    taskName: taskJson['taskName'],
    taskDescription: taskJson['taskDescription'],
    isHighPriority: taskJson['isHighPrioirty'],
  );
}).toList();
```

This means:

```dart
tasksDecoded.map((taskJson) {
```

Go through every saved task.

```dart
return Task(
```

Create a real `Task` object from that saved data.

```dart
}).toList();
```

Collect all the new `Task` objects into a list.

## 11. Using `.map()` to Show Tasks on the Screen

One of the most common Flutter uses for `.map()` is turning data into widgets.

Example:

```dart
Column(
  children: tasksDecoded.map((taskJson) {
    return ListTile(
      title: Text(taskJson['taskName']),
      subtitle: Text(taskJson['taskDescription']),
    );
  }).toList(),
)
```

This means:

```text
For every saved task,
create one ListTile widget,
then show all ListTile widgets inside the Column.
```

If you have 3 saved tasks, `.map()` creates 3 `ListTile` widgets.

## 12. Important Note About Your App

In `add_task.dart`, your saved key is currently:

```dart
"isHighPrioirty": isHighPriority,
```

Notice the spelling:

```text
isHighPrioirty
```

That is misspelled. It should probably be:

```text
isHighPriority
```

But if you already saved data using the misspelled key, your reading code must use the same key until you fix both places together.

So this works with your current saved data:

```dart
isHighPriority: taskJson['isHighPrioirty'],
```

Later, you can rename the saved key carefully in both files.

## 13. Quick Practice

You have this list:

```dart
final taskNames = ['Pray', 'Study Flutter', 'Clean room'];
```

Use `.map()` to turn it into a list of `Text` widgets:

```dart
final widgets = taskNames.map((name) {
  return Text(name);
}).toList();
```

Question:

If `taskNames` has 3 strings, how many `Text` widgets will `.map()` create?

Answer:

```text
3 Text widgets
```

## 14. Remember This

`.map()` is for transformation.

It answers this question:

```text
How can I turn every item in this list into a new item?
```

In your todo app:

```text
saved task data -> Task objects
saved task data -> ListTile widgets
task names -> Text widgets
```

That is the heart of `.map()`.

Also remember:

```text
.map() gives you an Iterable.
.toList() changes that Iterable into a List.
```
