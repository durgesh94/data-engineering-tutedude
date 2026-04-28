"""
Python Fundamentals - All Examples
A comprehensive collection of Python basics with practical examples
"""

# ============================================================================
# 1. COMMENTS
# ============================================================================
# This is a single-line comment

"""
This is a multi-line comment
It can span multiple lines
Used for docstrings
"""


# ============================================================================
# 2. VARIABLES AND DATA TYPES
# ============================================================================
print("\n--- Variables and Data Types ---")

name = "John"           # String
age = 25                # Integer
height = 5.9            # Float
is_student = True       # Boolean

# Checking data types
x = 10
print(type(x))  # Output: <class 'int'>

name = "Alice"
print(type(name))  # Output: <class 'str'>


# ============================================================================
# 3. PRINT OUTPUT
# ============================================================================
print("\n--- Print Output ---")

print("Hello, World!")

x = 10
y = 20
print(x, y)  # Output: 10 20
print("x =", x, "and y =", y)  # Output: x = 10 and y = 20

# String Formatting - f-strings (Python 3.6+)
name = "Bob"
age = 30
print(f"My name is {name} and I am {age} years old")

# String Formatting - .format() method
print("My name is {} and I am {} years old".format(name, age))

# String Formatting - % formatting (older style)
print("My name is %s and I am %d years old" % (name, age))


# ============================================================================
# 4. ARITHMETIC OPERATORS
# ============================================================================
print("\n--- Arithmetic Operators ---")

a = 10
b = 3

print(f"{a} + {b} = {a + b}")           # Addition: 13
print(f"{a} - {b} = {a - b}")           # Subtraction: 7
print(f"{a} * {b} = {a * b}")           # Multiplication: 30
print(f"{a} / {b} = {a / b}")           # Division: 3.333...
print(f"{a} // {b} = {a // b}")         # Floor Division: 3
print(f"{a} % {b} = {a % b}")           # Modulus (Remainder): 1
print(f"{a} ** {b} = {a ** b}")         # Exponentiation: 1000


# ============================================================================
# 5. COMPARISON OPERATORS
# ============================================================================
print("\n--- Comparison Operators ---")

x = 5
y = 10

print(f"{x} == {y}: {x == y}")  # Equal to: False
print(f"{x} != {y}: {x != y}")  # Not equal to: True
print(f"{x} > {y}: {x > y}")    # Greater than: False
print(f"{x} < {y}: {x < y}")    # Less than: True
print(f"{x} >= {y}: {x >= y}")  # Greater than or equal to: False
print(f"{x} <= {y}: {x <= y}")  # Less than or equal to: True


# ============================================================================
# 6. LOGICAL OPERATORS
# ============================================================================
print("\n--- Logical Operators ---")

a = True
b = False

print(f"{a} and {b} = {a and b}")  # Logical AND: False
print(f"{a} or {b} = {a or b}")    # Logical OR: True
print(f"not {a} = {not a}")        # Logical NOT: False

# Practical example
age = 25
print(f"Age {age} > 18 and < 60: {age > 18 and age < 60}")  # True


# ============================================================================
# 7. ASSIGNMENT OPERATORS
# ============================================================================
print("\n--- Assignment Operators ---")

x = 5
print(f"Initial x: {x}")

x += 3      # x = x + 3
print(f"After x += 3: {x}")

x -= 2      # x = x - 2
print(f"After x -= 2: {x}")

x *= 2      # x = x * 2
print(f"After x *= 2: {x}")

x /= 3      # x = x / 3
print(f"After x /= 3: {x}")


# ============================================================================
# 8. TYPE CONVERSION
# ============================================================================
print("\n--- Type Conversion ---")

# String to Integer
str_num = "42"
num = int(str_num)
print(f"String '{str_num}' to int: {num}, type: {type(num)}")

# Integer to String
num = 100
str_num = str(num)
print(f"Int {num} to string: '{str_num}', type: {type(str_num)}")

# String to Float
pi = float("3.14")
print(f"String '3.14' to float: {pi}")

# Integer to Float
count = 5
decimal = float(count)
print(f"Int {count} to float: {decimal}")

# To Boolean
print(f"bool(1): {bool(1)}")        # True
print(f"bool(0): {bool(0)}")        # False
print(f"bool('text'): {bool('text')}")  # True
print(f"bool(''): {bool('')}")      # False


# ============================================================================
# 9. STRING METHODS
# ============================================================================
print("\n--- String Methods ---")

text = "Hello World"

print(f"Original text: '{text}'")
print(f"upper(): '{text.upper()}'")
print(f"lower(): '{text.lower()}'")
print(f"replace('World', 'Python'): '{text.replace('World', 'Python')}'")
print(f"split(): {text.split()}")
print(f"'  spaces  '.strip(): '{'  spaces  '.strip()}'")
print(f"find('World'): {text.find('World')}")
print(f"startswith('Hello'): {text.startswith('Hello')}")
print(f"endswith('World'): {text.endswith('World')}")


