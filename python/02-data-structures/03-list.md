# Lists in Python

## Introduction

A list is one of the most commonly used data structures in Python. It is an ordered, mutable collection that can store multiple values in a single variable.

Lists are used when you need:
- A group of related values
- Ordered data
- A collection that can be changed after creation
- Duplicate values
- Mixed data types in one structure

### Example

```python
fruits = ["apple", "banana", "mango"]
print(fruits)
```

---

## When to Use Lists

Lists are ideal in these situations:

### 1. **When You Need to Store Multiple Related Values**
```python
students = ["Alice", "Bob", "Charlie", "Diana"]
```

### 2. **When You Need to Maintain Order**
- The sequence of items matters (e.g., leaderboard, timeline)

```python
daily_temperatures = [22, 23, 25, 24, 26]
```

### 3. **When You Need to Add/Remove Items Dynamically**
- Your collection size changes over time

```python
shopping_cart = ["milk", "bread"]
shopping_cart.append("eggs")  # Adding items
shopping_cart.remove("milk")   # Removing items
```

### 4. **When You Have Duplicate Values**
- Other data structures like sets eliminate duplicates

```python
votes = ["A", "B", "A", "C", "A", "B"]  # Duplicates are allowed
```

### 5. **When You Need to Access Items by Position**
- You need to get the 1st item, 3rd item, last item, etc.

```python
items = [10, 20, 30, 40]
print(items[0])      # First item
print(items[-1])     # Last item
print(items[2])      # Third item
```

### 6. **When You Need Mixed Data Types**
- One list can hold strings, numbers, booleans, etc.

```python
mixed_data = ["Alice", 25, True, 3.14]
```

---

## Why to Use Lists

### 1. **Flexibility**
Lists are mutable, so you can change them after creation. Unlike tuples (immutable), lists can grow, shrink, and be modified.

```python
# List - Can be modified
numbers = [1, 2, 3]
numbers[0] = 10  # ✓ Works
numbers.append(4)  # ✓ Works

# Tuple - Cannot be modified
numbers_tuple = (1, 2, 3)
# numbers_tuple[0] = 10  # ✗ Error
```

### 2. **Easy to Search and Filter**
Built-in methods make finding and filtering data simple.

```python
fruits = ["apple", "banana", "apple", "orange"]

# Check if item exists
print("banana" in fruits)  # True

# Find position
print(fruits.index("banana"))  # 1

# Count occurrences
print(fruits.count("apple"))  # 2

# Filter items
filtered = [f for f in fruits if f != "apple"]
```

### 3. **Efficient for Sequential Access**
Iterating through a list is fast and straightforward.

```python
for item in items:
	print(item)
```

### 4. **Rich Built-in Methods**
Lists come with many useful methods: `append()`, `extend()`, `remove()`, `sort()`, `reverse()`, `pop()`, `insert()`, `clear()`, `copy()`, `index()`, `count()`

```python
numbers = [3, 1, 4, 1, 5]
numbers.sort()          # Sort in place
numbers.reverse()       # Reverse in place
numbers.clear()         # Remove all items
```

### 5. **Support for Comprehensions**
List comprehensions provide elegant syntax for creating and transforming lists.

```python
# Traditional way
squares = []
for i in range(1, 6):
	squares.append(i ** 2)

# List comprehension (more Pythonic)
squares = [i ** 2 for i in range(1, 6)]
```

### 6. **Works with Unpacking**
Lists can be unpacked to assign multiple variables at once.

```python
coordinates = [10, 20, 30]
x, y, z = coordinates

names = ["Alice", "Bob", "Charlie"]
first, second, *rest = names
print(first, rest)
```

---

## Purpose of Lists

### 1. **Data Collection**
Gather multiple items in one place for processing.

```python
# Collect user inputs
user_ids = [101, 102, 103, 104, 105]
```

### 2. **Data Aggregation**
Combine related data for analysis or reporting.

