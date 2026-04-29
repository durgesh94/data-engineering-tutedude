# Sets in Python

## Introduction to Sets

A set is an unordered, mutable collection of unique elements. Sets are used when you need to store distinct values without duplicates and perform mathematical set operations.

Sets are used when you need:
- Unique values only (no duplicates)
- Fast membership testing
- Mathematical set operations (union, intersection, difference)
- Remove duplicates from a collection
- Fast lookups

### Example

```python
colors = {"red", "green", "blue"}
print(colors)
```

---

## When to Use Sets

### 1. **When You Need Only Unique Values**
```python
# Remove duplicates from a list
numbers = [1, 2, 2, 3, 3, 3, 4]
unique = set(numbers)
print(unique)  # {1, 2, 3, 4}
```

### 2. **When You Need Fast Membership Testing**
```python
# Check if item exists (O(1) operation)
banned_users = {"user123", "user456", "user789"}
if "user123" in banned_users:
	print("User is banned")
```

### 3. **When You Need Mathematical Set Operations**
```python
# Find common elements or differences
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}

common = set1 & set2  # {3, 4}
all_items = set1 | set2  # {1, 2, 3, 4, 5, 6}
different = set1 - set2  # {1, 2}
```

### 4. **When You Need to Eliminate Duplicates**
```python
# Convert list with duplicates to set
items = ["apple", "banana", "apple", "orange", "banana"]
unique_items = set(items)
```

### 5. **When Multiple Conditions Must All Be True**
```python
# Find items in all groups
group1 = {"a", "b", "c", "d"}
group2 = {"c", "d", "e", "f"}
group3 = {"d", "e", "f", "g"}

in_all = group1 & group2 & group3  # {d}
```

### 6. **When You Need Database-like Operations**
```python
# Union of items (from either set)
followers_a = {"alice", "bob", "charlie"}
followers_b = {"bob", "diana", "eve"}

all_followers = followers_a | followers_b
unique_to_a = followers_a - followers_b
```

---

## Why to Use Sets

### 1. **O(1) Fast Membership Testing**
```python
# Checking if item exists is instant
large_set = set(range(1000000))
if 500000 in large_set:  # Very fast!
	print("Found")
```

### 2. **Automatic Duplicate Removal**
```python
# Duplicates are silently ignored
data = [1, 2, 2, 3, 3, 3]
unique = set(data)  # {1, 2, 3}
```

### 3. **Mathematical Set Operations**
```python
# Perform union, intersection, difference
a = {1, 2, 3}
b = {2, 3, 4}
print(a & b)  # Intersection {2, 3}
print(a | b)  # Union {1, 2, 3, 4}
print(a - b)  # Difference {1}
```

### 4. **Findable Patterns in Data**
```python
# Easily find what's common or different
list1 = ["apple", "banana", "orange"]
list2 = ["banana", "orange", "grape"]

common = set(list1) & set(list2)  # {banana, orange}
only_in_list1 = set(list1) - set(list2)  # {apple}
```

### 5. **More Memory Efficient for Large Collections**
```python
# Sets use less memory than lists for large lookups
# Storage optimized for O(1) lookup
unique_users = {f"user_{i}" for i in range(10000)}
```

### 6. **Prevents Accidental Duplicates**
```python
# Cannot add duplicates - prevents bugs
visited = set()
visited.add("page1")
visited.add("page1")  # Silently ignored
visited.add("page2")
print(visited)  # {'page1', 'page2'}
```

---

## Purpose of Sets

### 1. **Deduplication**
```python
# Convert to set to remove duplicates
emails = ["alice@email.com", "bob@email.com", "alice@email.com"]
unique_emails = set(emails)
```

### 2. **Membership Queries**
```python
# Check if value exists in a collection
blocked_ids = {101, 102, 103, 104}
if user_id not in blocked_ids:
	process_user(user_id)
```

### 3. **Finding Common Elements**
```python
# Find what's common across multiple groups
python_devs = {"alice", "bob", "charlie"}
java_devs = {"bob", "diana", "eve"}

full_stack = python_devs & java_devs  # {"bob"}
```

### 4. **Finding Unique Elements**
```python
# Find items in one set but not in another
all_products = {"A", "B", "C", "D"}
discontinued = {"B", "D"}

available = all_products - discontinued  # {"A", "C"}
```

