"""
Loops in Python - Practical Examples
Executable examples covering for loops, while loops, break, continue,
nested loops, enumerate, zip, and comprehensions.
"""

print("\n=== LOOPS IN PYTHON ===")


# ============================================================================
# 1. BASIC FOR LOOP
# ============================================================================
print("\n=== 1. BASIC FOR LOOP ===")

fruits = ["apple", "banana", "mango"]

for fruit in fruits:
	print(fruit)


# ============================================================================
# 2. FOR LOOP WITH RANGE
# ============================================================================
print("\n=== 2. FOR LOOP WITH RANGE ===")

print("range(5):")
for i in range(5):
	print(i)

print("\nrange(1, 6):")
for i in range(1, 6):
	print(i)

print("\nrange(2, 11, 2):")
for i in range(2, 11, 2):
	print(i)

print("\nrange(10, 0, -1):")
for i in range(10, 0, -1):
	print(i)


# ============================================================================
# 3. LOOPING THROUGH A STRING
# ============================================================================
print("\n=== 3. LOOPING THROUGH A STRING ===")

word = "Python"

for char in word:
	print(char)


# ============================================================================
# 4. LOOPING THROUGH A LIST
# ============================================================================
print("\n=== 4. LOOPING THROUGH A LIST ===")

numbers = [1, 2, 3, 4, 5]

for number in numbers:
	print(f"{number} doubled is {number * 2}")


# ============================================================================
# 5. LOOPING THROUGH TUPLE, SET, DICTIONARY
# ============================================================================
print("\n=== 5. OTHER ITERABLES ===")

colors = ("red", "green", "blue")
for color in colors:
	print(f"Tuple item: {color}")

unique_numbers = {1, 2, 3, 4}
for value in unique_numbers:
	print(f"Set item: {value}")

student = {"name": "Alice", "age": 21, "grade": "A"}

print("\nDictionary keys:")
for key in student:
	print(key)

print("\nDictionary key-value pairs:")
for key, value in student.items():
	print(f"{key}: {value}")

print("\nDictionary values:")
for value in student.values():
	print(value)


# ============================================================================
# 6. BASIC WHILE LOOP
# ============================================================================
print("\n=== 6. BASIC WHILE LOOP ===")

count = 1

while count <= 5:
	print(count)
	count += 1


# ============================================================================
# 7. COUNTDOWN WITH WHILE LOOP
# ============================================================================
print("\n=== 7. COUNTDOWN WITH WHILE LOOP ===")

count = 5

while count > 0:
	print(count)
	count -= 1

print("Blast off!")


# ============================================================================
# 8. BREAK STATEMENT
# ============================================================================
print("\n=== 8. BREAK STATEMENT ===")

for number in range(1, 10):
	if number == 5:
		print("Stopping loop at 5")
		break
	print(number)


# ============================================================================
# 9. CONTINUE STATEMENT
# ============================================================================
print("\n=== 9. CONTINUE STATEMENT ===")

for number in range(1, 6):
	if number == 3:
		print("Skipping 3")
		continue
	print(number)


# ============================================================================
# 10. PASS STATEMENT
# ============================================================================
print("\n=== 10. PASS STATEMENT ===")

for number in range(3):
	pass

print("Loop with pass executed")


# ============================================================================
# 11. NESTED LOOPS
# ============================================================================
print("\n=== 11. NESTED LOOPS ===")

for i in range(1, 4):
	for j in range(1, 4):
		print(f"i={i}, j={j}")


# ============================================================================
# 12. FOR ELSE AND WHILE ELSE
# ============================================================================
print("\n=== 12. LOOP ELSE BLOCK ===")

for number in range(3):
	print(number)
else:
	print("For loop finished successfully")

count = 1
while count <= 3:
	print(count)
	count += 1
else:
	print("While loop completed")


# ============================================================================
# 13. ENUMERATE
# ============================================================================
print("\n=== 13. ENUMERATE ===")

fruits = ["apple", "banana", "mango"]

for index, fruit in enumerate(fruits):
	print(f"{index}: {fruit}")

print("\nEnumerate starting from 1:")
for index, fruit in enumerate(fruits, start=1):
	print(f"{index}: {fruit}")