```python
# Monthly sales data
sales = [1000, 1200, 1100, 1500, 1300]
print(f"Average: {sum(sales) / len(sales)}")
```

### 3. **Data Transformation**
Modify, filter, or restructure data.

```python
# Convert to uppercase
names = ["alice", "bob", "charlie"]
names_upper = [name.upper() for name in names]
```

### 4. **Building Sequential Workflows**
Maintain the order of items (tasks, steps, events).

```python
# Task queue (order matters)
tasks = ["login", "verify", "process", "logout"]

for task in tasks:
	print(f"Executing: {task}")
```

### 5. **Caching and Temporary Storage**
Store results temporarily during computation.

```python
# Store results of calculations
results = []

for number in range(1, 6):
	result = number ** 2
	results.append(result)

print(results)
```

### 6. **Building Complex Data Structures**
Combine lists with other data types (nested lists, lists of dictionaries).

```python
# List of student records
students = [
	{"name": "Alice", "age": 20, "gpa": 3.8},
	{"name": "Bob", "age": 21, "gpa": 3.5},
	{"name": "Charlie", "age": 19, "gpa": 3.9}
]

for student in students:
	print(f"{student['name']}: GPA {student['gpa']}")
```

### 7. **Iteration and Repetition**
Efficiently loop through collections.

```python
prices = [19.99, 29.99, 39.99]

for price in prices:
	discounted = price * 0.9
	print(f"Original: ${price:.2f}, Discounted: ${discounted:.2f}")
```

### 8. **Comparison with Other Data Structures**

| Data Structure | Ordered | Mutable | Allows Duplicates | Use Case |
|---|---|---|---|---|
| **List** | Yes | Yes | Yes | Dynamic collections that need ordering |
| **Tuple** | Yes | No | Yes | Immutable sequences, dictionary keys |
| **Set** | No | Yes | No | Unique items, fast lookup |
| **Dictionary** | Yes (Python 3.7+) | Yes | No | Key-value pairs, fast lookup |

**When to use List vs others:**
- Use **List** when you need order and mutability
- Use **Tuple** when you need immutability (safety, hashing)
- Use **Set** when you only need unique items
- Use **Dictionary** when you need key-value lookups

---

## Key Characteristics of Lists

- **Ordered**: items keep their position
- **Mutable**: items can be changed, added, or removed
- **Allow duplicates**: same value can appear multiple times
- **Dynamic size**: list length can grow or shrink
- **Can store mixed data types**

```python
sample = [10, "Python", True, 3.14]
print(sample)
```

---

## Creating Lists

### Empty List

```python
numbers = []
print(numbers)
```

### List with Values

```python
numbers = [1, 2, 3, 4, 5]
names = ["Alice", "Bob", "Charlie"]
mixed = [10, "Hello", True, 4.5]
```

### Using `list()` Constructor

```python
letters = list("Python")
print(letters)
```

```python
values = list((1, 2, 3))
print(values)
```

---

## Accessing List Elements

Lists use zero-based indexing.

```python
fruits = ["apple", "banana", "mango", "orange"]

print(fruits[0])
print(fruits[1])
print(fruits[-1])
print(fruits[-2])
```

### Common Notes

- `fruits[0]` gives the first item
- `fruits[-1]` gives the last item
- Accessing an invalid index raises `IndexError`

---

## Slicing Lists

Slicing returns a portion of the list.

### Syntax

```python
list[start:stop:step]
```

### Examples

```python
numbers = [10, 20, 30, 40, 50, 60]

print(numbers[1:4])
print(numbers[:3])
print(numbers[3:])
print(numbers[::2])
print(numbers[::-1])
```

---

## Updating List Elements

Because lists are mutable, you can modify elements directly.

```python
fruits = ["apple", "banana", "mango"]
fruits[1] = "grapes"
print(fruits)
```

### Update a Slice

```python
numbers = [1, 2, 3, 4, 5]
numbers[1:3] = [20, 30]
print(numbers)
```

