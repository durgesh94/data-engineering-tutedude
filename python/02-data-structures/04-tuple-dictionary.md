# Tuples and Dictionaries in Python

---

# PART 1: TUPLES

## Introduction to Tuples

A tuple is an ordered, immutable collection that can store multiple values in a single variable. Once created, a tuple cannot be changed (no adding, removing, or modifying elements).

Tuples are used when you need:
- Immutable sequences (fixed data)
- Dictionary keys (tuples are hashable)
- Prevent accidental modification
- Performance optimization
- Return multiple values from functions

### Example

```python
coordinates = (10, 20, 30)
print(coordinates)
```

---

## When to Use Tuples

### 1. **When You Need Immutable Data**
```python
# Coordinates that should not change
origin = (0, 0)
# origin[0] = 5  # ✗ Error - tuples are immutable
```

### 2. **When You Need to Use as Dictionary Keys**
```python
# Lists cannot be keys (unhashable)
# But tuples can be!
locations = {
	(10, 20): "Point A",
	(30, 40): "Point B"
}
```

### 3. **When You Want to Prevent Accidental Modifications**
```python
# Protect data from being changed
def get_config():
	return ("localhost", 8080, True)

host, port, debug = get_config()
```

### 4. **When You Need Multiple Return Values from a Function**
```python
def get_user():
	return ("Alice", 25, "alice@email.com")

name, age, email = get_user()
```

### 5. **When You Want Better Performance**
```python
# Tuples are slightly faster than lists
# Tuples use less memory
data_set = (1, 2, 3, 4, 5)
```

### 6. **When You Need Fixed Structure**
```python
# RGB color - always 3 values
red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
```

---

## Why to Use Tuples

### 1. **Immutability = Safety**
```python
# Data cannot be accidentally modified
important_data = (1, 2, 3)
# You cannot accidentally change it
```

### 2. **Can Be Dictionary Keys**
```python
# Unique property of tuples
my_dict = {(1, 1): "cell A", (2, 2): "cell B"}
```

### 3. **Slightly Faster Than Lists**
```python
# Tuples are optimized for immutable operations
coordinates = (10, 20)  # Faster iteration than list
```

### 4. **Can Be Set Elements**
```python
# Lists cannot be in sets, tuples can
points = {(0, 0), (1, 1), (2, 2)}
```

### 5. **Function Return Values**
```python
# Clean way to return multiple values
def calculate():
	return (10, 20, 30)

result1, result2, result3 = calculate()
```

---

## Purpose of Tuples

### 1. **Fixed Data Records**
```python
# Student record - should not change
student = ("Alice", 20, 3.8)
```

### 2. **Dictionary Keys**
```python
# Represent immutable keys
calendar = {
	(2024, 1, 1): "New Year",
	(2024, 12, 25): "Christmas"
}
```

### 3. **Function Parameters and Return Values**
```python
def process_point(point):
	x, y = point
	return (x * 2, y * 2)

result = process_point((5, 10))
```

### 4. **Set Members**
```python
# Unique coordinates in a set
unique_positions = {(0, 0), (1, 1), (2, 2)}
```

### 5. **Unpacking and Multiple Assignment**
```python
# Clean syntax for extracting values
name, age, city = ("Bob", 30, "NYC")
```

### 6. **Data Protection**
```python
# Prevent accidental modification
CONFIG = (
	"database.sqlite",
	"production",
	True
)
# CONFIG[0] = "new_db"  # ✗ Error - protected data
```

---

## Key Characteristics of Tuples

- **Ordered**: Items keep their position
- **Immutable**: Cannot be changed after creation
- **Allow duplicates**: Same value can appear multiple times
- **Hashable**: Can be used as dictionary keys
- **Can store mixed data types**

```python
mixed_tuple = (10, "Python", True, 3.14)
print(mixed_tuple)
```

---

## Creating Tuples

### Empty Tuple

```python
empty = ()
print(empty)
```

### Tuple with Values

```python
numbers = (1, 2, 3, 4, 5)
names = ("Alice", "Bob", "Charlie")
mixed = (10, "Hello", True, 4.5)
```

### Single Element Tuple

```python
single = (42,)
print(single)
print(type(single))
```

### Using `tuple()` Constructor

```python
from_list = tuple([1, 2, 3])
print(from_list)

from_string = tuple("Python")
print(from_string)
```

### Tuple Unpacking in Creation

```python
a, b, c = 1, 2, 3  # Implicit tuple
print((a, b, c))
```