# ============================================================================
# 14. ZIP
# ============================================================================
print("\n=== 14. ZIP ===")

names = ["Alice", "Bob", "Charlie"]
scores = [85, 90, 88]

for name, score in zip(names, scores):
	print(f"{name}: {score}")


# ============================================================================
# 15. LIST COMPREHENSIONS
# ============================================================================
print("\n=== 15. LIST COMPREHENSIONS ===")

squares = [number ** 2 for number in range(1, 6)]
print(f"Squares: {squares}")

even_numbers = [number for number in range(1, 11) if number % 2 == 0]
print(f"Even numbers: {even_numbers}")


# ============================================================================
# 16. PRACTICAL EXAMPLE - SUM OF NUMBERS
# ============================================================================
print("\n=== 16. EXAMPLE: SUM OF NUMBERS ===")

numbers = [10, 20, 30, 40]
total = 0

for number in numbers:
	total += number

print(f"Total: {total}")


# ============================================================================
# 17. PRACTICAL EXAMPLE - SEARCH FOR ITEM
# ============================================================================
print("\n=== 17. EXAMPLE: SEARCH FOR ITEM ===")

users = ["alice", "bob", "charlie"]
target = "bob"

for user in users:
	if user == target:
		print("User found")
		break


# ============================================================================
# 18. PRACTICAL EXAMPLE - PASSWORD ATTEMPTS
# ============================================================================
print("\n=== 18. EXAMPLE: PASSWORD ATTEMPTS ===")

attempts = 0

while attempts < 3:
	print(f"Password attempt {attempts + 1}")
	attempts += 1


# ============================================================================
# 19. PRACTICAL EXAMPLE - MULTIPLICATION TABLE
# ============================================================================
print("\n=== 19. EXAMPLE: MULTIPLICATION TABLE ===")

for i in range(1, 6):
	print(f"5 x {i} = {5 * i}")


# ============================================================================
# 20. PRACTICAL EXAMPLE - PATTERN PRINTING
# ============================================================================
print("\n=== 20. EXAMPLE: PATTERN PRINTING ===")

for row in range(1, 6):
	print("*" * row)


# ============================================================================
# 21. PRACTICAL EXAMPLE - SUM OF FIRST 10 NATURAL NUMBERS
# ============================================================================
print("\n=== 21. EXAMPLE: SUM OF FIRST 10 NATURAL NUMBERS ===")

total = 0

for number in range(1, 11):
	total += number

print(f"Sum: {total}")


# ============================================================================
# 22. PRACTICAL EXAMPLE - FIND EVEN NUMBERS
# ============================================================================
print("\n=== 22. EXAMPLE: FIND EVEN NUMBERS ===")

for number in range(1, 11):
	if number % 2 == 0:
		print(number)


# ============================================================================
# 23. PRACTICAL EXAMPLE - REMOVE EVEN NUMBERS SAFELY
# ============================================================================
print("\n=== 23. EXAMPLE: MODIFY LIST SAFELY ===")

numbers = [1, 2, 3, 4, 5, 6]

for number in numbers[:]:
	if number % 2 == 0:
		numbers.remove(number)

print(f"After removing even numbers: {numbers}")


# ============================================================================
# 24. PRACTICAL EXAMPLE - SIMPLE MENU LOOP
# ============================================================================
print("\n=== 24. EXAMPLE: SIMPLE MENU LOOP ===")

menu_actions = ["View", "Edit", "Exit"]

for action in menu_actions:
	print(f"Menu option: {action}")


# ============================================================================
# 25. PRACTICAL EXAMPLE - LOOP WITH CONDITIONS
# ============================================================================
print("\n=== 25. EXAMPLE: LOOP WITH CONDITIONS ===")

for number in range(1, 11):
	if number % 2 == 0 and number % 3 == 0:
		print(f"{number} is divisible by both 2 and 3")
	elif number % 2 == 0:
		print(f"{number} is divisible by 2")
	elif number % 3 == 0:
		print(f"{number} is divisible by 3")
	else:
		print(f"{number} is not divisible by 2 or 3")


print("\n=== END OF LOOPS EXAMPLES ===")