---

## Adding Elements to a List

### `append()`

Adds one item to the end of the list.

```python
numbers = [1, 2, 3]
numbers.append(4)
print(numbers)
```

### `extend()`

Adds multiple items from another iterable.

```python
numbers = [1, 2, 3]
numbers.extend([4, 5, 6])
print(numbers)
```

### `insert()`

Adds an item at a specific index.

```python
names = ["Alice", "Charlie"]
names.insert(1, "Bob")
print(names)
```

---

## Removing Elements from a List

### `remove()`

Removes the first matching value.

```python
fruits = ["apple", "banana", "mango", "banana"]
fruits.remove("banana")
print(fruits)
```

### `pop()`

Removes and returns an item by index.

```python
numbers = [10, 20, 30, 40]
removed = numbers.pop()
print(removed)
print(numbers)
```

```python
removed = numbers.pop(1)
print(removed)
print(numbers)
```

### `del`

Deletes an item or slice.

```python
values = [1, 2, 3, 4, 5]
del values[2]
print(values)
```

```python
del values[1:3]
print(values)
```

### `clear()`

Removes all items.

```python
items = [1, 2, 3]
items.clear()
print(items)
```

---

## Common List Methods

### `index()`

Finds the index of the first matching value.

```python
fruits = ["apple", "banana", "mango"]
print(fruits.index("banana"))
```

### `count()`

Counts how many times a value appears.

```python
numbers = [1, 2, 2, 3, 2, 4]
print(numbers.count(2))
```

### `sort()`

Sorts the list in place.

```python
numbers = [5, 2, 8, 1, 3]
numbers.sort()
print(numbers)
```

```python
numbers.sort(reverse=True)
print(numbers)
```

### `reverse()`

Reverses the list in place.

```python
values = [1, 2, 3, 4]
values.reverse()
print(values)
```

### `copy()`

Creates a shallow copy of the list.

```python
original = [1, 2, 3]
copied = original.copy()
print(copied)
```

---

## Built-in Functions Used with Lists

```python
numbers = [10, 20, 30, 40]

print(len(numbers))
print(min(numbers))
print(max(numbers))
print(sum(numbers))
print(sorted(numbers, reverse=True))
```

---

## Looping Through Lists

### Basic Loop

```python
fruits = ["apple", "banana", "mango"]

for fruit in fruits:
	print(fruit)
```

### Using `enumerate()`

```python
for index, fruit in enumerate(fruits, start=1):
	print(index, fruit)
```

### Loop with Condition

```python
numbers = [1, 2, 3, 4, 5, 6]

for number in numbers:
	if number % 2 == 0:
		print(number)
```

---

## Membership Testing

You can check whether a value exists in a list.

```python
fruits = ["apple", "banana", "mango"]

print("banana" in fruits)
print("grapes" not in fruits)
```

---

## List Concatenation and Repetition

### Concatenation

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
result = list1 + list2
print(result)
```

### Repetition

```python
values = [1, 2]
print(values * 3)
```

---

## Nested Lists

A list can contain other lists.

```python
matrix = [
	[1, 2, 3],
	[4, 5, 6],
	[7, 8, 9]
]

print(matrix)
print(matrix[0])
print(matrix[1][2])
```

### Iterating Nested Lists

```python
for row in matrix:
	for value in row:
		print(value, end=" ")
	print()
```

---

## List Comprehensions

List comprehensions provide a compact way to create lists.

### Basic Example

```python
squares = [number ** 2 for number in range(1, 6)]
print(squares)
```

### With Condition

```python
even_numbers = [number for number in range(1, 11) if number % 2 == 0]
print(even_numbers)
```

### Converting Values

```python
names = ["alice", "bob", "charlie"]
capitalized = [name.capitalize() for name in names]
print(capitalized)
```

---

## Copying Lists: Important Developer Concept

Lists are mutable, so assignment copies the reference, not the values.

```python
list1 = [1, 2, 3]
list2 = list1
list2[0] = 100

