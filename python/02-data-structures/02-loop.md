# Loops in Python

## Introduction

Loops are used to repeat a block of code multiple times. They are one of the most important control-flow tools in Python because they help automate repetitive tasks and process collections of data efficiently.

Developers use loops for:
- Iterating through lists, tuples, sets, and dictionaries
- Repeating tasks until a condition is met
- Reading files line by line
- Processing datasets
- Generating reports and summaries
- Building automation scripts

Python mainly provides two types of loops:
- `for` loop
- `while` loop

---

## Why Loops Matter

Without loops, you would need to write the same code again and again.

```python
print("Hello")
print("Hello")
print("Hello")
```

Using a loop:

```python
for _ in range(3):
	print("Hello")
```

Loops make code shorter, cleaner, and easier to maintain.

---

## The `for` Loop

The `for` loop is used to iterate over a sequence such as a string, list, tuple, set, dictionary, or range.

### Syntax

```python
for variable in sequence:
	# code block
```

### Example

```python
fruits = ["apple", "banana", "mango"]

for fruit in fruits:
	print(fruit)
```

### How It Works

- Python takes one item at a time from the sequence
- Assigns it to the loop variable
- Executes the indented block
- Repeats until the sequence ends

---

## Using `range()` with `for`

The `range()` function is commonly used with loops when you want to repeat something a fixed number of times.

### Examples

```python
for i in range(5):
	print(i)
```

Output:

```python
0
1
2
3
4
```

### Common `range()` Forms

```python
range(stop)
range(start, stop)
range(start, stop, step)
```

### Examples

```python
for i in range(1, 6):
	print(i)
```

```python
for i in range(2, 11, 2):
	print(i)
```

```python
for i in range(10, 0, -1):
	print(i)
```

---

## Looping Through Strings

Strings are sequences, so you can loop through each character.

```python
word = "Python"

for char in word:
	print(char)
```

---

## Looping Through Lists

```python
numbers = [10, 20, 30, 40]

for number in numbers:
	print(number)
```

### Processing Values

```python
numbers = [1, 2, 3, 4, 5]

for number in numbers:
	print(number * 2)
```

---

## Looping Through Tuples

```python
colors = ("red", "green", "blue")

for color in colors:
	print(color)
```

---

## Looping Through Sets

Sets are unordered collections, so the output order may vary.

```python
unique_numbers = {1, 2, 3, 4}

for number in unique_numbers:
	print(number)
```

---

## Looping Through Dictionaries

By default, looping through a dictionary gives you keys.

```python
student = {"name": "Alice", "age": 21, "grade": "A"}

for key in student:
	print(key)
```

### Loop Through Keys and Values

```python
for key, value in student.items():
	print(key, value)
```

### Loop Through Only Keys

```python
for key in student.keys():
	print(key)
```

### Loop Through Only Values

```python
for value in student.values():
	print(value)
```

---

## The `while` Loop

The `while` loop repeats as long as a condition remains true.

### Syntax

```python
while condition:
	# code block
```

### Example

```python
count = 1

while count <= 5:
	print(count)
	count += 1
```

### Important Note

Make sure the condition eventually becomes false. Otherwise, you create an infinite loop.

---

## Infinite Loops

An infinite loop never ends unless it is manually stopped or interrupted with a `break`.

```python
# Example of an infinite loop
# while True:
#     print("Running forever")
```

Infinite loops can be useful in:
- Game loops
- Server processes
- Continuous monitoring systems
- Menu-driven programs

But they must be controlled properly.

---

## `break` Statement

The `break` statement immediately exits a loop.

```python
for number in range(1, 10):
	if number == 5:
		break
	print(number)
```

### Use Cases

- Stop when a match is found
- Exit after an error condition
- Terminate user-driven loops

---

## `continue` Statement

The `continue` statement skips the current iteration and moves to the next one.

```python
for number in range(1, 6):
	if number == 3:
		continue
	print(number)
```

---

## `pass` Statement

The `pass` statement does nothing. It acts as a placeholder.

```python
for number in range(3):
	pass
```

This is useful when writing code structure before adding logic.

---

## Nested Loops

A loop inside another loop is called a nested loop.

```python
for i in range(1, 4):
	for j in range(1, 4):
		print(i, j)
```

### Common Use Cases

- Matrix processing
- Pattern printing
- Comparing combinations
- Table generation

---

## The `else` Block with Loops

Python allows an `else` block with loops.

### `for...else`

```python
for number in range(3):
	print(number)
else:
	print("Loop finished successfully")
```

