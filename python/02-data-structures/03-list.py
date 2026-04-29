"""
Lists in Python - Practical Examples
Executable examples covering creation, indexing, slicing, methods,
copying, nested lists, comprehensions, and common developer scenarios.
"""

import copy

print("\n=== LISTS IN PYTHON ===")


# ============================================================================
# WHEN TO USE LISTS - Real-world Scenarios
# ============================================================================
print("\n=== WHEN TO USE LISTS ===")

# 1. Store multiple related values
print("\n1. Store multiple related values:")
students = ["Alice", "Bob", "Charlie", "Diana"]
print(f"Students: {students}")

# 2. Maintain order
print("\n2. Maintain order (order matters):")
daily_temperatures = [22, 23, 25, 24, 26]
print(f"Daily temperatures (Monday-Friday): {daily_temperatures}")

# 3. Add/Remove items dynamically
print("\n3. Add/Remove items dynamically:")
shopping_cart = ["milk", "bread"]
shopping_cart.append("eggs")
shopping_cart.remove("milk")
print(f"Shopping cart after updates: {shopping_cart}")

# 4. Store duplicate values
print("\n4. Store duplicate values:")
votes = ["A", "B", "A", "C", "A", "B"]
print(f"Votes: {votes}")

# 5. Access items by position
print("\n5. Access items by position:")
items = [10, 20, 30, 40]
print(f"First item: {items[0]}, Last item: {items[-1]}, Third item: {items[2]}")

# 6. Mix different data types
print("\n6. Mix different data types in one list:")
mixed_data = ["Alice", 25, True, 3.14]
print(f"Mixed data: {mixed_data}")


# ============================================================================
# WHY TO USE LISTS - Advantages Over Other Data Structures
# ============================================================================
print("\n=== WHY TO USE LISTS ===")

# 1. Flexibility - Mutable
print("\n1. Flexibility - Lists are mutable (can be modified):")
numbers = [1, 2, 3]
numbers[0] = 10
numbers.append(4)
print(f"Modified list: {numbers}")

# 2. Easy search and filter
print("\n2. Easy to search and filter:")
fruits = ["apple", "banana", "apple", "orange"]
print(f"'banana' exists: {('banana' in fruits)}")
print(f"Count of 'apple': {fruits.count('apple')}")
print(f"Index of 'banana': {fruits.index('banana')}")

# 3. Efficient iteration
print("\n3. Efficient for iteration:")
for item in ["red", "green", "blue"]:
	print(f"  {item}")

# 4. Rich built-in methods
print("\n4. Rich built-in methods:")
data = [3, 1, 4, 1, 5]
print(f"  Original: {data}")
data.sort()
print(f"  Sorted: {data}")
data.reverse()
print(f"  Reversed: {data}")

# 5. List comprehensions
print("\n5. Elegant list comprehensions:")
squares = [i ** 2 for i in range(1, 6)]
print(f"Squares 1-5: {squares}")

# 6. Unpacking
print("\n6. Unpacking to assign multiple variables:")
coordinates = [10, 20, 30]
x, y, z = coordinates
print(f"Coordinates: x={x}, y={y}, z={z}")


# ============================================================================
# PURPOSE OF LISTS - Important Use Cases
# ============================================================================
print("\n=== PURPOSE OF LISTS ===")

# 1. Data collection
print("\n1. Data Collection:")
user_ids = [101, 102, 103, 104, 105]
print(f"User IDs collected: {user_ids}")

# 2. Data aggregation
print("\n2. Data Aggregation (analyze multiple values):")
sales = [1000, 1200, 1100, 1500, 1300]
average_sales = sum(sales) / len(sales)
print(f"Sales: {sales}")
print(f"Average sales: {average_sales:.2f}")

# 3. Data transformation
print("\n3. Data Transformation:")
names = ["alice", "bob", "charlie"]
names_upper = [name.upper() for name in names]
print(f"Original: {names}")
print(f"Uppercase: {names_upper}")

# 4. Sequential workflow / Queue
print("\n4. Sequential workflow (order matters):")
workflow = ["login", "verify", "process", "logout"]
for step in workflow:
	print(f"  Step: {step}")

