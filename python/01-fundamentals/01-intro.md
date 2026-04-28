# Python Fundamentals - Introduction & Basics

## 1. What is Python?

Python is a high-level, interpreted programming language known for its simplicity and readability. It was created by Guido van Rossum and released in 1991. Python is widely used in:
- Data Science & Machine Learning
- Web Development
- Data Engineering
- Automation & Scripting
- Artificial Intelligence

**Key Characteristics:**
- **Easy to Learn:** Readable syntax similar to natural English
- **Interpreted:** Code is executed line by line
- **Dynamically Typed:** Variable types are determined at runtime
- **Object-Oriented:** Supports classes and objects
- **Versatile:** Works for multiple programming paradigms

---

## 2. Python Syntax Basics

### Comments
```python
# This is a single-line comment

"""
This is a multi-line comment
It can span multiple lines
Used for docstrings
"""
```

### Indentation
Python uses **indentation** to define code blocks (no {}):
```python
if 5 > 2:
    print("Five is greater than two")  # Indented with 4 spaces
```

---

## 3. Variables and Data Types

### Declaring Variables
Python doesn't require explicit type declaration:
```python
name = "John"           # String
age = 25                # Integer
height = 5.9            # Float
is_student = True       # Boolean
```

### Basic Data Types

| Type | Example | Description |
|------|---------|-------------|
| `str` | `"Hello"`, `'World'` | Text/String |
| `int` | `42`, `-10`, `0` | Whole numbers |
| `float` | `3.14`, `-2.5`, `0.0` | Decimal numbers |
| `bool` | `True`, `False` | Boolean values |
| `NoneType` | `None` | Represents absence of value |

### Checking Data Types
```python
x = 10
print(type(x))  # Output: <class 'int'>

name = "Alice"
print(type(name))  # Output: <class 'str'>
```

---

## 4. Input and Output

### Print Output
```python
print("Hello, World!")

x = 10
y = 20
print(x, y)  # Output: 10 20
print("x =", x, "and y =", y)  # Output: x = 10 and y = 20
```

### String Formatting
```python
# f-strings (Python 3.6+)
name = "Bob"
age = 30
print(f"My name is {name} and I am {age} years old")

# .format() method
print("My name is {} and I am {} years old".format(name, age))

# % formatting (older style)
print("My name is %s and I am %d years old" % (name, age))
```

### Taking Input
```python
# input() always returns a string
user_name = input("Enter your name: ")
print(f"Hello, {user_name}!")

# For numeric input, convert the type
age = int(input("Enter your age: "))
height = float(input("Enter your height: "))
```

---

## 5. Operators

### Arithmetic Operators
```python
a = 10
b = 3

print(a + b)  # Addition: 13
print(a - b)  # Subtraction: 7
print(a * b)  # Multiplication: 30
print(a / b)  # Division: 3.333...
print(a // b) # Floor Division: 3
print(a % b)  # Modulus (Remainder): 1
print(a ** b) # Exponentiation: 1000
```

### Comparison Operators
```python
x = 5
y = 10

print(x == y)  # Equal to: False
print(x != y)  # Not equal to: True
print(x > y)   # Greater than: False
print(x < y)   # Less than: True
print(x >= y)  # Greater than or equal to: False
print(x <= y)  # Less than or equal to: True
```

### Logical Operators
```python
a = True
b = False

print(a and b)  # Logical AND: False
print(a or b)   # Logical OR: True
print(not a)    # Logical NOT: False

# Practical example
age = 25
print(age > 18 and age < 60)  # True
```

### Assignment Operators
```python
x = 5
x += 3      # x = x + 3  (x = 8)
x -= 2      # x = x - 2  (x = 6)
x *= 2      # x = x * 2  (x = 12)
x /= 3      # x = x / 3  (x = 4.0)
```

---

## 6. Type Conversion

