# Basic Operators in Python - Comprehensive Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Arithmetic Operators](#arithmetic-operators)
3. [Comparison (Relational) Operators](#comparison-operators)
4. [Logical Operators](#logical-operators)
5. [Bitwise Operators](#bitwise-operators)
6. [Assignment Operators](#assignment-operators)
7. [Membership Operators](#membership-operators)
8. [Identity Operators](#identity-operators)
9. [Operator Precedence](#operator-precedence)
10. [Best Practices](#best-practices)
11. [Real-World Examples](#real-world-examples)

---

## Introduction

Operators are special symbols that perform operations on values and variables. Python supports several types of operators:

- **Arithmetic**: Mathematical calculations
- **Comparison**: Comparing values
- **Logical**: Boolean operations
- **Bitwise**: Binary operations
- **Assignment**: Assigning values
- **Membership**: Checking membership in collections
- **Identity**: Checking object identity

---

## Arithmetic Operators

Arithmetic operators perform mathematical operations on numeric values.

### Basic Arithmetic Operators

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `+` | Addition | `5 + 3` | `8` |
| `-` | Subtraction | `5 - 3` | `2` |
| `*` | Multiplication | `5 * 3` | `15` |
| `/` | Division | `5 / 2` | `2.5` |
| `//` | Floor Division | `5 // 2` | `2` |
| `%` | Modulus (Remainder) | `5 % 2` | `1` |
| `**` | Exponentiation | `5 ** 2` | `25` |

### Addition (`+`)

```python
# Integer addition
print(10 + 5)           # 15

# Float addition
print(10.5 + 2.5)       # 13.0

# Mixed int and float (result is float)
print(10 + 2.5)         # 12.5

# String concatenation (not numeric addition)
print("Hello" + " " + "World")  # "Hello World"

# List concatenation
list1 = [1, 2]
list2 = [3, 4]
print(list1 + list2)    # [1, 2, 3, 4]
```

### Subtraction (`-`)

```python
# Integer subtraction
print(10 - 5)           # 5

# Float subtraction
print(10.5 - 2.5)       # 8.0

# Negative numbers
print(5 - 10)           # -5

# Unary minus
x = 5
print(-x)               # -5
```

### Multiplication (`*`)

```python
# Integer multiplication
print(5 * 3)            # 15

# Float multiplication
print(5.5 * 2)          # 11.0

# String repetition
print("Hi" * 3)         # "HiHiHi"

# List repetition
print([1, 2] * 3)       # [1, 2, 1, 2, 1, 2]

# Zero multiplication
print(5 * 0)            # 0
```

### Division (`/`)

**Important:** Always returns a float, even with integer operands.

```python
# Integer division (returns float)
print(10 / 2)           # 5.0
print(5 / 2)            # 2.5

# Float division
print(10.0 / 3.0)       # 3.333...

# Division by zero raises error
# print(10 / 0)         # ZeroDivisionError!
```

### Floor Division (`//`)

Divides and returns the floor (largest integer ≤ result).

```python
# Positive floor division
print(10 // 3)          # 3 (10/3 = 3.333, floor = 3)
print(10 // 2)          # 5 (exact division)

# Negative floor division (rounds down to most negative)
print(-10 // 3)         # -4 (not -3!)
print(10 // -3)         # -4 (not -3!)

# Floor division by zero raises error
# print(10 // 0)        # ZeroDivisionError!
```

### Modulus (`%`) - Remainder

Returns the remainder after division.

```python
# Basic modulus
print(10 % 3)           # 1 (10 = 3*3 + 1)
print(5 % 2)            # 1
print(6 % 2)            # 0 (even number)

# Modulus with negative numbers
print(-10 % 3)          # 2 (Python always returns positive remainder's sign)
print(10 % -3)          # -2

# Use cases
print(7 % 2 == 0)       # False (7 is odd)
print(8 % 2 == 0)       # True (8 is even)

# Cycling through values
day_of_week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
day_number = 10
print(day_of_week[day_number % 7])  # "Wed" (day 10 % 7 = 3)
```

### Exponentiation (`**`)

Raises a number to a power.

```python
# Integer exponentiation
print(2 ** 3)           # 8 (2 to the power of 3)
print(5 ** 2)           # 25 (5 squared)
print(10 ** 0)          # 1 (any number to power 0)

# Float exponentiation
print(2.5 ** 2)         # 6.25

# Negative exponent (reciprocal)
print(2 ** -1)          # 0.5 (1/2)
print(10 ** -2)         # 0.01 (1/100)

# Square root (using 0.5 power)
print(9 ** 0.5)         # 3.0
print(16 ** 0.5)        # 4.0

# Cube root (using 1/3 power)
print(8 ** (1/3))       # 2.0

# Large powers
print(2 ** 100)         # Python handles large integers!
```

### Arithmetic Operations with Different Types

```python
# int and float mixing
print(type(5 + 2.0))    # <class 'float'>
print(type(5 - 2.0))    # <class 'float'>
print(type(5 * 2.0))    # <class 'float'>
print(type(5 / 2))      # <class 'float'> (always float!)

# Boolean arithmetic (True=1, False=0)
print(True + 5)         # 6
print(False * 10)       # 0
print(True ** 3)        # 1
```

---

## Comparison Operators

Comparison operators compare two values and return a boolean (True or False).

### Basic Comparison Operators

| Operator | Name | Example | Result |
|----------|------|---------|--------|
| `==` | Equal to | `5 == 5` | `True` |
| `!=` | Not equal to | `5 != 3` | `True` |
| `>` | Greater than | `5 > 3` | `True` |
| `<` | Less than | `5 < 3` | `False` |
| `>=` | Greater than or equal | `5 >= 5` | `True` |
| `<=` | Less than or equal | `5 <= 3` | `False` |

### Equality (`==` and `!=`)

```python
# Numeric equality
print(5 == 5)           # True
print(5 == 5.0)         # True (value equality)
print(5 != 3)           # True

# String equality
print("hello" == "hello")  # True
print("Hello" == "hello")  # False (case-sensitive)

# Type doesn't matter for ==
print(5 == 5.0)         # True
print(5 == "5")         # False (int ≠ string)

# List equality
print([1, 2] == [1, 2])  # True
print([1, 2] == [2, 1])  # False (order matters)

# None comparison
x = None
print(x == None)        # True
print(x is None)        # True (preferred way)
```

### Relational Operators (`>`, `<`, `>=`, `<=`)

```python
# Numeric comparison
print(10 > 5)           # True
print(10 < 5)           # False
print(10 >= 10)         # True
print(10 <= 9)          # False

# String comparison (lexicographic order)
print("apple" < "banana")      # True
print("zebra" > "apple")       # True
print("Apple" < "apple")       # True (uppercase < lowercase in ASCII)

# Comparison chain (works in Python)
x = 5
print(0 < x < 10)       # True (equivalent to: 0 < x AND x < 10)
print(1 < 2 < 1)        # False
print(10 > 5 >= 5)      # True

# Common mistake: don't use comparison chains incorrectly
print(1 < 2 > 0)        # True (1 < 2 AND 2 > 0)
```

### Comparing Different Types

```python
# int vs float
print(5 == 5.0)         # True
print(5 < 5.1)          # True

# String vs number
# print(5 < "10")       # TypeError! Can't compare different types

# None comparisons
print(None == None)     # True
print(None is None)     # True (preferred)

# Boolean vs int
print(True == 1)        # True
print(False == 0)       # True
print(True > False)     # True
```

---

## Logical Operators

Logical operators combine boolean values and return boolean results.

### Basic Logical Operators

| Operator | Meaning | Example | Returns True If |
|----------|---------|---------|-----------------|
| `and` | Logical AND | `a and b` | Both a and b are True |
| `or` | Logical OR | `a or b` | At least one is True |
| `not` | Logical NOT | `not a` | a is False |

### AND Operator (`and`)

Returns True only if both operands are True.

```python
# Basic AND
print(True and True)        # True
print(True and False)       # False
print(False and False)      # False

# AND with values
print(5 > 3 and 10 > 5)     # True
print(5 > 3 and 10 < 5)     # False

# AND with variables
age = 25
has_license = True
can_drive = age > 18 and has_license
print(can_drive)            # True

# Short-circuit evaluation (important!)
print(False and 1/0)        # False (1/0 is never evaluated!)
print(True and 1/0)         # ZeroDivisionError (1/0 is evaluated)
```

### OR Operator (`or`)

Returns True if at least one operand is True.

```python
# Basic OR
print(True or True)         # True
print(True or False)        # True
print(False or False)       # False

# OR with values
print(5 > 10 or 10 > 5)     # True
print(5 > 10 or 10 < 5)     # False

# OR with variables
is_weekend = False
is_holiday = True
has_day_off = is_weekend or is_holiday
print(has_day_off)          # True

# Short-circuit evaluation
print(True or 1/0)          # True (1/0 is never evaluated!)
print(False or 1/0)         # ZeroDivisionError (1/0 is evaluated)
```

### NOT Operator (`not`)

Inverts the boolean value.

```python
# Basic NOT
print(not True)             # False
print(not False)            # True

# NOT with expressions
print(not 5 > 3)            # False
print(not 5 < 3)            # True

# NOT with variables
is_active = False
is_inactive = not is_active
print(is_inactive)          # True

# Double negation
print(not not True)         # True
```

### Combining Logical Operators

```python
# Complex logic
age = 25
has_license = True
is_sober = True

can_drive = age >= 18 and has_license and is_sober
print(can_drive)            # True

# Using precedence
print(True or False and False)  # True (AND has higher precedence)
# Equivalent to: True or (False and False)

# Using parentheses for clarity
print((True or False) and False)  # False
```

### Logical Operators with Truthy/Falsy Values

```python
# AND with truthy/falsy
print(5 and 10)             # 10 (returns last truthy value)
print(0 and 10)             # 0 (returns first falsy value)
print(5 and 0)              # 0
print("" and "Hello")       # "" (empty string is falsy)
print("Hello" and "World")  # "World"

# OR with truthy/falsy
print(5 or 10)              # 5 (returns first truthy value)
print(0 or 10)              # 10 (skips falsy, returns next)
print(0 or 0)               # 0
print("" or "Hello")        # "Hello"
print("Hello" or "World")   # "Hello"

# Practical: default values
username = None
name = username or "Anonymous"
print(name)                 # "Anonymous"

# Practical: short-circuit with and/or
result = True and True or False
print(result)               # True
```

---

## Bitwise Operators

Bitwise operators operate on binary representations of integers.

### Bitwise Operators

| Operator | Name | Example | Description |
|----------|------|---------|-------------|
| `&` | AND | `5 & 3` | Bitwise AND |
| `\|` | OR | `5 \| 3` | Bitwise OR |
| `^` | XOR | `5 ^ 3` | Bitwise XOR |
| `~` | NOT | `~5` | Bitwise NOT |
| `<<` | Left Shift | `5 << 1` | Left shift by n bits |
| `>>` | Right Shift | `5 >> 1` | Right shift by n bits |

### Bitwise AND (`&`)

```python
# 5 in binary: 101
# 3 in binary: 011
# AND result:  001 (1 in decimal)

print(5 & 3)            # 1
print(12 & 10)          # 8

# Use case: checking if bit is set
flags = 0b1010          # Binary 1010 = 10
print(flags & 0b0010)   # 2 (bit 1 is set)
print(flags & 0b0001)   # 0 (bit 0 is not set)
```

### Bitwise OR (`|`)

```python
# 5 in binary: 101
# 3 in binary: 011
# OR result:   111 (7 in decimal)

print(5 | 3)            # 7
print(12 | 10)          # 14

# Use case: setting flags
read = 0b0001
write = 0b0010
execute = 0b0100
permissions = read | write | execute
print(permissions)      # 7
```

### Bitwise XOR (`^`)

```python
# 5 in binary: 101
# 3 in binary: 011
# XOR result:  110 (6 in decimal)

print(5 ^ 3)            # 6
print(12 ^ 10)          # 6

# Use case: toggle bits
flags = 0b1010
flags = flags ^ 0b0001  # Toggle bit 0
print(flags)            # 11 (1011 in binary)
```

### Bitwise NOT (`~`)

Returns the two's complement (flips all bits).

```python
print(~5)               # -6
print(~0)               # -1
print(~(-1))            # 0

# Formula: ~x = -(x + 1)
print(~5)               # -6 (which is -(5 + 1))
```

### Bit Shift Operators

```python
# Left shift (<<) - multiply by 2^n
print(5 << 1)           # 10 (5 * 2^1)
print(5 << 2)           # 20 (5 * 2^2)

# Right shift (>>) - divide by 2^n
print(20 >> 1)          # 10 (20 / 2^1)
print(20 >> 2)          # 5 (20 / 2^2)

# Negative number shifts
print(-5 << 1)          # -10
print(-5 >> 1)          # -3
```

---

## Assignment Operators

Assignment operators assign values to variables and perform operations simultaneously.

### Basic Assignment Operators

| Operator | Example | Equivalent |
|----------|---------|-----------|
| `=` | `x = 5` | Assign |
| `+=` | `x += 5` | `x = x + 5` |
| `-=` | `x -= 5` | `x = x - 5` |
| `*=` | `x *= 5` | `x = x * 5` |
| `/=` | `x /= 5` | `x = x / 5` |
| `//=` | `x //= 5` | `x = x // 5` |
| `%=` | `x %= 5` | `x = x % 5` |
| `**=` | `x **= 5` | `x = x ** 5` |

### Compound Assignment Operators

```python
# Addition assignment
x = 10
x += 5      # x = x + 5
print(x)    # 15

# Subtraction assignment
x = 10
x -= 3      # x = x - 3
print(x)    # 7

# Multiplication assignment
x = 10
x *= 2      # x = x * 2
print(x)    # 20

# Division assignment
x = 10
x /= 2      # x = x / 2
print(x)    # 5.0

# Floor division assignment
x = 10
x //= 3     # x = x // 3
print(x)    # 3

# Modulus assignment
x = 10
x %= 3      # x = x % 3
print(x)    # 1

# Exponentiation assignment
x = 2
x **= 3     # x = x ** 3
print(x)    # 8
```

### Bitwise Assignment Operators

```python
# Bitwise AND assignment
x = 12
x &= 10     # x = x & 10
print(x)    # 8

# Bitwise OR assignment
x = 12
x |= 10     # x = x | 10
print(x)    # 14

# Bitwise XOR assignment
x = 12
x ^= 10     # x = x ^ 10
print(x)    # 6

# Left shift assignment
x = 5
x <<= 2     # x = x << 2
print(x)    # 20

# Right shift assignment
x = 20
x >>= 2     # x = x >> 2
print(x)    # 5
```

### Chained Assignment

```python
# Assign same value to multiple variables
x = y = z = 10
print(x, y, z)          # 10 10 10

# Tuple unpacking assignment
a, b, c = 1, 2, 3
print(a, b, c)          # 1 2 3

# Swap variables elegantly
x, y = 5, 10
x, y = y, x
print(x, y)             # 10 5
```

---

## Membership Operators

Membership operators check if a value exists in a sequence.

### Membership Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `in` | Value in sequence | `5 in [1, 2, 5]` |
| `not in` | Value not in sequence | `5 not in [1, 2]` |

### Using `in` Operator

```python
# Check in list
print(3 in [1, 2, 3, 4])        # True
print(5 in [1, 2, 3, 4])        # False

# Check in string
print('o' in "Hello")            # True
print('x' in "Hello")            # False

# Check in tuple
print(2 in (1, 2, 3))           # True

# Check in set
print(2 in {1, 2, 3})           # True

# Check in dictionary (checks keys)
print("name" in {"name": "Alice", "age": 25})  # True
print("Alice" in {"name": "Alice"})            # False (checks keys, not values)
print("Alice" in {"name": "Alice"}.values())   # True (check values)
```

### Using `not in` Operator

```python
# List
print(5 not in [1, 2, 3])       # True
print(1 not in [1, 2, 3])       # False

# String
print('x' not in "Hello")       # True
print('e' not in "Hello")       # False

# Practical use
allowed_users = ["Alice", "Bob", "Charlie"]
user = "David"
if user not in allowed_users:
    print(f"User {user} is not authorized")
```

---

## Identity Operators

Identity operators check if two variables refer to the same object (not just equal values).

### Identity Operators

| Operator | Meaning |
|----------|---------|
| `is` | Same object |
| `is not` | Not the same object |

### Using `is` Operator

```python
# None comparison (preferred way)
x = None
print(x is None)                # True
if x is None:
    print("x is None")

# Integer identity
a = 5
b = 5
print(a is b)                   # True (small integers cached)

a = 257
b = 257
print(a is b)                   # False (large integers not cached)

# String identity
s1 = "hello"
s2 = "hello"
print(s1 is s2)                 # True (string interning)

# List identity (different objects)
list1 = [1, 2, 3]
list2 = [1, 2, 3]
print(list1 == list2)           # True (same content)
print(list1 is list2)           # False (different objects)

# List reference
list1 = [1, 2, 3]
list2 = list1
print(list2 is list1)           # True (same object)
```

### Difference Between `==` and `is`

```python
# == checks VALUE equality
# is checks OBJECT IDENTITY

a = [1, 2, 3]
b = [1, 2, 3]
c = a

print(a == b)                   # True (same content)
print(a is b)                   # False (different objects)

print(a == c)                   # True (same content)
print(a is c)                   # True (same object)

# Rule of thumb
print(1 is 1)                   # True (but don't rely on this!)
print(1 == 1)                   # True (use == for value comparison)

print(None is None)             # True (use is for None)
print(True is True)             # True (use is for True/False)
```

---

## Operator Precedence

Operator precedence determines the order of evaluation when multiple operators are used.

### Precedence Table (Highest to Lowest)

| Precedence | Operators | Description |
|-----------|-----------|-------------|
| 1 | `()` | Parentheses |
| 2 | `**` | Exponentiation |
| 3 | `+x`, `-x`, `~x` | Unary plus, minus, bitwise NOT |
| 4 | `*`, `/`, `//`, `%` | Multiplication, division, floor division, modulus |
| 5 | `+`, `-` | Addition, subtraction |
| 6 | `<<`, `>>` | Bitwise shifts |
| 7 | `&` | Bitwise AND |
| 8 | `^` | Bitwise XOR |
| 9 | `\|` | Bitwise OR |
| 10 | `==`, `!=`, `<`, `<=`, `>`, `>=`, `is`, `is not`, `in`, `not in` | Comparisons |
| 11 | `not` | Logical NOT |
| 12 | `and` | Logical AND |
| 13 | `or` | Logical OR |

### Precedence Examples

```python
# Example 1: Arithmetic precedence
print(2 + 3 * 4)            # 14 (not 20)
# Evaluated as: 2 + (3 * 4)

print((2 + 3) * 4)          # 20
# Parentheses override precedence

# Example 2: Exponentiation before multiplication
print(2 * 3 ** 2)           # 18 (not 36)
# Evaluated as: 2 * (3 ** 2)

# Example 3: Comparison before logical
print(5 > 3 and 2 < 4)      # True
# Evaluated as: (5 > 3) and (2 < 4)

# Example 4: NOT before AND before OR
print(True or False and False)  # True
# Evaluated as: True or (False and False)

# Example 5: Complex expression
result = 2 + 3 * 4 ** 2 / 5 - 1
# Evaluated as: 2 + ((3 * (4 ** 2)) / 5) - 1
#            = 2 + ((3 * 16) / 5) - 1
#            = 2 + (48 / 5) - 1
#            = 2 + 9.6 - 1
#            = 10.6
print(result)               # 10.6
```

---

## Best Practices

### 1. Use Parentheses for Clarity

```python
# ✓ Clear
if (age > 18) and (has_license):
    print("Can drive")

# ✗ Unclear (relies on precedence)
if age > 18 and has_license:
    print("Can drive")
```

### 2. Use `is` for None and Booleans

```python
# ✓ Correct
if value is None:
    print("Value is None")

if flag is True:
    print("Flag is True")

# ✗ Avoid
if value == None:
    print("Value is None")

if flag == True:
    print("Flag is True")
```

### 3. Use `==` for Value Comparison

```python
# ✓ Correct
if x == 5:
    print("x equals 5")

# ✗ Avoid (identity can be unreliable)
if x is 5:
    print("x is 5")
```

### 4. Use Operator Precedence Knowingly

```python
# ✓ Use explicit parentheses for complex logic
result = (a and b) or (c and d)

# ✓ Split complex expressions
is_valid_age = age >= 18 and age <= 65
is_has_skills = has_degree and experience > 2
can_hire = is_valid_age and is_has_skills

# ✗ Avoid confusing one-liners
if age >= 18 and age <= 65 and has_degree and experience > 2:
    print("Can hire")
```

### 5. Avoid Division by Zero

```python
# ✓ Check for zero before division
if divisor != 0:
    result = dividend / divisor

# ✓ Use exception handling
try:
    result = dividend / divisor
except ZeroDivisionError:
    print("Cannot divide by zero")
```

### 6. Use Compound Assignment for Clarity

```python
# ✓ Clearer
x += 10

# ✗ Less clear
x = x + 10
```

### 7. Be Careful with Floating Point Comparisons

```python
# ✗ Unsafe (floating point precision issues)
if 0.1 + 0.2 == 0.3:
    print("Equal")

# ✓ Use tolerance
epsilon = 1e-9
if abs(0.1 + 0.2 - 0.3) < epsilon:
    print("Equal (within tolerance)")

# ✓ Or use Decimal module
from decimal import Decimal
a = Decimal('0.1') + Decimal('0.2')
b = Decimal('0.3')
if a == b:
    print("Equal")
```

---

## Real-World Examples

### Example 1: Temperature Converter

```python
def celsius_to_fahrenheit(celsius):
    """Convert Celsius to Fahrenheit"""
    fahrenheit = (celsius * 9/5) + 32
    return fahrenheit

def fahrenheit_to_celsius(fahrenheit):
    """Convert Fahrenheit to Celsius"""
    celsius = (fahrenheit - 32) * 5/9
    return celsius

# Usage
temp_c = 25
temp_f = celsius_to_fahrenheit(temp_c)
print(f"{temp_c}°C = {temp_f:.1f}°F")

# Check if comfortable
if 18 <= temp_c <= 25:
    print("Temperature is comfortable")
```

### Example 2: User Authentication

```python
def check_login(username, password, is_admin=False):
    """Check if user can login"""
    
    # Check credentials
    valid_username = username == "admin" or username == "user"
    valid_password = len(password) >= 8
    
    # Check permissions
    if is_admin and not (username == "admin"):
        return False, "Only admin can login with admin privileges"
    
    if valid_username and valid_password:
        return True, "Login successful"
    elif not valid_username:
        return False, "Invalid username"
    else:
        return False, "Password too short"

# Usage
success, message = check_login("admin", "password123", is_admin=True)
print(f"{'✓' if success else '✗'} {message}")
```

### Example 3: Grade Calculator

```python
def calculate_grade(score):
    """Calculate letter grade from score"""
    
    if not (0 <= score <= 100):
        return None, "Invalid score"
    
    if score >= 90:
        grade = 'A'
    elif score >= 80:
        grade = 'B'
    elif score >= 70:
        grade = 'C'
    elif score >= 60:
        grade = 'D'
    else:
        grade = 'F'
    
    # Advanced: Check for special cases
    is_perfect = score == 100
    is_failing = score < 60
    
    return grade, "Perfect!" if is_perfect else ("Failing" if is_failing else "")

# Usage
score = 85
grade, note = calculate_grade(score)
print(f"Score: {score}, Grade: {grade} {note}")

# Check eligibility
scores = [85, 72, 91, 58]
average = sum(scores) / len(scores)
qualified = average >= 70 and all(s >= 60 for s in scores)
print(f"Qualified: {qualified}")
```

### Example 4: Bitwise Permissions

```python
class FilePermissions:
    """Manage file permissions using bitwise operators"""
    
    READ = 0b001    # 1
    WRITE = 0b010   # 2
    EXECUTE = 0b100 # 4
    
    def __init__(self):
        self.perms = 0
    
    def add_permission(self, perm):
        """Add a permission"""
        self.perms |= perm
    
    def remove_permission(self, perm):
        """Remove a permission"""
        self.perms &= ~perm
    
    def has_permission(self, perm):
        """Check if has permission"""
        return (self.perms & perm) != 0
    
    def display(self):
        """Display current permissions"""
        perms_str = ""
        if self.has_permission(self.READ):
            perms_str += "r"
        if self.has_permission(self.WRITE):
            perms_str += "w"
        if self.has_permission(self.EXECUTE):
            perms_str += "x"
        return perms_str or "---"

# Usage
file_perms = FilePermissions()
file_perms.add_permission(FilePermissions.READ)
file_perms.add_permission(FilePermissions.WRITE)

print(f"Permissions: {file_perms.display()}")  # rw-

if file_perms.has_permission(FilePermissions.READ):
    print("Can read file")

file_perms.remove_permission(FilePermissions.WRITE)
print(f"After removal: {file_perms.display()}")  # r--
```

### Example 5: Complex Business Logic

```python
def check_loan_eligibility(age, income, credit_score, employment_years):
    """Check if customer is eligible for loan"""
    
    # Age check
    age_valid = 21 <= age <= 65
    
    # Income check (at least $30,000 annually)
    income_valid = income >= 30000
    
    # Credit score check (at least 600)
    credit_valid = credit_score >= 600
    
    # Employment check (at least 2 years)
    employment_valid = employment_years >= 2
    
    # Eligibility logic
    basic_eligible = age_valid and income_valid and credit_valid
    
    # Special case: new graduates
    new_graduate = age < 30 and employment_years >= 1
    
    # Final decision
    eligible = basic_eligible or (new_graduate and income_valid and credit_score >= 550)
    
    return {
        "eligible": eligible,
        "reasons": {
            "age": age_valid,
            "income": income_valid,
            "credit": credit_valid,
            "employment": employment_valid
        }
    }

# Usage
result = check_loan_eligibility(28, 35000, 580, 1)
print(f"Eligible: {result['eligible']}")
print(f"Details: {result['reasons']}")
```

---

## Summary

**Key Takeaways:**

✅ **Arithmetic Operators** (+, -, *, /, //, %, **) perform math  
✅ **Comparison Operators** (==, !=, <, >, <=, >=) return boolean  
✅ **Logical Operators** (and, or, not) combine booleans  
✅ **Bitwise Operators** (&, |, ^, ~, <<, >>) work on binary  
✅ **Assignment Operators** (=, +=, -=, etc.) assign and compute  
✅ **Membership Operators** (in, not in) check sequences  
✅ **Identity Operators** (is, is not) check object identity  
✅ **Use parentheses** for clarity even when not required  
✅ **Use `is` for None/True/False**, `==` for value comparison  
✅ **Understand precedence** to avoid bugs  

**Quick Reference:**
```python
# Arithmetic
result = 10 + 5 - 3 * 2 / 4 ** 2 % 3

# Comparison
if x > 5 and y < 10:
    pass

# Logical
if (condition1 or condition2) and not condition3:
    pass

# Assignment
x += 5

# Membership
if item in collection:
    pass

# Identity
if value is None:
    pass
```