# 5. Temporary storage / caching
print("\n5. Temporary storage (caching results):")
results = []
for number in range(1, 4):
	result = number ** 2
	results.append(result)
print(f"Cached results (squares): {results}")

# 6. Building complex data structures
print("\n6. Building complex data structures (list of records):")
students_records = [
	{"name": "Alice", "age": 20, "gpa": 3.8},
	{"name": "Bob", "age": 21, "gpa": 3.5},
	{"name": "Charlie", "age": 19, "gpa": 3.9}
]
for student in students_records:
	print(f"  {student['name']}: Age {student['age']}, GPA {student['gpa']}")

# 7. Repetitive processing
print("\n7. Iteration for repeated processing:")
prices = [19.99, 29.99, 39.99]
for price in prices:
	discounted = price * 0.9
	print(f"  Original: ${price:.2f}, 10% Off: ${discounted:.2f}")

# 8. Comparison: When to use what
print("\n8. Data Structure Comparison Summary:")
print("  List - Ordered, Mutable, Allows Duplicates (dynamic collections)")
print("  Tuple - Ordered, Immutable, Allows Duplicates (fixed data)")
print("  Set - Unordered, Mutable, No Duplicates (unique items only)")
print("  Dict - Key-value pairs (lookup by key)")


# ============================================================================
# 1. CREATING LISTS
# ============================================================================
print("\n=== 1. CREATING LISTS ===")

empty_list = []
numbers = [1, 2, 3, 4, 5]
names = ["Alice", "Bob", "Charlie"]
mixed = [10, "Python", True, 3.14]
letters = list("Python")
tuple_to_list = list((1, 2, 3))

print(f"Empty list: {empty_list}")
print(f"Numbers: {numbers}")
print(f"Names: {names}")
print(f"Mixed: {mixed}")
print(f"Letters: {letters}")
print(f"Tuple to list: {tuple_to_list}")


# ============================================================================
# 2. ACCESSING ELEMENTS
# ============================================================================
print("\n=== 2. ACCESSING ELEMENTS ===")

fruits = ["apple", "banana", "mango", "orange"]

print(f"First item: {fruits[0]}")
print(f"Second item: {fruits[1]}")
print(f"Last item: {fruits[-1]}")
print(f"Second last item: {fruits[-2]}")


# ============================================================================
# 3. SLICING LISTS
# ============================================================================
print("\n=== 3. SLICING LISTS ===")

numbers = [10, 20, 30, 40, 50, 60]

print(f"numbers[1:4]: {numbers[1:4]}")
print(f"numbers[:3]: {numbers[:3]}")
print(f"numbers[3:]: {numbers[3:]}")
print(f"numbers[::2]: {numbers[::2]}")
print(f"numbers[::-1]: {numbers[::-1]}")


# ============================================================================
# 4. UPDATING ELEMENTS
# ============================================================================
print("\n=== 4. UPDATING ELEMENTS ===")

fruits = ["apple", "banana", "mango"]
fruits[1] = "grapes"
print(f"Updated fruits: {fruits}")

numbers = [1, 2, 3, 4, 5]
numbers[1:3] = [20, 30]
print(f"Updated slice: {numbers}")


# ============================================================================
# 5. ADDING ELEMENTS
# ============================================================================
print("\n=== 5. ADDING ELEMENTS ===")

numbers = [1, 2, 3]
numbers.append(4)
print(f"After append(4): {numbers}")

numbers.extend([5, 6])
print(f"After extend([5, 6]): {numbers}")

names = ["Alice", "Charlie"]
names.insert(1, "Bob")
print(f"After insert(1, 'Bob'): {names}")


# ============================================================================
# 6. REMOVING ELEMENTS
# ============================================================================
print("\n=== 6. REMOVING ELEMENTS ===")

fruits = ["apple", "banana", "mango", "banana"]
fruits.remove("banana")
print(f"After remove('banana'): {fruits}")

numbers = [10, 20, 30, 40]
removed = numbers.pop()
print(f"Popped last item: {removed}, list: {numbers}")

removed = numbers.pop(1)
print(f"Popped index 1: {removed}, list: {numbers}")

values = [1, 2, 3, 4, 5]
del values[2]
print(f"After del values[2]: {values}")