### 5. **Tracking Visited/Processed Items**
```python
# Keep track of what's already been handled
processed = set()
for item_id in item_ids:
	if item_id not in processed:
		process(item_id)
		processed.add(item_id)
```

### 6. **Set Algebra/Mathematical Operations**
```python
# Perform mathematical set operations
a = {1, 2, 3, 4}
b = {3, 4, 5, 6}

union = a | b  # All from a and b
intersection = a & b  # Common to both
difference = a - b  # In a but not b
symmetric_diff = a ^ b  # In a or b but not both
```

### 7. **Data Analysis and Statistics**
```python
# Find unique values in a dataset
purchase_items = ["A", "B", "A", "C", "B", "A"]
unique_products = set(purchase_items)
num_unique = len(unique_products)
```

---

## Key Characteristics of Sets

- **Unordered**: No guaranteed order (though Python 3.7+ maintains some order)
- **Mutable**: Can add or remove elements
- **No duplicates**: Each unique element appears only once
- **Hashable elements only**: Elements must be hashable (no lists, dicts, sets)
- **Fast membership**: O(1) lookup time
- **Can store mixed types**: Strings, numbers, tuples (not lists)

```python
mixed_set = {1, "two", 3.14, True}
print(mixed_set)
```

---

## Creating Sets

### Empty Set

```python
empty_set = set()
print(empty_set)
print(type(empty_set))
```

### Set with Values

```python
numbers = {1, 2, 3, 4, 5}
colors = {"red", "green", "blue"}
mixed = {1, "two", 3.14}
```

### Using `set()` Constructor

```python
from_list = set([1, 2, 3, 2, 1])
print(from_list)  # {1, 2, 3}

from_string = set("hello")
print(from_string)  # {'h', 'e', 'l', 'o'}

from_range = set(range(5))
print(from_range)  # {0, 1, 2, 3, 4}
```

### Set Comprehensions

```python
squares = {x**2 for x in range(1, 6)}
print(squares)

even_numbers = {x for x in range(10) if x % 2 == 0}
print(even_numbers)
```

---

## Adding Elements to a Set

### `add()` - Add Single Element

```python
colors = {"red", "blue"}
colors.add("green")
print(colors)
```

### `update()` - Add Multiple Elements

```python
numbers = {1, 2, 3}
numbers.update([4, 5, 6])
print(numbers)

numbers.update({7, 8}, {9, 10})
print(numbers)
```

---

## Removing Elements from a Set

### `remove()` - Remove with Error if Missing

```python
colors = {"red", "green", "blue"}
colors.remove("green")
print(colors)

# This will raise KeyError
# colors.remove("yellow")
```

### `discard()` - Remove Silently if Missing

```python
colors = {"red", "green", "blue"}
colors.discard("green")
colors.discard("yellow")  # No error
print(colors)
```

### `pop()` - Remove and Return Random Element

```python
numbers = {1, 2, 3, 4, 5}
removed = numbers.pop()
print(f"Removed: {removed}, Remaining: {numbers}")
```

### `clear()` - Remove All Elements

```python
items = {1, 2, 3}
items.clear()
print(items)
```

---

## Set Operations

### Union `|` (All elements from both)

```python
set1 = {1, 2, 3}
set2 = {3, 4, 5}

result = set1 | set2
print(result)  # {1, 2, 3, 4, 5}

# Or using method
result = set1.union(set2)
```

### Intersection `&` (Common elements)

```python
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}

result = set1 & set2
print(result)  # {3, 4}

# Or using method
result = set1.intersection(set2)
```

### Difference `-` (In first but not second)

```python
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}

result = set1 - set2
print(result)  # {1, 2}

# Or using method
result = set1.difference(set2)
```

### Symmetric Difference `^` (In either but not both)

```python
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}

result = set1 ^ set2
print(result)  # {1, 2, 5, 6}

# Or using method
result = set1.symmetric_difference(set2)
```

---

## Set Methods

### `copy()`

```python
original = {1, 2, 3}
copied = original.copy()
print(copied)
```

### `issubset()` - Check if all elements present

```python
a = {1, 2}
b = {1, 2, 3, 4}

print(a.issubset(b))  # True
print(b.issubset(a))  # False
```

### `issuperset()` - Check if contains all from another