# ============================================================================
# 10. STRING INDEXING AND SLICING
# ============================================================================
print("\n--- String Indexing and Slicing ---")

text = "Python"

print(f"text[0] (first char): {text[0]}")
print(f"text[-1] (last char): {text[-1]}")
print(f"text[1:4] (index 1 to 3): {text[1:4]}")
print(f"text[:3] (first 3 chars): {text[:3]}")
print(f"text[3:] (from index 3): {text[3:]}")


# ============================================================================
# 11. CONDITIONAL STATEMENTS
# ============================================================================
print("\n--- Conditional Statements ---")

age = 20

if age < 13:
    print("You are a child")
elif age < 18:
    print("You are a teenager")
elif age < 60:
    print("You are an adult")
else:
    print("You are a senior")

# Ternary Operator
status = "Adult" if age >= 18 else "Minor"
print(f"Status: {status}")


# ============================================================================
# 12. BUILT-IN FUNCTIONS
# ============================================================================
print("\n--- Built-in Functions ---")

# abs() - Absolute value
print(f"abs(-5): {abs(-5)}")

# len() - Length
print(f"len('Hello'): {len('Hello')}")

# min() and max()
numbers = [5, 2, 8, 1, 9]
print(f"min({numbers}): {min(numbers)}")
print(f"max({numbers}): {max(numbers)}")

# sum() - Sum of elements
print(f"sum([1, 2, 3, 4]): {sum([1, 2, 3, 4])}")

# round() - Round to nearest integer
print(f"round(3.7): {round(3.7)}")

# sorted() - Sort a list
print(f"sorted([3, 1, 4, 1, 5]): {sorted([3, 1, 4, 1, 5])}")

# range() - Generate sequence
print("range(5):", list(range(5)))


# ============================================================================
# 13. PRACTICAL EXAMPLE 1: SIMPLE CALCULATOR
# ============================================================================
print("\n--- Example 1: Simple Calculator ---")

def calculator_demo():
    """Demonstrates a simple calculator"""
    # Simulating user input with predefined values for demo
    num1 = 15
    operation = "+"
    num2 = 5
    
    print(f"Calculating: {num1} {operation} {num2}")
    
    if operation == "+":
        result = num1 + num2
    elif operation == "-":
        result = num1 - num2
    elif operation == "*":
        result = num1 * num2
    elif operation == "/":
        if num2 != 0:
            result = num1 / num2
        else:
            print("Error: Division by zero!")
            return
    else:
        print("Invalid operation!")
        return
    
    print(f"Result: {result}")

calculator_demo()

# Uncomment below to take interactive input:
# num1 = float(input("Enter first number: "))
# operation = input("Enter operation (+, -, *, /): ")
# num2 = float(input("Enter second number: "))


# ============================================================================
# 14. PRACTICAL EXAMPLE 2: GRADE CHECKER
# ============================================================================
print("\n--- Example 2: Grade Checker ---")

def grade_checker(score):
    """Determines grade based on score"""
    if score >= 90:
        grade = "A"
    elif score >= 80:
        grade = "B"
    elif score >= 70:
        grade = "C"
    elif score >= 60:
        grade = "D"
    else:
        grade = "F"
    
    return grade

# Test with different scores
test_scores = [95, 85, 75, 65, 55]
for score in test_scores:
    grade = grade_checker(score)
    print(f"Score: {score} -> Grade: {grade}")

# Uncomment below to take interactive input:
# score = float(input("Enter your score (0-100): "))
# print(f"Your grade is: {grade_checker(score)}")


# ============================================================================
# 15. PRACTICAL EXAMPLE 3: FIBONACCI SEQUENCE
# ============================================================================
print("\n--- Example 3: Fibonacci Sequence ---")

def fibonacci_sequence(n):
    """Generates first n Fibonacci numbers"""
    print(f"First {n} Fibonacci numbers: ", end="")
    a, b = 0, 1
    count = 0
    
    while count < n:
        print(a, end=" ")
        a, b = b, a + b
        count += 1
    
    print()  # New line at the end

# Generate first 10 Fibonacci numbers
fibonacci_sequence(10)

# Uncomment below to take interactive input:
# n = int(input("How many Fibonacci numbers? "))
# fibonacci_sequence(n)


# ============================================================================
# 16. ADDITIONAL PRACTICE
# ============================================================================
print("\n--- Additional Practice ---")

# Practice: Swap two variables
x, y = 10, 20
print(f"Before swap: x={x}, y={y}")
x, y = y, x
print(f"After swap: x={x}, y={y}")

# Practice: Check if number is even or odd
def check_even_odd(num):
    return "Even" if num % 2 == 0 else "Odd"

print(f"Is 7 even or odd? {check_even_odd(7)}")
print(f"Is 12 even or odd? {check_even_odd(12)}")

# Practice: Simple multiplication table
print("\nMultiplication table of 5:")
for i in range(1, 6):
    print(f"5 × {i} = {5 * i}")

print("\n--- End of Python Fundamentals Examples ---")
