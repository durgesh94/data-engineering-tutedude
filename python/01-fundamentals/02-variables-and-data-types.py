"""
Variables and Data Types - Practical Examples
All examples from variables-and-data-types.md in executable form
"""

# ============================================================================
# 1. VARIABLE NAMING AND CONVENTIONS
# ============================================================================
print("\n=== Variable Naming ===")

# Valid variable names
name = "John"
_age = 25
age2 = 30
userName = "alice"
user_name = "bob"
USER_ID = 123

print(f"name: {name}")
print(f"_age: {_age}")
print(f"USER_ID: {USER_ID}")


# ============================================================================
# 2. BASIC DATA TYPES
# ============================================================================
print("\n=== Basic Data Types ===")

# Integers
positive = 42
negative = -10
zero = 0
print(f"Integer: {positive}, type: {type(positive)}")

# Floats
pi = 3.14159
temperature = -5.5
print(f"Float: {pi}, type: {type(pi)}")

# Strings
single_quote = 'Hello'
double_quote = "World"
empty = ""
print(f"String: {single_quote} {double_quote}")

# Booleans
is_active = True
is_valid = False
print(f"Boolean: {is_active}, type: {type(is_active)}")

# None
x = None
print(f"None: {x}, type: {type(x)}")


# ============================================================================
# 3. TYPE CHECKING
# ============================================================================
print("\n=== Type Checking ===")

# Using type()
print(f"type(42): {type(42)}")
print(f"type(3.14): {type(3.14)}")
print(f"type('Hello'): {type('Hello')}")
print(f"type(True): {type(True)}")

# Using isinstance()
print(f"isinstance(42, int): {isinstance(42, int)}")
print(f"isinstance(3.14, float): {isinstance(3.14, float)}")


# ============================================================================
# 4. NUMERIC COMPARISONS
# ============================================================================
print("\n=== Numeric Comparisons ===")

# int vs float
print(f"5 == 5.0: {5 == 5.0}")
print(f"type(5 + 2): {type(5 + 2)}")
print(f"type(5 + 2.0): {type(5 + 2.0)}")
print(f"type(5 / 2): {type(5 / 2)}")  # Always float!
print(f"type(5 // 2): {type(5 // 2)}")  # Floor division


# ============================================================================
# 5. STRINGS - METHODS
# ============================================================================
print("\n=== String Methods ===")

text = "  Hello World  "

print(f"upper(): '{text.upper()}'")
print(f"lower(): '{text.lower()}'")
print(f"title(): '{text.title()}'")
print(f"capitalize(): '{text.capitalize()}'")
print(f"strip(): '{text.strip()}'")
print(f"lstrip(): '{text.lstrip()}'")
print(f"rstrip(): '{text.rstrip()}'")
print(f"replace('World', 'Python'): '{text.replace('World', 'Python')}'")
print(f"split(): {text.split()}")
print(f"count('l'): {text.count('l')}")
print(f"find('World'): {text.find('World')}")
print(f"startswith('Hello'): {text.strip().startswith('Hello')}")
print(f"endswith('World'): {text.strip().endswith('World')}")


# ============================================================================
# 6. STRING INDEXING AND SLICING
# ============================================================================
print("\n=== String Indexing and Slicing ===")

text = "Python"

print(f"text[0]: '{text[0]}'")      # First character
print(f"text[1]: '{text[1]}'")      # Second character
print(f"text[-1]: '{text[-1]}'")    # Last character
print(f"text[-2]: '{text[-2]}'")    # Second from last
print(f"text[0:3]: '{text[0:3]}'")  # First 3 chars
print(f"text[1:4]: '{text[1:4]}'")  # Index 1 to 3
print(f"text[:3]: '{text[:3]}'")    # From start to index 2
print(f"text[3:]: '{text[3:]}'")    # From index 3 to end
print(f"text[::2]: '{text[::2]}'")  # Every second character
print(f"text[::-1]: '{text[::-1]}'")# Reversed


# ============================================================================
# 7. TRUTHY AND FALSY VALUES
# ============================================================================
print("\n=== Truthy and Falsy Values ===")

# Falsy values
print(f"bool(0): {bool(0)}")                # False
print(f"bool(0.0): {bool(0.0)}")            # False
print(f"bool(''): {bool('')}")              # False
print(f"bool([]): {bool([])}")              # False
print(f"bool(()): {bool(())}")              # False
print(f"bool({{}})): {bool({})}")           # False
print(f"bool(None): {bool(None)}")          # False

# Truthy values
print(f"bool(1): {bool(1)}")                # True
print(f"bool('Hello'): {bool('Hello')}")    # True
print(f"bool([1, 2]): {bool([1, 2])}")      # True
print(f"bool((1, 2)): {bool((1, 2))}")      # True
print(f"bool({{'a': 1}}): {bool({'a': 1})}")  # True


# ============================================================================
# 8. INTEGER OPERATIONS
# ============================================================================
print("\n=== Integer Operations ===")

a = 10
b = 3

print(f"Addition: {a} + {b} = {a + b}")
print(f"Subtraction: {a} - {b} = {a - b}")
print(f"Multiplication: {a} * {b} = {a * b}")
print(f"Division: {a} / {b} = {a / b}")
print(f"Floor Division: {a} // {b} = {a // b}")
print(f"Modulus: {a} % {b} = {a % b}")
print(f"Exponentiation: {a} ** {b} = {a ** b}")


# ============================================================================
# 9. INTEGER BASES
# ============================================================================
print("\n=== Integer Bases ===")

decimal = 255
binary = 0b11111111
octal = 0o377
hexadecimal = 0xFF