---

## Accessing Tuple Elements

Tuples use zero-based indexing, just like lists.

```python
fruits = ("apple", "banana", "mango", "orange")

print(fruits[0])
print(fruits[1])
print(fruits[-1])
print(fruits[-2])
```

---

## Slicing Tuples

```python
numbers = (10, 20, 30, 40, 50, 60)

print(numbers[1:4])
print(numbers[:3])
print(numbers[3:])
print(numbers[::2])
print(numbers[::-1])
```

---

## Tuple Immutability

One of the key features of tuples is that they cannot be modified.

```python
numbers = (1, 2, 3)

# This will raise an error
# numbers[0] = 10  # ✗ TypeError

# You cannot append
# numbers.append(4)  # ✗ AttributeError

# You cannot remove
# numbers.remove(2)  # ✗ AttributeError
```

---

## Tuple Unpacking

Unpacking allows you to assign tuple elements to multiple variables.

### Basic Unpacking

```python
point = (10, 20)
x, y = point
print(f"x: {x}, y: {y}")
```

### Multiple Variables

```python
person = ("Alice", 25, "alice@email.com")
name, age, email = person
print(name, age, email)
```

### With Underscore (Ignore Values)

```python
data = (1, 2, 3, 4, 5)
first, _, third, _, fifth = data
print(first, third, fifth)
```

### Rest Collection

```python
numbers = (1, 2, 3, 4, 5)
first, *middle, last = numbers
print(f"First: {first}, Middle: {middle}, Last: {last}")
```

---

## Tuple Methods

Tuples have only two methods:

### `count()`

Counts occurrences of a value.

```python
numbers = (1, 2, 2, 3, 2, 4)
print(numbers.count(2))
```

### `index()`

Finds the index of the first occurrence.

```python
fruits = ("apple", "banana", "mango")
print(fruits.index("banana"))
```

---

## Looping Through Tuples

### Basic Loop

```python
fruits = ("apple", "banana", "mango")

for fruit in fruits:
	print(fruit)
```

### Using `enumerate()`

```python
for index, fruit in enumerate(fruits, start=1):
	print(f"{index}. {fruit}")
```

---

## Membership Testing

```python
fruits = ("apple", "banana", "mango")

print("banana" in fruits)
print("grapes" not in fruits)
```

---

## Nested Tuples

```python
matrix = (
	(1, 2, 3),
	(4, 5, 6),
	(7, 8, 9)
)

print(matrix[0])
print(matrix[1][2])

for row in matrix:
	for value in row:
		print(value, end=" ")
	print()
```

---

## Tuple Comprehensions

```python
squares = tuple(number ** 2 for number in range(1, 6))
print(squares)

even_numbers = tuple(number for number in range(1, 11) if number % 2 == 0)
print(even_numbers)
```

---

## Comparison: Tuple vs List

| Feature | Tuple | List |
|---|---|---|
| **Ordered** | Yes | Yes |
| **Mutable** | No | Yes |
| **Hashable** | Yes | No |
| **Can be key** | Yes | No |
| **Speed** | Faster | Slightly slower |
| **Memory** | Less | More |
| **Syntax** | `()` | `[]` |

### When to Use Each

- Use **Tuple** when data should not change
- Use **List** when you need to add/remove items

---

## Common Mistakes to Avoid

### 1. Forgetting the Comma for Single Element

```python
# This is not a tuple
single = (42)
print(type(single))

# This is a tuple
single = (42,)
print(type(single))
```

### 2. Trying to Modify a Tuple

```python
coordinates = (10, 20)
# coordinates[0] = 15  # ✗ Error
```

### 3. Using List Inside Tuple for Key

```python
# ✗ Wrong - lists are unhashable
# bad_dict = {[1, 2]: "value"}

# ✓ Correct - tuples are hashable
good_dict = {(1, 2): "value"}
```

---

## Best Practices

- Use tuples for fixed, immutable data
- Use tuples as dictionary keys
- Unpack tuples for cleaner code
- Consider tuples for function return values
- Use named tuples for complex tuple structures

---

## Practical Examples

### Example 1: Function Returning Coordinates

```python
def get_coordinates():
	return (10, 20, 30)

x, y, z = get_coordinates()
print(x, y, z)
```

### Example 2: Tuple as Dictionary Key

```python
locations = {
	(0, 0): "Origin",
	(1, 1): "Diagonal",
	(10, 20): "Point"
}
print(locations[(0, 0)])
```

### Example 3: Unpacking in for Loop