```python
a = {1, 2, 3, 4}
b = {1, 2}

print(a.issuperset(b))  # True
print(b.issuperset(a))  # False
```

### `isdisjoint()` - Check if no common elements

```python
a = {1, 2, 3}
b = {4, 5, 6}
c = {3, 4, 5}

print(a.isdisjoint(b))  # True
print(a.isdisjoint(c))  # False
```

---

## Membership Testing

```python
colors = {"red", "green", "blue"}

print("red" in colors)  # True
print("yellow" not in colors)  # True
```

---

## Looping Through Sets

### Basic Loop

```python
colors = {"red", "green", "blue"}

for color in colors:
	print(color)
```

### With Enumeration

```python
colors = {"red", "green", "blue"}

for index, color in enumerate(colors, start=1):
	print(f"{index}. {color}")
```

---

## Comparing Sets

```python
set1 = {1, 2, 3}
set2 = {1, 2, 3}
set3 = {1, 2}

print(set1 == set2)  # True
print(set1 != set3)  # True
```

---

## Common Mistakes to Avoid

### 1. Using `{}` for Empty Set (Wrong!)

```python
# This creates an empty dict, not a set
empty = {}
print(type(empty))  # <class 'dict'>

# Correct way
empty_set = set()
print(type(empty_set))  # <class 'set'>
```

### 2. Adding Unhashable Types

```python
# ✗ Wrong - lists are unhashable
# my_set = {[1, 2], [3, 4]}

# ✓ Correct - use tuples
my_set = {(1, 2), (3, 4)}
```

### 3. Trying to Remove Non-Existent Element with `remove()`

```python
my_set = {1, 2, 3}
# my_set.remove(5)  # ✗ KeyError

# Use discard() instead
my_set.discard(5)  # ✓ No error
```

### 4. Forgetting Sets are Unordered

```python
# Don't rely on order
my_set = {3, 1, 2}
# Order is not guaranteed
```

---

## Best Practices

- Use sets for unique values and fast lookups
- Use sets for mathematical operations (union, intersection)
- Use `discard()` instead of `remove()` when uncertain if element exists
- Use sets to eliminate duplicates from lists
- Use set comprehensions for concise set creation
- Remember: sets are unordered, use lists if order matters

---

## Practical Examples

### Example 1: Remove Duplicates

```python
items = [1, 2, 2, 3, 3, 3, 4]
unique = list(set(items))
print(unique)
```

### Example 2: Find Common Elements

```python
list1 = [1, 2, 3, 4, 5]
list2 = [4, 5, 6, 7, 8]

common = set(list1) & set(list2)
print(common)  # {4, 5}
```

### Example 3: Find Unique Elements

```python
python_skills = {"OOP", "Decorators", "Generators"}
java_skills = {"OOP", "Inheritance", "Polymorphism"}

only_python = python_skills - java_skills
print(only_python)
```

### Example 4: Check Multiple Conditions

```python
allowed_roles = {"admin", "moderator", "user"}
user_role = "admin"

if user_role in allowed_roles:
	print("Access granted")
```

### Example 5: Track Visited Nodes

```python
visited = set()
nodes = [1, 2, 1, 3, 2, 4]

for node in nodes:
	if node not in visited:
		print(f"Processing node {node}")
		visited.add(node)
	else:
		print(f"Skipping already visited node {node}")
```

---

## Comparison: Lists, Tuples, Sets, Dicts

| Feature | List | Tuple | Set | Dict |
|---|---|---|---|---|
| **Ordered** | Yes | Yes | No | Yes* |
| **Mutable** | Yes | No | Yes | Yes |
| **Duplicates** | Yes | Yes | No | No |
| **Indexable** | Yes | Yes | No | No |
| **Hashable** | No | Yes | No | No |
| **Fast Lookup** | O(n) | O(n) | O(1) | O(1) |
| **Use Case** | Dynamic ordered data | Fixed sequences | Unique items only | Key-value pairs |

*Python 3.7+

---

## Summary

Sets are powerful for:
- **Deduplication**: Remove duplicates from collections
- **Fast Lookup**: O(1) membership testing
- **Mathematical Operations**: Union, intersection, difference
- **Data Analysis**: Find unique values, common elements
- **Performance**: Better than lists for large lookups

Sets bridge the gap between the simplicity of lists and the key-value structure of dictionaries, providing a unique way to work with collections of unique data.