print(list1)
print(list2)
```

### Correct Ways to Copy

```python
list1 = [1, 2, 3]

copy1 = list1.copy()
copy2 = list1[:]
copy3 = list(list1)
```

### Deep Copy for Nested Lists

```python
import copy

original = [[1, 2], [3, 4]]
deep_copied = copy.deepcopy(original)
```

---

## Common Developer Scenarios

### 1. Store Multiple Users

```python
users = ["alice", "bob", "charlie"]
print(users)
```

### 2. Filter Even Numbers

```python
numbers = [1, 2, 3, 4, 5, 6]
even_numbers = [number for number in numbers if number % 2 == 0]
print(even_numbers)
```

### 3. Remove Duplicates

```python
numbers = [1, 2, 2, 3, 4, 4, 5]
unique_numbers = list(set(numbers))
print(unique_numbers)
```

### 4. Find Maximum Value

```python
scores = [78, 92, 85, 88]
print(max(scores))
```

### 5. Sort Records

```python
names = ["Charlie", "Alice", "Bob"]
names.sort()
print(names)
```

---

## Common Mistakes to Avoid

### 1. Index Out of Range

```python
items = [1, 2, 3]
# print(items[5])
```

### 2. Removing a Missing Value

```python
items = [1, 2, 3]
# items.remove(10)
```

This raises `ValueError`.

### 3. Modifying a List While Iterating

```python
numbers = [1, 2, 3, 4, 5]

for number in numbers[:]:
	if number % 2 == 0:
		numbers.remove(number)
```

### 4. Confusing `append()` with `extend()`

```python
items = [1, 2]
items.append([3, 4])
print(items)
```

```python
items = [1, 2]
items.extend([3, 4])
print(items)
```

---

## Best Practices

- Use meaningful list names
- Prefer comprehensions for simple transformations
- Use `.copy()` when a separate list is needed
- Avoid modifying a list during direct iteration unless done carefully
- Use `append()` for one item, `extend()` for many
- Use `sorted()` when you need a new sorted list and want to preserve the original

---

## Practical Examples

### Example 1: Sum of All Numbers

```python
numbers = [10, 20, 30, 40]
total = sum(numbers)
print(total)
```

### Example 2: Find Even Numbers

```python
numbers = [1, 2, 3, 4, 5, 6]

for number in numbers:
	if number % 2 == 0:
		print(number)
```

### Example 3: Student Marks

```python
marks = [85, 90, 78, 92]
average = sum(marks) / len(marks)
print(average)
```

### Example 4: Reverse a List

```python
values = [1, 2, 3, 4, 5]
values.reverse()
print(values)
```

### Example 5: Merge Two Lists

```python
list1 = [1, 2, 3]
list2 = [4, 5, 6]
print(list1 + list2)
```

### Example 6: Nested List Access

```python
matrix = [[1, 2], [3, 4], [5, 6]]
print(matrix[2][1])
```

### Example 7: Capitalize Names

```python
names = ["alice", "bob", "charlie"]
result = [name.capitalize() for name in names]
print(result)
```

### Example 8: Safe Search

```python
fruits = ["apple", "banana", "mango"]

if "banana" in fruits:
	print("Found banana")
```

---

## Summary

Lists are one of the most useful and flexible data structures in Python.

### Important Features

- Ordered
- Mutable
- Allow duplicates
- Can store mixed types

### Common Operations

- Add items with `append()`, `extend()`, `insert()`
- Remove items with `remove()`, `pop()`, `del`, `clear()`
- Search with `index()` and `in`
- Count with `count()`
- Sort with `sort()` or `sorted()`
- Copy with `copy()`

### Quick Example

```python
numbers = [1, 2, 3]
numbers.append(4)
print(numbers)
```

Lists are essential for everyday Python programming, especially when working with collections of data that need to be updated and processed.