```python
pairs = [(1, "one"), (2, "two"), (3, "three")]

for number, word in pairs:
	print(f"{number}: {word}")
```

### Example 4: Swapping Variables

```python
a, b = 5, 10
a, b = b, a
print(a, b)
```

### Example 5: Multiple Return Values

```python
def analyze(data):
	return (len(data), max(data), min(data))

length, maximum, minimum = analyze([1, 5, 3])
print(length, maximum, minimum)
```

---

---

# PART 2: DICTIONARIES

## Introduction to Dictionaries

A dictionary is an unordered (in Python 3.7+ it's ordered), mutable collection of key-value pairs. It's one of the most useful data structures in Python.

Dictionaries are used when you need:
- Store data with descriptive keys
- Fast lookup by key
- Represent real-world objects
- Store configuration
- Count occurrences

### Example

```python
person = {"name": "Alice", "age": 25, "city": "NYC"}
print(person)
```

---

## When to Use Dictionaries

### 1. **When You Have Key-Value Relationships**
```python
# Student with properties
student = {"name": "Bob", "roll": 101, "gpa": 3.8}
```

### 2. **When You Need Fast Lookup by Key**
```python
# Find value by key instantly
user_emails = {"alice": "alice@email.com", "bob": "bob@email.com"}
email = user_emails["alice"]
```

### 3. **When You Need to Count Things**
```python
# Count word frequency
word_count = {"python": 5, "java": 3, "cpp": 2}
```

### 4. **When You Want to Store Configuration**
```python
# Application settings
config = {"host": "localhost", "port": 8080, "debug": True}
```

### 5. **When Representing Real-World Objects**
```python
# Product information
product = {
	"name": "Laptop",
	"price": 999,
	"stock": 10,
	"color": "silver"
}
```

### 6. **When You Need Flexible Structure**
```python
# Data can vary in structure
data = {"id": 1, "info": "value"}  # 2 keys
data = {"id": 1, "info": "value", "extra": "field"}  # 3 keys
```

---

## Why to Use Dictionaries

### 1. **Fast Lookup**
```python
# O(1) lookup time by key
users = {"alice": 25, "bob": 30, "charlie": 28}
age = users["alice"]  # Instant
```

### 2. **Descriptive Keys**
```python
# More readable than indexed lists
person = {"name": "Alice", "age": 25}  # Clear meaning
# vs
person = ["Alice", 25]  # What does each value mean?
```

### 3. **Flexible Structure**
```python
# Can have different keys for different records
student1 = {"name": "Alice", "math": 90}
student2 = {"name": "Bob", "math": 85, "science": 92}
```

### 4. **Works with Real-World Data**
```python
# Mirrors JSON structure
api_response = {
	"status": "success",
	"data": {"users": 100}
}
```

### 5. **Rich Methods**
```python
# Many useful methods: keys(), values(), items(), get(), pop(), update()
d = {"a": 1, "b": 2}
print(d.keys())
print(d.values())
```

### 6. **Mutable**
```python
# Can be changed after creation
config = {"timeout": 30}
config["retries"] = 3
config["timeout"] = 60
```

---

## Purpose of Dictionaries

### 1. **Object Representation**
```python
# Represent entities
book = {"title": "Python 101", "author": "John", "pages": 300}
```

### 2. **Data Lookup**
```python
# Quick find by key
phone_book = {"alice": "555-1234", "bob": "555-5678"}
```

### 3. **Configuration Storage**
```python
# Store settings
app_config = {"debug": True, "port": 8080, "database": "mysql"}
```

### 4. **Counting and Frequency**
```python
# Count occurrences
votes = {"A": 10, "B": 8, "C": 12}
```

### 5. **Caching**
```python
# Store computed results
cache = {"user_123": {"name": "Alice", "age": 25}}
```

### 6. **API Responses**
```python
# Work with JSON-like data
response = {"code": 200, "message": "OK", "data": [...]}
```

### 7. **Grouping Related Data**
```python
# Store attributes of an object
user = {
	"username": "alice",
	"email": "alice@email.com",
	"preferences": {"theme": "dark", "language": "en"}
}
```

---

## Key Characteristics of Dictionaries

- **Key-value pairs**: Store data with descriptive labels
- **Mutable**: Can be changed after creation
- **Ordered** (Python 3.7+): Keys maintain insertion order
- **Unique keys**: Each key appears only once
- **Fast lookup**: O(1) average lookup time
- **Can store mixed types**: Keys and values can be various types

```python
mixed_dict = {
	"string_key": "value",
	42: "number key",
	True: "boolean key"
}
```

---

## Creating Dictionaries

### Empty Dictionary

```python
empty_dict = {}
print(empty_dict)
```

### Dictionary with Values

```python
person = {"name": "Alice", "age": 25, "city": "NYC"}
scores = {"math": 90, "english": 85, "science": 92}
```

### Using `dict()` Constructor

```python
from_list = dict([("a", 1), ("b", 2)])
print(from_list)

from_keys = dict.fromkeys(["x", "y", "z"], 0)
print(from_keys)
```

### Nested Dictionary

```python
students = {
	"alice": {"age": 20, "gpa": 3.8},
	"bob": {"age": 21, "gpa": 3.5}
}
```

---

## Accessing Dictionary Values

### Using Key

```python
person = {"name": "Alice", "age": 25}

print(person["name"])
print(person["age"])
```

### Using `get()` Method

```python
# Safer - returns None if key doesn't exist
print(person.get("name"))
print(person.get("phone", "Not available"))
```

---

## Adding and Updating Items

### Add New Key-Value Pair

```python
person = {"name": "Alice"}
person["age"] = 25
print(person)
```

### Update Existing Value

```python
person = {"name": "Alice", "age": 25}
person["age"] = 26
print(person)
```

### Update Multiple Items

```python
person = {"name": "Alice"}
person.update({"age": 25, "city": "NYC"})
print(person)
```

---

## Removing Items from Dictionary

### `del` Keyword

```python
person = {"name": "Alice", "age": 25, "city": "NYC"}
del person["age"]
print(person)
```

### `pop()` Method

```python
removed = person.pop("city", "Not found")
print(removed)
print(person)
```

### `clear()` Method

```python
person.clear()
print(person)
```

---

## Common Dictionary Methods

### `keys()`

```python
person = {"name": "Alice", "age": 25, "city": "NYC"}
print(person.keys())
```

### `values()`

```python
print(person.values())
```

### `items()`

```python
print(person.items())
```

### `get()`

```python
print(person.get("name"))
print(person.get("phone", "N/A"))
```

### `update()`

```python
person.update({"age": 26, "job": "Engineer"})
print(person)
```

### `setdefault()`

```python
person.setdefault("phone", "555-0000")
print(person)
```

### `copy()`

```python
person_copy = person.copy()
person_copy["age"] = 99
print(person)
print(person_copy)
```

---

## Looping Through Dictionaries

### Loop Through Keys

```python
person = {"name": "Alice", "age": 25}

for key in person:
	print(key)
```

### Loop Through Values

```python
for value in person.values():
	print(value)
```

### Loop Through Key-Value Pairs

```python
for key, value in person.items():
	print(f"{key}: {value}")
```

---

## Membership Testing

```python
person = {"name": "Alice", "age": 25}

print("name" in person)
print("phone" not in person)
```

---

## Nested Dictionaries

```python
employees = {
	"emp001": {"name": "Alice", "dept": "IT", "salary": 80000},
	"emp002": {"name": "Bob", "dept": "HR", "salary": 70000},
	"emp003": {"name": "Charlie", "dept": "IT", "salary": 85000}
}

print(employees["emp001"]["name"])
print(employees["emp002"]["salary"])

for emp_id, emp_info in employees.items():
	print(f"{emp_id}: {emp_info['name']} - {emp_info['dept']}")
```

---

## Dictionary Comprehensions

### Basic Example

```python
squares = {x: x**2 for x in range(1, 6)}
print(squares)
```

### With Condition

```python
even_squares = {x: x**2 for x in range(1, 11) if x % 2 == 0}
print(even_squares)
```

### From Lists

```python
names = ["alice", "bob", "charlie"]
email_map = {name: f"{name}@email.com" for name in names}
print(email_map)
```

---

## Merging Dictionaries

### Using `update()`

```python
dict1 = {"a": 1, "b": 2}
dict2 = {"c": 3, "d": 4}

dict1.update(dict2)
print(dict1)
```

### Using `**` (Python 3.5+)

```python
dict1 = {"a": 1, "b": 2}
dict2 = {"c": 3, "d": 4}

merged = {**dict1, **dict2}
print(merged)
```

### Using `|` (Python 3.9+)

```python
dict1 = {"a": 1, "b": 2}
dict2 = {"c": 3, "d": 4}

merged = dict1 | dict2
print(merged)
```

---

## Common Developer Scenarios

### 1. Count Word Frequency

```python
text = "apple banana apple orange banana apple"
words = text.split()
word_count = {}

for word in words:
	word_count[word] = word_count.get(word, 0) + 1

print(word_count)
```

### 2. Find Maximum by Value

```python
scores = {"alice": 90, "bob": 85, "charlie": 92}
highest_scorer = max(scores, key=scores.get)
print(highest_scorer, scores[highest_scorer])
```

### 3. Filter Dictionary

```python
scores = {"alice": 90, "bob": 75, "charlie": 88}
passing = {k: v for k, v in scores.items() if v >= 80}
print(passing)
```

### 4. Group Data

```python
students = [
	{"name": "Alice", "dept": "CS"},
	{"name": "Bob", "dept": "IT"},
	{"name": "Charlie", "dept": "CS"}
]

by_dept = {}
for student in students:
	dept = student["dept"]
	if dept not in by_dept:
		by_dept[dept] = []
	by_dept[dept].append(student["name"])

print(by_dept)
```

### 5. Swap Keys and Values

```python
original = {"a": 1, "b": 2, "c": 3}
swapped = {v: k for k, v in original.items()}
print(swapped)
```

---

## Common Mistakes to Avoid

### 1. Accessing Non-Existent Key

```python
person = {"name": "Alice"}
# print(person["age"])  # ✗ KeyError

# Use get() instead
print(person.get("age", "N/A"))  # ✓
```

### 2. Using Mutable Types as Keys

```python
# ✗ Wrong - lists are unhashable
# bad_dict = {[1, 2]: "value"}

# ✓ Correct - use tuples
good_dict = {(1, 2): "value"}
```

### 3. Iterating and Modifying

```python
data = {"a": 1, "b": 2, "c": 3}

# ✗ Wrong - can raise runtime error
# for key in data:
#     if key == "a":
#         del data[key]

# ✓ Correct - iterate over copy
for key in list(data.keys()):
	if key == "a":
		del data[key]
```

---

## Best Practices

- Use dictionaries for key-value relationships
- Use `get()` to safely access values
- Use meaningful key names
- Use dictionary comprehensions for simple transformations
- Consider nested dictionaries for complex structures
- Use `update()` for bulk changes
- Always check if key exists before accessing (or use `get()`)

---

## Practical Examples

### Example 1: Student Record

```python
student = {
	"name": "Alice",
	"roll": 101,
	"scores": {"math": 90, "english": 85}
}

print(student["name"])
print(student["scores"]["math"])
```

### Example 2: Count Occurrences

```python
items = ["apple", "banana", "apple", "orange", "banana", "apple"]
count = {}

for item in items:
	count[item] = count.get(item, 0) + 1

for item, freq in count.items():
	print(f"{item}: {freq}")
```

### Example 3: Configuration

```python
app_config = {
	"host": "localhost",
	"port": 8080,
	"debug": True,
	"database": "postgresql"
}

for key, value in app_config.items():
	print(f"{key} = {value}")
```

### Example 4: User Authentication

```python
users_db = {
	"alice": "password123",
	"bob": "secure456",
	"charlie": "pass789"
}

username = "alice"
password = "password123"

if username in users_db and users_db[username] == password:
	print("Login successful")
else:
	print("Invalid credentials")
```

### Example 5: API Response Handling

```python
response = {
	"status": "success",
	"code": 200,
	"data": {
		"user_id": 123,
		"username": "alice",
		"email": "alice@email.com"
	}
}

if response["status"] == "success":
	user_data = response["data"]
	print(f"User: {user_data['username']}")
```

---

## Comparison: Tuples, Lists, Sets, and Dictionaries

| Feature | List | Tuple | Set | Dict |
|---|---|---|---|---|
| **Ordered** | Yes | Yes | No | Yes* |
| **Mutable** | Yes | No | Yes | Yes |
| **Duplicates** | Yes | Yes | No | No* |
| **Indexable** | Yes | Yes | No | No |
| **Hashable** | No | Yes | No | No |
| **Use Case** | Dynamic sequences | Fixed sequences | Unique items | Key-value pairs |

*Python 3.7+

---

## Summary

### Tuples
- Immutable sequences
- Use when data should not change
- Can be dictionary keys
- Faster and use less memory than lists

### Dictionaries
- Key-value pairs for fast lookup
- Perfect for representing objects
- Mutable and flexible
- Essential for working with APIs and configuration

Both are fundamental data structures that work together - tuples as keys in dictionaries!