print(f"Decimal: {decimal}")
print(f"Binary: {binary}")
print(f"Octal: {octal}")
print(f"Hexadecimal: {hexadecimal}")
print(f"All equal: {decimal == binary == octal == hexadecimal}")

# Large integers
million = 1_000_000
billion = 1_000_000_000
print(f"Million: {million}")
print(f"Billion: {billion}")


# ============================================================================
# 10. FLOAT PRECISION
# ============================================================================
print("\n=== Float Precision ===")

# Precision issue
result = 0.1 + 0.2
print(f"0.1 + 0.2 = {result}")
print(f"result == 0.3: {result == 0.3}")

# Solution: round()
print(f"round(result, 1): {round(result, 1)}")

# Using Decimal for precision
from decimal import Decimal
a = Decimal('0.1')
b = Decimal('0.2')
print(f"Decimal('0.1') + Decimal('0.2') = {a + b}")


# ============================================================================
# 11. COMPLEX NUMBERS
# ============================================================================
print("\n=== Complex Numbers ===")

z1 = 3 + 4j
z2 = 1 - 2j

print(f"z1: {z1}")
print(f"Real part: {z1.real}")
print(f"Imaginary part: {z1.imag}")

print(f"z1 + z2 = {z1 + z2}")
print(f"z1 - z2 = {z1 - z2}")
print(f"z1 * z2 = {z1 * z2}")
print(f"z1 / z2 = {z1 / z2}")
print(f"Conjugate: {z1.conjugate()}")
print(f"Magnitude: {abs(z1)}")


# ============================================================================
# 12. BOOLEAN OPERATIONS
# ============================================================================
print("\n=== Boolean Operations ===")

print(f"True and True: {True and True}")
print(f"True and False: {True and False}")
print(f"False and False: {False and False}")

print(f"True or True: {True or True}")
print(f"True or False: {True or False}")
print(f"False or False: {False or False}")

print(f"not True: {not True}")
print(f"not False: {not False}")


# ============================================================================
# 13. MUTABILITY - IMMUTABLE VS MUTABLE
# ============================================================================
print("\n=== Mutability ===")

# Immutable: Strings
text = "Hello"
print(f"Original string: {text}")
# text[0] = 'J'  # Error! Can't modify
text = "J" + text[1:]
print(f"Modified string: {text}")

# Immutable: Tuples
tuple1 = (1, 2, 3)
print(f"Tuple: {tuple1}")
# tuple1[0] = 10  # Error! Can't modify

# Mutable: Lists
list1 = [1, 2, 3]
print(f"Original list: {list1}")
list1[0] = 10  # Can modify
print(f"Modified list: {list1}")

# Mutable: Dictionaries
dict1 = {"name": "Alice", "age": 25}
print(f"Original dict: {dict1}")
dict1["age"] = 26  # Can modify
dict1["city"] = "NYC"  # Can add
print(f"Modified dict: {dict1}")


# ============================================================================
# 14. VARIABLE REFERENCES
# ============================================================================
print("\n=== Variable References and Mutability ===")

# Mutable types share references
list1 = [1, 2, 3]
list2 = list1  # Both point to same object
list2[0] = 10
print(f"list1: {list1}")  # Changed!
print(f"list2: {list2}")

# Create a copy
list3 = list1.copy()
list3[0] = 99
print(f"After modifying list3:")
print(f"list1: {list1}")  # Unchanged
print(f"list3: {list3}")

# Immutable types don't have this issue
x = 5
y = x
y = 10
print(f"x: {x}")  # 5 (unchanged)
print(f"y: {y}")  # 10


# ============================================================================
# 15. STRING EQUALITY vs IDENTITY
# ============================================================================
print("\n=== Equality vs Identity ===")

a = [1, 2, 3]
b = [1, 2, 3]
c = a

print(f"a == b: {a == b}")  # True (same content)
print(f"a is b: {a is b}")  # False (different objects)

print(f"a == c: {a == c}")  # True (same content)
print(f"a is c: {a is c}")  # True (same object)

# With immutables
x = 5
y = 5
print(f"x == y: {x == y}")  # True
print(f"x is y: {x is y}")  # True (small integers cached)


# ============================================================================
# 16. TYPE CONVERSION EXAMPLES
# ============================================================================
print("\n=== Type Conversion ===")

# String to Integer
str_num = "42"
num = int(str_num)
print(f"int('42'): {num}, type: {type(num)}")

# Integer to String
num = 100
str_num = str(num)
print(f"str(100): '{str_num}', type: {type(str_num)}")

# String to Float
pi = float("3.14")
print(f"float('3.14'): {pi}")

# Integer to Float
count = 5
decimal = float(count)
print(f"float(5): {decimal}")

# To Boolean
print(f"bool(1): {bool(1)}")
print(f"bool(0): {bool(0)}")
print(f"bool('text'): {bool('text')}")
print(f"bool(''): {bool('')}")


# ============================================================================
# 17. PRACTICAL EXAMPLES
# ============================================================================
print("\n=== Practical Examples ===")

# Even/Odd checker
def check_even_odd(num):
    return "Even" if num % 2 == 0 else "Odd"

print(f"Is 7 even or odd? {check_even_odd(7)}")
print(f"Is 12 even or odd? {check_even_odd(12)}")

# Grade calculator
def get_grade(score):
    if score >= 90:
        return 'A'
    elif score >= 80:
        return 'B'
    elif score >= 70:
        return 'C'
    elif score >= 60:
        return 'D'
    else:
        return 'F'

print(f"Score 85 -> Grade {get_grade(85)}")
print(f"Score 92 -> Grade {get_grade(92)}")

# BMI calculator
height = 1.75  # meters
weight = 70    # kg
bmi = weight / (height ** 2)
print(f"BMI: {bmi:.2f}")

print("\n=== End of Variables and Data Types Examples ===")