del values[1:3]
print(f"After del values[1:3]: {values}")

items = [1, 2, 3]
items.clear()
print(f"After clear(): {items}")


# ============================================================================
# 7. COMMON LIST METHODS
# ============================================================================
print("\n=== 7. COMMON LIST METHODS ===")

fruits = ["apple", "banana", "mango"]
print(f"Index of banana: {fruits.index('banana')}")

numbers = [1, 2, 2, 3, 2, 4]
print(f"Count of 2: {numbers.count(2)}")

numbers = [5, 2, 8, 1, 3]
numbers.sort()
print(f"Sorted ascending: {numbers}")

numbers.sort(reverse=True)
print(f"Sorted descending: {numbers}")

values = [1, 2, 3, 4]
values.reverse()
print(f"Reversed: {values}")

original = [1, 2, 3]
copied = original.copy()
print(f"Copied list: {copied}")


# ============================================================================
# 8. BUILT-IN FUNCTIONS WITH LISTS
# ============================================================================
print("\n=== 8. BUILT-IN FUNCTIONS ===")

numbers = [10, 20, 30, 40]

print(f"Length: {len(numbers)}")
print(f"Minimum: {min(numbers)}")
print(f"Maximum: {max(numbers)}")
print(f"Sum: {sum(numbers)}")
print(f"Sorted descending copy: {sorted(numbers, reverse=True)}")


# ============================================================================
# 9. LOOPING THROUGH LISTS
# ============================================================================
print("\n=== 9. LOOPING THROUGH LISTS ===")

fruits = ["apple", "banana", "mango"]

for fruit in fruits:
	print(fruit)

print("\nUsing enumerate:")
for index, fruit in enumerate(fruits, start=1):
	print(f"{index}. {fruit}")

print("\nEven numbers:")
numbers = [1, 2, 3, 4, 5, 6]
for number in numbers:
	if number % 2 == 0:
		print(number)


# ============================================================================
# 10. MEMBERSHIP TESTING
# ============================================================================
print("\n=== 10. MEMBERSHIP TESTING ===")

fruits = ["apple", "banana", "mango"]

print(f"'banana' in fruits: {'banana' in fruits}")
print(f"'grapes' not in fruits: {'grapes' not in fruits}")


# ============================================================================
# 11. CONCATENATION AND REPETITION
# ============================================================================
print("\n=== 11. CONCATENATION AND REPETITION ===")

list1 = [1, 2, 3]
list2 = [4, 5, 6]
print(f"Concatenation: {list1 + list2}")

values = [1, 2]
print(f"Repetition: {values * 3}")


# ============================================================================
# 12. NESTED LISTS
# ============================================================================
print("\n=== 12. NESTED LISTS ===")

matrix = [
	[1, 2, 3],
	[4, 5, 6],
	[7, 8, 9],
]

print(f"Matrix: {matrix}")
print(f"First row: {matrix[0]}")
print(f"matrix[1][2]: {matrix[1][2]}")

print("\nIterating nested list:")
for row in matrix:
	for value in row:
		print(value, end=" ")
	print()


# ============================================================================
# 13. LIST COMPREHENSIONS
# ============================================================================
print("\n=== 13. LIST COMPREHENSIONS ===")

squares = [number ** 2 for number in range(1, 6)]
print(f"Squares: {squares}")

even_numbers = [number for number in range(1, 11) if number % 2 == 0]
print(f"Even numbers: {even_numbers}")

names = ["alice", "bob", "charlie"]
capitalized = [name.capitalize() for name in names]
print(f"Capitalized names: {capitalized}")


# ============================================================================
# 14. COPYING LISTS
# ============================================================================
print("\n=== 14. COPYING LISTS ===")

list1 = [1, 2, 3]
list2 = list1
list2[0] = 100
print(f"Reference copy list1: {list1}")
print(f"Reference copy list2: {list2}")

list1 = [1, 2, 3]
copy1 = list1.copy()
copy1[0] = 999
print(f"Original after .copy(): {list1}")
print(f"Independent copy: {copy1}")