### `while...else`

```python
count = 1

while count <= 3:
	print(count)
	count += 1
else:
	print("While loop completed")
```

The `else` block runs only if the loop ends normally, not if it stops because of `break`.

---

## Using `enumerate()` in Loops

`enumerate()` is useful when you need both index and value.

```python
fruits = ["apple", "banana", "mango"]

for index, fruit in enumerate(fruits):
	print(index, fruit)
```

You can also start indexing from a custom value:

```python
for index, fruit in enumerate(fruits, start=1):
	print(index, fruit)
```

---

## Using `zip()` in Loops

`zip()` lets you iterate over multiple sequences together.

```python
names = ["Alice", "Bob", "Charlie"]
scores = [85, 90, 88]

for name, score in zip(names, scores):
	print(name, score)
```

---

## Looping with Comprehensions

Python provides a short syntax for creating collections.

### List Comprehension

```python
squares = [number ** 2 for number in range(1, 6)]
print(squares)
```

### Conditional List Comprehension

```python
even_numbers = [number for number in range(1, 11) if number % 2 == 0]
print(even_numbers)
```

Comprehensions are compact, but regular loops are often better when logic is more complex.

---

## Common Developer Scenarios

### 1. Sum of Numbers

```python
numbers = [10, 20, 30, 40]
total = 0

for number in numbers:
	total += number

print(total)
```

### 2. Search for an Item

```python
users = ["alice", "bob", "charlie"]
target = "bob"

for user in users:
	if user == target:
		print("User found")
		break
```

### 3. Password Attempts

```python
attempts = 0

while attempts < 3:
	print("Try password")
	attempts += 1
```

### 4. Multiplication Table

```python
for i in range(1, 6):
	print(f"5 x {i} = {5 * i}")
```

### 5. Reading File Lines

```python
# with open("data.txt", "r") as file:
#     for line in file:
#         print(line.strip())
```

---

## Common Mistakes to Avoid

### 1. Infinite `while` Loops

```python
# Wrong
# count = 1
# while count <= 5:
#     print(count)

# Correct
count = 1
while count <= 5:
	print(count)
	count += 1
```

### 2. Modifying a List While Iterating Over It

This can create unexpected behavior.

```python
numbers = [1, 2, 3, 4]

for number in numbers[:]:
	if number % 2 == 0:
		numbers.remove(number)
```

### 3. Unclear Loop Variables

```python
# Better
for student_name in ["Alice", "Bob"]:
	print(student_name)
```

Avoid names like `x` unless the meaning is obvious.

### 4. Using Nested Loops Without Need

Nested loops can increase time complexity. Use them only when necessary.

---

## Best Practices

- Use `for` loops when iterating over sequences
- Use `while` loops when repetition depends on a condition
- Prefer meaningful loop variable names
- Use `break` and `continue` carefully
- Keep nested loops readable
- Use `enumerate()` when index is needed
- Use `zip()` for parallel iteration
- Use comprehensions only when they improve clarity

---

## Practical Examples

### Example 1: Print Numbers from 1 to 5

```python
for number in range(1, 6):
	print(number)
```

### Example 2: Countdown Using `while`

```python
count = 5

while count > 0:
	print(count)
	count -= 1
```

### Example 3: Find Even Numbers

```python
for number in range(1, 11):
	if number % 2 == 0:
		print(number)
```

### Example 4: Pattern Printing

```python
for row in range(1, 6):
	print("*" * row)
```

### Example 5: Sum of First 10 Natural Numbers

```python
total = 0

for number in range(1, 11):
	total += number

print(total)
```

### Example 6: Dictionary Iteration

```python
student = {"name": "Alice", "age": 20, "course": "Python"}

for key, value in student.items():
	print(f"{key}: {value}")
```

### Example 7: Skip Specific Value

```python
for number in range(1, 6):
	if number == 3:
		continue
	print(number)
```

### Example 8: Stop Loop Early

```python
for number in range(1, 10):
	if number == 6:
		break
	print(number)
```

---

## Summary

Loops help repeat work efficiently.

### Main Types

- `for` loop
- `while` loop

### Useful Keywords

- `break`
- `continue`
- `pass`
- `else`

### Important Concepts

- Use `range()` for numeric repetition
- Use `enumerate()` for index plus value
- Use `zip()` for multiple sequences
- Avoid infinite loops unless intentional
- Keep loops simple and readable

### Quick Example

```python
for number in range(1, 4):
	print(number)
```

Loops are one of the main tools used in Python to process data, automate repetition, and control program execution.
