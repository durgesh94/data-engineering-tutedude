# Variables and Data Types in Python - Comprehensive Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Variables](#variables)
3. [Data Types Overview](#data-types-overview)
4. [Primitive Data Types](#primitive-data-types)
5. [Data Type Comparisons](#data-type-comparisons)
6. [Type Conversion](#type-conversion)
7. [Mutability and Immutability](#mutability-and-immutability)
8. [Best Practices](#best-practices)

---

## Introduction

Variables are containers for storing data values. Python is **dynamically typed**, meaning you don't need to declare a variable's type explicitly—Python infers it from the assigned value. Data types define the kind of data a variable can hold and what operations can be performed on it.

### Key Concept: Dynamic Typing
```python
x = 5           # x is an integer
x = "Hello"     # Now x is a string (type changed!)
x = 3.14        # Now x is a float
```

---

## Variables

### Variable Naming Rules

Variable names must follow these rules:
1. **Must start with a letter (a-z, A-Z) or underscore (_)**
2. **Can contain alphanumeric characters (0-9) and underscores**
3. **Case-sensitive** (`name` ≠ `Name` ≠ `NAME`)
4. **Cannot contain spaces**
5. **Cannot use Python reserved keywords** (if, for, while, class, etc.)

### Valid Variable Names
```python
name = "John"
_age = 25
age2 = 30
userName = "alice"
user_name = "bob"
USER_ID = 123
```

### Invalid Variable Names
```python
2name = "John"              # ✗ Starts with number
user-name = "alice"         # ✗ Contains hyphen
first name = "John"         # ✗ Contains space
if = 10                     # ✗ Reserved keyword
```

### Naming Conventions (PEP 8)

Python follows PEP 8 naming conventions:

| Convention | Usage | Example |
|-----------|-------|---------|
| **snake_case** | Variables and functions | `my_var`, `calculate_sum()` |
| **PascalCase** | Classes | `MyClass`, `DatabaseConnection` |
| **UPPER_CASE** | Constants | `MAX_SIZE`, `PI` |

```python
# Good naming conventions
user_name = "Alice"
total_amount = 100.50
is_active = True

def calculate_average():
    pass

class UserProfile:
    pass

MAX_ATTEMPTS = 5
DB_HOST = "localhost"
```

---

## Data Types Overview

Python has several built-in data types:

### Core Data Types

| Category | Data Type | Example | Mutable? |
|----------|-----------|---------|----------|
| **Numeric** | int | 42, -5, 0 | No |
| | float | 3.14, -2.5, 0.0 | No |
| | complex | 3+4j | No |
| **Text** | str | "Hello", 'World' | No |
| **Boolean** | bool | True, False | No |
| **None** | NoneType | None | No |
| **Collection** | list | [1, 2, 3] | Yes |
| | tuple | (1, 2, 3) | No |
| | set | {1, 2, 3} | Yes |
| | dict | {"name": "John"} | Yes |
| **Bytes** | bytes | b"Hello" | No |
| | bytearray | bytearray(b"Hello") | Yes |

```python
# Quick type check
print(type(42))          # <class 'int'>
print(type(3.14))        # <class 'float'>
print(type("Hello"))     # <class 'str'>
print(type(True))        # <class 'bool'>
print(type(None))        # <class 'NoneType'>
```

---

## Primitive Data Types

### 1. Integer (`int`)

Integers are whole numbers without decimal points. Python supports unlimited precision integers.

#### Basic Usage
```python
positive = 42
negative = -10
zero = 0

# Checking if a number is an integer
print(isinstance(42, int))  # True
print(isinstance(3.14, int))  # False
```

#### Integer Operations
```python
a = 10
b = 3

print(a + b)      # 13 (Addition)
print(a - b)      # 7 (Subtraction)
print(a * b)      # 30 (Multiplication)
print(a / b)      # 3.333... (True Division - returns float)
print(a // b)     # 3 (Floor Division - returns int)
print(a % b)      # 1 (Modulus - remainder)
print(a ** b)     # 1000 (Exponentiation)
```

#### Integer Bases
```python
decimal = 255       # Base 10
binary = 0b11111111 # Base 2 (binary) = 255
octal = 0o377       # Base 8 (octal) = 255
hexadecimal = 0xFF  # Base 16 (hexadecimal) = 255

print(decimal == binary == octal == hexadecimal)  # True
```

#### Large Integers
```python
large_num = 123456789012345678901234567890
print(large_num)  # Python handles arbitrarily large integers!

# Underscore for readability (Python 3.6+)
million = 1_000_000
billion = 1_000_000_000
```

### 2. Float (`float`)

Floats are numbers with decimal points. They represent approximations due to binary representation.

#### Basic Usage
```python
pi = 3.14159
temperature = -5.5
zero = 0.0

# Scientific notation
scientific = 1.5e-3  # 0.0015
large = 2.5e8        # 250000000
```

#### Float Operations
```python
a = 10.5
b = 3.2

print(a + b)      # 13.7
print(a - b)      # 7.3
print(a * b)      # 33.6
print(a / b)      # 3.28125
print(a // b)     # 3.0 (Floor division with float)
print(a % b)      # 1.3 (Modulus with float)
print(a ** b)     # ~2254.86 (Exponentiation)
```

#### Float Precision Issues
```python
# Be aware of floating-point precision
result = 0.1 + 0.2
print(result)           # 0.30000000000000004 (not exactly 0.3!)
print(result == 0.3)    # False

# Solution: Use the round() function or decimal module
print(round(result, 1)) # 0.3

# Or use the decimal module for precise arithmetic
from decimal import Decimal
a = Decimal('0.1')
b = Decimal('0.2')
print(a + b)  # 0.3
```

#### Infinity and NaN
```python
import math

infinity = float('inf')
neg_infinity = float('-inf')
not_a_number = float('nan')

print(infinity > 1000000)  # True
print(math.isinf(infinity))  # True
print(math.isnan(not_a_number))  # True
```

### 3. Complex (`complex`)

Complex numbers have a real and imaginary part.

#### Basic Usage
```python
z1 = 3 + 4j
z2 = 1 - 2j

print(z1)  # (3+4j)
print(z1.real)  # 3.0 (real part)
print(z1.imag)  # 4.0 (imaginary part)
```

#### Complex Operations
```python
z1 = 3 + 4j
z2 = 1 - 2j

print(z1 + z2)  # (4+2j)
print(z1 - z2)  # (2+6j)
print(z1 * z2)  # (11+5j)
print(z1 / z2)  # (-1+2j)

# Conjugate
print(z1.conjugate())  # (3-4j)

# Magnitude
print(abs(z1))  # 5.0 (sqrt(3^2 + 4^2))
```

### 4. String (`str`)

Strings are sequences of characters. They are immutable.

#### Creating Strings
```python
single_quote = 'Hello'
double_quote = "World"
triple_quote = """Multi-line
string example"""

# Empty string
empty = ""

# Escaping quotes
with_quote = 'It\'s a string'
with_double = "He said \"Hi\""
```

#### String Concatenation
```python
first = "Hello"
last = "World"

# Using + operator
result = first + " " + last
print(result)  # Hello World

# Using f-strings (modern way)
name = "Alice"
age = 30
message = f"My name is {name} and I am {age} years old"
print(message)

# Using .format()
message = "My name is {} and I am {} years old".format(name, age)

# Using % formatting (older style)
message = "My name is %s and I am %d years old" % (name, age)
```

#### String Methods
```python
text = "  Hello World  "

# Case conversion
print(text.upper())              # "  HELLO WORLD  "
print(text.lower())              # "  hello world  "
print(text.title())              # "  Hello World  "
print(text.capitalize())         # "  hello world  "

# Whitespace removal
print(text.strip())              # "Hello World"
print(text.lstrip())             # "Hello World  "
print(text.rstrip())             # "  Hello World"

# Searching
print("World" in text)           # True
print(text.find("World"))        # 8 (index position)
print(text.index("World"))       # 8 (same as find, but raises error if not found)
print(text.count("l"))           # 3

# Replacement
print(text.replace("World", "Python"))  # "  Hello Python  "

# Splitting and joining
words = text.split()             # ['Hello', 'World']
print("-".join(words))           # "Hello-World"

# Testing
print(text.startswith("Hello"))  # False (due to spaces)
print(text.strip().startswith("Hello"))  # True
print(text.endswith("World  "))  # True
print("123".isdigit())           # True
print("abc".isalpha())           # True
print("abc123".isalnum())        # True
```

#### String Indexing and Slicing
```python
text = "Python"

# Indexing (0-based)
print(text[0])      # 'P' (first character)
print(text[1])      # 'y'
print(text[-1])     # 'n' (last character)
print(text[-2])     # 'o' (second from last)

# Slicing [start:end:step]
print(text[0:3])    # 'Pyt' (indices 0, 1, 2)
print(text[1:4])    # 'yth'
print(text[:3])     # 'Pyt' (from beginning to index 2)
print(text[3:])     # 'hon' (from index 3 to end)
print(text[::2])    # 'Pto' (every second character)
print(text[::-1])   # 'nohtyP' (reversed)
```

#### String Raw and Byte Strings
```python
# Raw strings (ignore escape sequences)
regular = "C:\new\file"  # Interprets \n as newline
raw = r"C:\new\file"     # Treats \ literally: C:\new\file

# Byte strings
byte_str = b"Hello"      # <class 'bytes'>
print(byte_str[0])       # 72 (ASCII value of 'H')
```

### 5. Boolean (`bool`)

Booleans represent truth values: `True` or `False`.

#### Boolean Values
```python
is_active = True
is_valid = False

print(type(True))   # <class 'bool'>
print(isinstance(True, int))  # True (bool is subclass of int!)

# Boolean is actually an int
print(int(True))    # 1
print(int(False))   # 0
print(True + True)  # 2
```

#### Truthy and Falsy Values
Values that evaluate to `False` in boolean context:
- `False` (boolean)
- `0` (zero)
- `0.0` (zero float)
- `''` (empty string)
- `[]` (empty list)
- `()` (empty tuple)
- `{}` (empty dict)
- `None` (null value)
- `set()` (empty set)

```python
# Falsy values
print(bool(0))          # False
print(bool(""))         # False
print(bool([]))         # False
print(bool(None))       # False

# Truthy values
print(bool(1))          # True
print(bool("Hello"))    # True
print(bool([1, 2]))     # True
print(bool(42))         # True
```

#### Boolean Operations
```python
print(True and True)    # True
print(True and False)   # False
print(True or False)    # True
print(not True)         # False

# Short-circuit evaluation
print(False and 1/0)    # False (1/0 is never evaluated!)
print(True or 1/0)      # True (1/0 is never evaluated!)
```

### 6. None (`NoneType`)

`None` represents the absence of a value. It's Python's null equivalent.

#### Using None
```python
x = None
print(x)                # None
print(type(None))       # <class 'NoneType'>
print(x is None)        # True (use 'is' for None comparison)

# Default parameter
def greet(name=None):
    if name is None:
        print("Hello, stranger!")
    else:
        print(f"Hello, {name}!")

greet()           # Hello, stranger!
greet("Alice")    # Hello, Alice!
```

---

## Data Type Comparisons

### Numeric Type Comparisons

```python
# Integer vs Float
print(5 == 5.0)      # True (value equality)
print(5 is 5.0)      # False (different types)

# Type preservation in operations
print(type(5 + 2))       # <class 'int'>
print(type(5 + 2.0))     # <class 'float'>
print(type(5 / 2))       # <class 'float'> (always float!)
print(type(5 // 2))      # <class 'int'> (floor division)

# Integer vs Float precision
print(1/3)               # 0.3333333333333333
print(1.0/3.0)           # 0.3333333333333333
```

### String vs Other Types

```python
# String is always different from numbers
print("5" == 5)          # False
print("5" + "5")         # "55" (concatenation)
print(int("5") + 5)      # 10 (after conversion)

# String comparison (lexicographic)
print("Apple" < "Banana")  # True
print("apple" < "banana")  # True
print("Apple" < "apple")   # True (uppercase comes before lowercase in ASCII)
```

### Collection Type Comparisons

```python
# Lists vs Tuples vs Sets
list1 = [1, 2, 3]
tuple1 = (1, 2, 3)
set1 = {1, 2, 3}

print(list1 == tuple1)   # False (different types)
print(list1 == list(tuple1))  # True (same content)

# Mutability difference
list1[0] = 10            # Works
print(list1)             # [10, 2, 3]

# tuple1[0] = 10          # Error! tuples are immutable
# set1[0] = 10            # Error! sets are unordered
```

### Special Comparisons

```python
# None comparisons
x = None
y = None
print(x == y)           # True
print(x is y)           # True (same object)

# Boolean with numbers
print(True == 1)        # True
print(False == 0)       # True
print(True > False)     # True

# Type checking
print(type(True) == bool)       # True
print(isinstance(True, int))    # True (bool is subclass of int)
```

---

## Type Conversion

### Implicit Type Conversion (Coercion)

Python automatically converts types in certain operations:

```python
# Integer + Float = Float
result = 5 + 2.0
print(result)          # 7.0
print(type(result))    # <class 'float'>

# Boolean in arithmetic
result = True + 5
print(result)          # 6 (True = 1)

# String concatenation requires explicit conversion
# print("Age: " + 25)  # Error!
print("Age: " + str(25))  # "Age: 25"
```

### Explicit Type Conversion (Casting)

Convert types using constructor functions:

```python
# To Integer
print(int(3.14))            # 3 (truncates decimal)
print(int("42"))            # 42
print(int(True))            # 1
print(int(False))           # 0
# print(int("3.14"))        # Error! Must be whole number string

# To Float
print(float(42))            # 42.0
print(float("3.14"))        # 3.14
print(float(True))          # 1.0

# To String
print(str(42))              # "42"
print(str(3.14))            # "3.14"
print(str([1, 2, 3]))       # "[1, 2, 3]"

# To Boolean
print(bool(1))              # True
print(bool(0))              # False
print(bool(""))             # False
print(bool("text"))         # True

# To Complex
print(complex(5))           # (5+0j)
print(complex(3, 4))        # (3+4j)
```

### Type Conversion Chaining

```python
# Multiple conversions
value = "3.14"
result = int(float(value))  # First: "3.14" -> 3.14, Then: 3.14 -> 3
print(result)               # 3

# Practical example
user_input = input("Enter a number: ")  # Always a string
number = int(user_input)
result = number * 2
print(f"Double is {result}")
```

---

## Mutability and Immutability

### Immutable Types

Immutable types cannot be changed after creation. Operations create new objects.

```python
# Strings are immutable
text = "Hello"
# text[0] = 'J'  # Error! Can't modify

# Creating new string
text = "J" + text[1:]  # "Jello"

# Integers and floats are immutable
x = 10
x = x + 5  # Creates new object, doesn't modify original

# Tuples are immutable
tuple1 = (1, 2, 3)
# tuple1[0] = 10  # Error!

# Booleans and None are immutable
is_active = True
# is_active[0] = False  # Error!
```

### Mutable Types

Mutable types can be changed after creation.

```python
# Lists are mutable
list1 = [1, 2, 3]
list1[0] = 10           # Direct modification
print(list1)            # [10, 2, 3]

list1.append(4)         # Add element
print(list1)            # [10, 2, 3, 4]

# Dictionaries are mutable
dict1 = {"name": "Alice", "age": 25}
dict1["age"] = 26       # Modify value
dict1["city"] = "NYC"   # Add new key
print(dict1)            # {'name': 'Alice', 'age': 26, 'city': 'NYC'}

# Sets are mutable
set1 = {1, 2, 3}
set1.add(4)             # Add element
set1.remove(1)          # Remove element
print(set1)             # {2, 3, 4}
```

### Implications of Mutability

```python
# Mutable types share references
list1 = [1, 2, 3]
list2 = list1           # Both point to same object
list2[0] = 10
print(list1)            # [10, 2, 3] (list1 also changed!)

# To create a copy
list2 = list1.copy()    # Or list1[:] or list(list1)
list2[0] = 10
print(list1)            # [1, 2, 3] (unchanged)

# Immutable types don't have this issue
x = 5
y = x
y = 10
print(x)                # 5 (unchanged)
```

---

## Best Practices

### 1. Use Meaningful Variable Names
```python
# ✓ Good
user_age = 25
total_price = 99.99
is_active = True

# ✗ Bad
a = 25
x = 99.99
flag = True
```

### 2. Follow PEP 8 Naming Conventions
```python
# ✓ Good
MAX_RETRIES = 3
user_name = "Alice"

def calculate_total():
    pass

class DataProcessor:
    pass

# ✗ Bad
maxRetries = 3
UserName = "Alice"

def CalculateTotal():
    pass

class dataProcessor:
    pass
```

### 3. Use Type Hints (Python 3.5+)
```python
def greet(name: str, age: int) -> str:
    return f"Hello {name}, you are {age} years old"

# With variables
user_name: str = "Alice"
user_age: int = 25
is_active: bool = True
```

### 4. Validate Type Conversions
```python
# ✓ Safe conversion
user_input = input("Enter your age: ")
try:
    age = int(user_input)
except ValueError:
    print("Invalid input. Please enter a number.")
    age = 0

# ✓ Check before conversion
if user_input.isdigit():
    age = int(user_input)
```

### 5. Use `is` for None Comparison
```python
# ✓ Correct
if value is None:
    print("Value is None")

# ✗ Avoid
if value == None:
    print("Value is None")
```

### 6. Understand Mutable vs Immutable
```python
# ✓ Correct - immutable for default parameters
def append_item(item, items=None):
    if items is None:
        items = []
    items.append(item)
    return items

# ✗ Avoid - mutable default (dangerous!)
def append_item(item, items=[]):  # Same list used for all calls!
    items.append(item)
    return items
```

---

## Summary Table

| Type | Mutable? | Example | Ordered? |
|------|----------|---------|----------|
| int | No | 42 | N/A |
| float | No | 3.14 | N/A |
| str | No | "Hello" | Yes |
| bool | No | True | N/A |
| NoneType | No | None | N/A |
| list | Yes | [1, 2, 3] | Yes |
| tuple | No | (1, 2, 3) | Yes |
| set | Yes | {1, 2, 3} | No |
| dict | Yes | {"a": 1} | Yes (Python 3.7+) |
| bytes | No | b"Hello" | Yes |

---

## Practice Exercises

1. **Create variables** of each primitive type and print their types
2. **Convert between types** - Turn a string into an int, then to float
3. **Test mutability** - Modify a list and a string, observe the differences
4. **Explore methods** - Try different string methods on a sample text
5. **Check truthiness** - Test various values in `if` statements