original_nested = [[1, 2], [3, 4]]
deep_copied = copy.deepcopy(original_nested)
deep_copied[0][0] = 500
print(f"Original nested: {original_nested}")
print(f"Deep copied nested: {deep_copied}")


# ============================================================================
# 15. PRACTICAL EXAMPLE - STORE USERS
# ============================================================================
print("\n=== 15. EXAMPLE: STORE USERS ===")

users = ["alice", "bob", "charlie"]
print(f"Users: {users}")


# ============================================================================
# 16. PRACTICAL EXAMPLE - FILTER EVEN NUMBERS
# ============================================================================
print("\n=== 16. EXAMPLE: FILTER EVEN NUMBERS ===")

numbers = [1, 2, 3, 4, 5, 6]
even_numbers = [number for number in numbers if number % 2 == 0]
print(f"Even numbers: {even_numbers}")


# ============================================================================
# 17. PRACTICAL EXAMPLE - REMOVE DUPLICATES
# ============================================================================
print("\n=== 17. EXAMPLE: REMOVE DUPLICATES ===")

numbers = [1, 2, 2, 3, 4, 4, 5]
unique_numbers = list(set(numbers))
print(f"Unique numbers: {unique_numbers}")


# ============================================================================
# 18. PRACTICAL EXAMPLE - FIND MAX VALUE
# ============================================================================
print("\n=== 18. EXAMPLE: FIND MAX VALUE ===")

scores = [78, 92, 85, 88]
print(f"Maximum score: {max(scores)}")


# ============================================================================
# 19. PRACTICAL EXAMPLE - SORT NAMES
# ============================================================================
print("\n=== 19. EXAMPLE: SORT NAMES ===")

names = ["Charlie", "Alice", "Bob"]
names.sort()
print(f"Sorted names: {names}")


# ============================================================================
# 20. PRACTICAL EXAMPLE - SUM AND AVERAGE
# ============================================================================
print("\n=== 20. EXAMPLE: SUM AND AVERAGE ===")

marks = [85, 90, 78, 92]
total_marks = sum(marks)
average_marks = total_marks / len(marks)
print(f"Marks: {marks}")
print(f"Total: {total_marks}")
print(f"Average: {average_marks:.2f}")


# ============================================================================
# 21. PRACTICAL EXAMPLE - SAFE SEARCH
# ============================================================================
print("\n=== 21. EXAMPLE: SAFE SEARCH ===")

fruits = ["apple", "banana", "mango"]

if "banana" in fruits:
	print("Found banana")

if "grapes" not in fruits:
	print("Grapes not found")


# ============================================================================
# 22. PRACTICAL EXAMPLE - APPEND VS EXTEND
# ============================================================================
print("\n=== 22. EXAMPLE: APPEND VS EXTEND ===")

items = [1, 2]
items.append([3, 4])
print(f"After append([3, 4]): {items}")

items = [1, 2]
items.extend([3, 4])
print(f"After extend([3, 4]): {items}")


# ============================================================================
# 23. PRACTICAL EXAMPLE - MODIFY LIST SAFELY
# ============================================================================
print("\n=== 23. EXAMPLE: MODIFY LIST SAFELY ===")

numbers = [1, 2, 3, 4, 5, 6]

for number in numbers[:]:
	if number % 2 == 0:
		numbers.remove(number)

print(f"After removing even numbers: {numbers}")


# ============================================================================
# 24. PRACTICAL EXAMPLE - SHOPPING CART
# ============================================================================
print("\n=== 24. EXAMPLE: SHOPPING CART ===")

cart = []
cart.append("Laptop")
cart.append("Mouse")
cart.append("Keyboard")
print(f"Cart items: {cart}")

cart.remove("Mouse")
print(f"After removing Mouse: {cart}")


# ============================================================================
# 25. PRACTICAL EXAMPLE - TASK MANAGER
# ============================================================================
print("\n=== 25. EXAMPLE: TASK MANAGER ===")

tasks = ["Learn Python", "Practice Lists", "Build Project"]

for index, task in enumerate(tasks, start=1):
	print(f"{index}. {task}")

completed_task = tasks.pop(0)
print(f"Completed task: {completed_task}")
print(f"Remaining tasks: {tasks}")


print("\n=== END OF LIST EXAMPLES ===")