Converting between data types:
```python
# String to Integer
str_num = "42"
num = int(str_num)
print(num, type(num))  # 42 <class 'int'>

# Integer to String
num = 100
str_num = str(num)
print(str_num, type(str_num))  # 100 <class 'str'>

# String to Float
pi = float("3.14")
print(pi)  # 3.14

# Integer to Float
count = 5
decimal = float(count)
print(decimal)  # 5.0

# To Boolean
print(bool(1))      # True
print(bool(0))      # False
print(bool("text")) # True
print(bool(""))     # False
```

---

## 7. Strings

### Creating Strings
```python
single = 'Hello'
double = "World"
multi = """This is a 
multi-line string"""
```

### String Methods
```python
text = "Hello World"

print(text.upper())           # HELLO WORLD
print(text.lower())           # hello world
print(text.replace("World", "Python"))  # Hello Python
print(text.split())           # ['Hello', 'World']
print("  spaces  ".strip())   # "spaces" (removes leading/trailing spaces)
print(text.find("World"))     # 6 (index position)
print(text.startswith("Hello"))  # True
print(text.endswith("World"))    # True
```

### String Indexing and Slicing
```python
text = "Python"

print(text[0])      # P (first character)
print(text[-1])     # n (last character)
print(text[1:4])    # yth (characters from index 1 to 3)
print(text[:3])     # Pyt (first 3 characters)
print(text[3:])     # hon (from index 3 onwards)
```

---

## 8. Basic Control Flow

### Conditional Statements
```python
age = 20

if age < 13:
    print("You are a child")
elif age < 18:
    print("You are a teenager")
elif age < 60:
    print("You are an adult")
else:
    print("You are a senior")
```

### Ternary Operator
```python
age = 20
status = "Adult" if age >= 18 else "Minor"
print(status)  # Adult
```

---

## 9. Common Built-in Functions

```python
# abs() - Absolute value
print(abs(-5))  # 5

# len() - Length
print(len("Hello"))  # 5

# min() and max()
numbers = [5, 2, 8, 1, 9]
print(min(numbers))  # 1
print(max(numbers))  # 9

# sum() - Sum of elements
print(sum([1, 2, 3, 4]))  # 10

# round() - Round to nearest integer
print(round(3.7))  # 4

# sorted() - Sort a list
print(sorted([3, 1, 4, 1, 5]))  # [1, 1, 3, 4, 5]

# range() - Generate sequence
for i in range(5):  # 0, 1, 2, 3, 4
    print(i)
```

---

## 10. Practical Examples

### Example 1: Simple Calculator
```python
# Take two numbers and an operation
num1 = float(input("Enter first number: "))
operation = input("Enter operation (+, -, *, /): ")
num2 = float(input("Enter second number: "))

if operation == "+":
    print(f"Result: {num1 + num2}")
elif operation == "-":
    print(f"Result: {num1 - num2}")
elif operation == "*":
    print(f"Result: {num1 * num2}")
elif operation == "/":
    if num2 != 0:
        print(f"Result: {num1 / num2}")
    else:
        print("Error: Division by zero!")
else:
    print("Invalid operation!")
```

### Example 2: Grade Checker
```python
score = float(input("Enter your score (0-100): "))

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

print(f"Your grade is: {grade}")
```

### Example 3: Fibonacci Sequence
```python
n = int(input("How many Fibonacci numbers? "))

a, b = 0, 1
count = 0

while count < n:
    print(a, end=" ")
    a, b = b, a + b
    count += 1
```

---

## 11. Key Takeaways

✅ Python is simple, readable, and beginner-friendly  
✅ Use proper indentation for code blocks  
✅ Variables are dynamically typed  
✅ Python has basic data types: str, int, float, bool  
✅ Operators (arithmetic, comparison, logical) are essential  
✅ Use f-strings for modern string formatting  
✅ Conditional logic (if/elif/else) controls program flow  
✅ Built-in functions provide common operations  

---

## 12. Next Steps

Once you're comfortable with these fundamentals:
- Learn about **Lists, Tuples, and Dictionaries**
- Understand **Loops** (for, while)
- Explore **Functions** and scope
- Study **Object-Oriented Programming (OOP)**
- Work with **Modules and Packages**
