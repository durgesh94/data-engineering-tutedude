# Constants and Type Casting in Python - Comprehensive Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Constants](#constants)
3. [Type Casting (Type Conversion)](#type-casting)
4. [Casting to Integer](#casting-to-integer)
5. [Casting to Float](#casting-to-float)
6. [Casting to String](#casting-to-string)
7. [Casting to Boolean](#casting-to-boolean)
8. [Advanced Type Conversions](#advanced-type-conversions)
9. [Error Handling in Type Casting](#error-handling-in-type-casting)
10. [Best Practices](#best-practices)
11. [Real-World Examples](#real-world-examples)

---

## Introduction

### Constants
Constants are variables that hold values that should not change after being set. While Python doesn't enforce immutability at language level, conventions exist for marking values as constants.

### Type Casting
Type casting (also called type conversion) is the process of converting a value from one data type to another. This is essential for working with different data types and handling user input.

---

## Constants

### What are Constants?

Constants are values that remain fixed throughout a program's execution. Unlike some languages, Python doesn't have a keyword to enforce constants, but developers use conventions to indicate constant values.

### Naming Convention for Constants

By convention, constants are written in **UPPER_CASE with underscores**:

```python
# Constants (by convention)
PI = 3.14159
MAX_USERS = 100
MIN_PASSWORD_LENGTH = 8
DATABASE_HOST = "localhost"
DATABASE_PORT = 5432
TIMEOUT_SECONDS = 30

# Not constants (variables)
user_count = 5
is_active = True
temperature = 25.5
```

### Common Constants in Python

```python
# Mathematical constants
import math

PI = math.pi                    # 3.141592653589793
E = math.e                      # 2.718281828459045
INFINITY = math.inf
NAN = math.nan

# Built-in constants
print(None)                     # None
print(True)                     # True
print(False)                    # False

# Application constants
APP_NAME = "MyApp"
APP_VERSION = "1.0.0"
DEBUG_MODE = False

# API and configuration constants
API_BASE_URL = "https://api.example.com"
API_KEY = "your-secret-key"
API_TIMEOUT = 30

# System constants
MAX_RETRIES = 3
BATCH_SIZE = 1000
QUEUE_SIZE = 5000
```

### Defining Constants in a Module

```python
# constants.py
"""Module containing application constants"""

# Database
DB_HOST = "localhost"
DB_PORT = 5432
DB_NAME = "myapp"
DB_USER = "admin"

# API
API_TIMEOUT = 60
API_RETRIES = 3

# Application
APP_VERSION = "1.0.0"
MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 MB
UPLOAD_DIR = "/uploads"

# Using the module
# import constants
# url = constants.DB_HOST
```

### Protecting Constants with Properties

```python
class Config:
    """Configuration class with protected constants"""
    
    _PI = 3.14159
    _MAX_ATTEMPTS = 5
    
    @property
    def PI(self):
        return self._PI
    
    @property
    def MAX_ATTEMPTS(self):
        return self._MAX_ATTEMPTS

# Usage
config = Config()
print(config.PI)                # 3.14159

# Attempting to modify (still possible but discouraged)
# config.PI = 3.14              # Works but goes against convention
```

### Using enums for Constants

```python
from enum import Enum

class Status(Enum):
    """Status constants using Enum"""
    PENDING = "pending"
    ACTIVE = "active"
    INACTIVE = "inactive"
    DELETED = "deleted"

class Priority(Enum):
    """Priority constants"""
    LOW = 1
    MEDIUM = 2
    HIGH = 3
    CRITICAL = 4

# Usage
current_status = Status.ACTIVE
task_priority = Priority.HIGH

print(current_status.value)     # "active"
print(task_priority.value)      # 3

# Check status
if current_status == Status.ACTIVE:
    print("System is active")

# Iterate through constants
for status in Status:
    print(status.name, status.value)
```

---

## Type Casting (Type Conversion)

Type casting converts a value from one data type to another. Python provides built-in functions for type conversion.

### Types of Type Casting

1. **Implicit Casting**: Automatic conversion by Python
2. **Explicit Casting**: Manual conversion using built-in functions

### Implicit Type Casting

Python automatically converts types in certain situations:

```python
# int + float = float
result = 5 + 2.5
print(result)                   # 7.5
print(type(result))            # <class 'float'>

# Boolean arithmetic
result = True + 5
print(result)                   # 6 (True = 1)

# String in operations
# print("5" + 5)               # TypeError! No automatic conversion

# List + List
list1 = [1, 2]
list2 = [3, 4]
result = list1 + list2
print(result)                   # [1, 2, 3, 4]
```

---

## Casting to Integer

The `int()` function converts values to integers.

### Syntax
```python
int(value, base=10)
```

### From String to Integer

```python
# String with digits
string_num = "42"
number = int(string_num)
print(number)                   # 42
print(type(number))            # <class 'int'>

# String with floating point
# int("3.14")                  # ValueError!

# String with leading/trailing spaces
number = int("  42  ")
print(number)                   # 42

# String with sign
number = int("-50")
print(number)                   # -50

# String with different bases
binary = int("1010", 2)        # Binary to int
print(binary)                   # 10

octal = int("77", 8)           # Octal to int
print(octal)                    # 63

hexadecimal = int("FF", 16)    # Hex to int
print(hexadecimal)              # 255
```

### From Float to Integer

```python
# Truncates decimal part (doesn't round)
number = int(3.7)
print(number)                   # 3 (not 4!)

number = int(3.1)
print(number)                   # 3

number = int(3.9)
print(number)                   # 3 (truncates, doesn't round)

# Negative numbers
number = int(-3.9)
print(number)                   # -3 (truncates towards zero)

# Using round() before int() for rounding
number = int(round(3.7))
print(number)                   # 4
```

### From Boolean to Integer

```python
number = int(True)
print(number)                   # 1

number = int(False)
print(number)                   # 0
```

### From Other Types to Integer

```python
# From complex (not recommended)
# int(3+4j)                     # TypeError!

# Character from ASCII
char_value = ord('A')           # Get ASCII value
print(char_value)               # 65

# Convert back to character
character = chr(65)
print(character)                # 'A'
```

---

## Casting to Float

The `float()` function converts values to floats.

### Syntax
```python
float(value)
```

### From String to Float

```python
# String with decimal
float_num = float("3.14")
print(float_num)                # 3.14

# String with integer
float_num = float("10")
print(float_num)                # 10.0

# String with scientific notation
float_num = float("1.5e-3")
print(float_num)                # 0.0015

float_num = float("2.5e2")
print(float_num)                # 250.0

# String with spaces
float_num = float("  3.14  ")
print(float_num)                # 3.14

# Special float values
float_num = float("inf")        # Infinity
print(float_num)                # inf

float_num = float("-inf")       # Negative infinity
print(float_num)                # -inf

float_num = float("nan")        # Not a Number
print(float_num)                # nan
```

### From Integer to Float

```python
float_num = float(42)
print(float_num)                # 42.0

float_num = float(-10)
print(float_num)                # -10.0
```

### From Boolean to Float

```python
float_num = float(True)
print(float_num)                # 1.0

float_num = float(False)
print(float_num)                # 0.0
```

### Using Decimal for Precision

```python
from decimal import Decimal

# Regular float (precision issues)
print(0.1 + 0.2)                # 0.30000000000000004

# Decimal (precise)
result = Decimal('0.1') + Decimal('0.2')
print(result)                   # 0.3

# Converting to Decimal
price = Decimal('19.99')
quantity = 3
total = price * quantity
print(total)                    # 59.97
```

---

## Casting to String

The `str()` function converts values to strings.

### Syntax
```python
str(value)
```

### From Integer to String

```python
string_num = str(42)
print(string_num)               # "42"
print(type(string_num))        # <class 'str'>

# Concatenation (requires string)
result = "Age: " + str(25)
print(result)                   # "Age: 25"
```

### From Float to String

```python
string_num = str(3.14159)
print(string_num)               # "3.14159"

# Scientific notation
string_num = str(1.5e-3)
print(string_num)               # "0.0015"
```

### From Boolean to String

```python
string_bool = str(True)
print(string_bool)              # "True"

string_bool = str(False)
print(string_bool)              # "False"
```

### From Collection to String

```python
# List to string
list_data = [1, 2, 3]
string_list = str(list_data)
print(string_list)              # "[1, 2, 3]"

# Dictionary to string
dict_data = {"name": "Alice", "age": 25}
string_dict = str(dict_data)
print(string_dict)              # "{'name': 'Alice', 'age': 25}"

# Better way: use json for structured data
import json
json_string = json.dumps(dict_data)
print(json_string)              # '{"name": "Alice", "age": 25}'
```

### From None to String

```python
string_none = str(None)
print(string_none)              # "None"
```

### Custom String Representation

```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __str__(self):
        return f"{self.name} ({self.age} years old)"
    
    def __repr__(self):
        return f"Person('{self.name}', {self.age})"

# Usage
person = Person("Alice", 30)
print(str(person))              # "Alice (30 years old)"
print(repr(person))             # "Person('Alice', 30)"
```

---

## Casting to Boolean

The `bool()` function converts values to booleans.

### Syntax
```python
bool(value)
```

### Truthiness Rules

Values that evaluate to **False**:
- `False` (boolean)
- `0` (integer)
- `0.0` (float)
- `''` (empty string)
- `[]` (empty list)
- `()` (empty tuple)
- `{}` (empty dictionary)
- `None` (null value)
- `set()` (empty set)

All other values evaluate to **True**.

### From Integer to Boolean

```python
print(bool(0))                  # False
print(bool(1))                  # True
print(bool(-1))                 # True
print(bool(42))                 # True
print(bool(-42))                # True
```

### From String to Boolean

```python
print(bool(""))                 # False (empty string)
print(bool("0"))                # True (non-empty string)
print(bool("False"))            # True (non-empty string)
print(bool("Hello"))            # True

# Note: str(False) = "False" but bool("False") = True!
```

### From Collection to Boolean

```python
print(bool([]))                 # False (empty list)
print(bool([1, 2, 3]))          # True (non-empty list)

print(bool(()))                 # False (empty tuple)
print(bool((1, 2)))             # True (non-empty tuple)

print(bool({}))                 # False (empty dict)
print(bool({"a": 1}))           # True (non-empty dict)

print(bool(set()))              # False (empty set)
print(bool({1, 2}))             # True (non-empty set)
```

### From None to Boolean

```python
print(bool(None))               # False
```

### Practical Use Cases

```python
# Check if list is empty
items = []
if items:
    print("List has items")
else:
    print("List is empty")

# Check if string is empty
text = ""
if text:
    print("Text has content")
else:
    print("Text is empty")

# Check if value exists
value = None
if value:
    print("Value exists")
else:
    print("Value is None or falsy")
```

---

## Advanced Type Conversions

### Converting Between Collections

```python
# List to Tuple
list_data = [1, 2, 3]
tuple_data = tuple(list_data)
print(tuple_data)               # (1, 2, 3)

# Tuple to List
tuple_data = (1, 2, 3)
list_data = list(tuple_data)
print(list_data)                # [1, 2, 3]

# List to Set (removes duplicates)
list_data = [1, 2, 2, 3, 3, 3]
set_data = set(list_data)
print(set_data)                 # {1, 2, 3}

# Set to List
set_data = {1, 2, 3}
list_data = list(set_data)
print(list_data)                # [1, 2, 3] (order may vary)

# String to List (characters)
text = "Hello"
char_list = list(text)
print(char_list)                # ['H', 'e', 'l', 'l', 'o']

# List of characters to String
char_list = ['H', 'e', 'l', 'l', 'o']
text = ''.join(char_list)
print(text)                     # "Hello"
```

### Converting Bytes

```python
# String to Bytes
text = "Hello"
bytes_data = text.encode()
print(bytes_data)               # b'Hello'

bytes_data = text.encode('utf-8')
print(bytes_data)               # b'Hello'

# Bytes to String
bytes_data = b'Hello'
text = bytes_data.decode()
print(text)                     # "Hello"

text = bytes_data.decode('utf-8')
print(text)                     # "Hello"

# Integer to Bytes
number = 255
bytes_data = bytes([number])
print(bytes_data)               # b'\xff'

# Bytearray (mutable bytes)
bytes_data = bytearray([72, 101, 108, 108, 111])
print(bytes_data)               # bytearray(b'Hello')
bytes_data[0] = 74              # Change 'H' to 'J'
print(bytes_data)               # bytearray(b'Jello')
```

### Using ast.literal_eval for Safe Evaluation

```python
import ast

# Safe evaluation of string representations
string_list = "[1, 2, 3]"
actual_list = ast.literal_eval(string_list)
print(actual_list)              # [1, 2, 3]

string_dict = "{'name': 'Alice', 'age': 25}"
actual_dict = ast.literal_eval(string_dict)
print(actual_dict)              # {'name': 'Alice', 'age': 25}

string_tuple = "(1, 2, 3)"
actual_tuple = ast.literal_eval(string_tuple)
print(actual_tuple)             # (1, 2, 3)
```

### Using json for Data Conversion

```python
import json

# Dictionary to JSON string
data = {"name": "Alice", "age": 25, "skills": ["Python", "SQL"]}
json_string = json.dumps(data)
print(json_string)

# JSON string to Dictionary
json_string = '{"name": "Bob", "age": 30}'
data = json.loads(json_string)
print(data)

# Pretty printing JSON
json_string = json.dumps(data, indent=2)
print(json_string)
```

---

## Error Handling in Type Casting

### Common Casting Errors

```python
# ValueError: String cannot be converted to int
try:
    number = int("3.14")        # String with decimal
except ValueError as e:
    print(f"Error: {e}")

# ValueError: Invalid literal
try:
    number = int("abc")         # Non-numeric string
except ValueError as e:
    print(f"Error: {e}")

# TypeError: Unsupported type
try:
    number = int([1, 2, 3])     # List cannot convert to int
except TypeError as e:
    print(f"Error: {e}")
```

### Safe Type Conversion Functions

```python
def safe_int(value, default=0):
    """Safely convert to int with default"""
    try:
        return int(value)
    except (ValueError, TypeError):
        return default

# Usage
print(safe_int("42"))           # 42
print(safe_int("abc"))          # 0 (default)
print(safe_int("3.14"))         # 0 (default)

def safe_float(value, default=0.0):
    """Safely convert to float with default"""
    try:
        return float(value)
    except (ValueError, TypeError):
        return default

print(safe_float("3.14"))       # 3.14
print(safe_float("abc"))        # 0.0 (default)

def safe_bool(value, default=False):
    """Safely convert to bool with default"""
    try:
        if isinstance(value, str):
            return value.lower() in ['true', 'yes', '1']
        return bool(value)
    except:
        return default

print(safe_bool("true"))        # True
print(safe_bool("yes"))         # True
print(safe_bool("false"))       # False
```

### Validating Type Before Conversion

```python
# Check type before conversion
value = "42"

if isinstance(value, str):
    try:
        number = int(value)
        print(f"Converted: {number}")
    except ValueError:
        print("Invalid integer string")
elif isinstance(value, float):
    number = int(value)
    print(f"Converted: {number}")

# Check if value is numeric
import numbers

value = 42
if isinstance(value, numbers.Number):
    print("Value is numeric")

# Check if value is iterable
from collections.abc import Iterable

value = [1, 2, 3]
if isinstance(value, Iterable):
    print("Value is iterable")
```

---

## Best Practices

### 1. Use Type Hints

```python
# ✓ Clear type hints
def convert_to_int(value: str) -> int:
    return int(value)

def calculate_total(price: float, quantity: int) -> float:
    return price * quantity

# Type hints help with IDE autocompletion and static analysis
```

### 2. Validate Input Before Casting

```python
# ✓ Validate before conversion
def get_age_from_input(user_input: str) -> int:
    if not user_input.isdigit():
        raise ValueError("Age must be a valid number")
    
    age = int(user_input)
    if age < 0 or age > 150:
        raise ValueError("Age must be between 0 and 150")
    
    return age

# ✗ Don't assume input is valid
def get_age_from_input_bad(user_input):
    return int(user_input)  # Will crash on invalid input
```

### 3. Use Constants for Magic Values

```python
# ✓ Use constants
MAX_AGE = 150
MIN_AGE = 0
MAX_ATTEMPTS = 3

if age > MAX_AGE:
    print("Invalid age")

# ✗ Magic numbers scattered in code
if age > 150:
    print("Invalid age")
```

### 4. Handle Exceptions Properly

```python
# ✓ Specific exception handling
try:
    value = int(user_input)
except ValueError:
    print("Please enter a valid number")
except TypeError:
    print("Input must be a string or number")

# ✗ Catch-all exception
try:
    value = int(user_input)
except Exception:
    print("Error")
```

### 5. Use Appropriate Conversion Functions

```python
# ✓ Clear intent
from decimal import Decimal

# For monetary values
price = Decimal('19.99')

# For precise calculations
from fractions import Fraction
fraction = Fraction(1, 3)

# For collections
items = list(range(10))
unique_items = set(items)

# ✗ Don't use inappropriate conversions
price_float = float('19.99')  # Precision issues with money
```

### 6. Prefer Modern String Formatting

```python
# ✓ f-strings (Python 3.6+)
name = "Alice"
age = 25
message = f"{name} is {age} years old"

# ✗ String concatenation with conversion
message = name + " is " + str(age) + " years old"
```

---

## Real-World Examples

### Example 1: User Registration Form

```python
class UserRegistration:
    """Handle user registration with type validation"""
    
    MIN_AGE = 18
    MAX_AGE = 120
    MIN_PASSWORD_LENGTH = 8
    
    @staticmethod
    def validate_and_convert(username, age_str, password):
        """Validate and convert user inputs"""
        
        # Username (string)
        if not isinstance(username, str) or len(username) < 3:
            raise ValueError("Username must be at least 3 characters")
        
        # Age (convert string to int)
        try:
            age = int(age_str)
        except ValueError:
            raise ValueError("Age must be a valid number")
        
        if not (UserRegistration.MIN_AGE <= age <= UserRegistration.MAX_AGE):
            raise ValueError(f"Age must be between {UserRegistration.MIN_AGE} and {UserRegistration.MAX_AGE}")
        
        # Password (string)
        if len(password) < UserRegistration.MIN_PASSWORD_LENGTH:
            raise ValueError(f"Password must be at least {UserRegistration.MIN_PASSWORD_LENGTH} characters")
        
        return username, age, password

# Usage
try:
    username, age, password = UserRegistration.validate_and_convert("alice_123", "25", "secure_pass_123")
    print(f"Registration successful: {username}, Age: {age}")
except ValueError as e:
    print(f"Registration error: {e}")
```

### Example 2: Data Type Conversion Pipeline

```python
class DataConverter:
    """Convert different data types through a pipeline"""
    
    @staticmethod
    def normalize_phone(phone_input):
        """Convert and normalize phone number"""
        # Convert to string
        phone_str = str(phone_input)
        # Remove non-digits
        phone_clean = ''.join(c for c in phone_str if c.isdigit())
        # Format
        if len(phone_clean) == 10:
            return f"({phone_clean[:3]}) {phone_clean[3:6]}-{phone_clean[6:]}"
        return phone_clean
    
    @staticmethod
    def parse_csv_row(row_str, types):
        """Parse CSV row with type conversion"""
        values = row_str.split(',')
        
        result = []
        for value, type_func in zip(values, types):
            try:
                result.append(type_func(value.strip()))
            except (ValueError, TypeError):
                result.append(None)
        
        return result

# Usage
phone = DataConverter.normalize_phone(9876543210)
print(phone)                    # "(987) 654-3210"

csv_row = "Alice,25,19.99,true"
types = [str, int, float, lambda x: x.lower() == 'true']
parsed = DataConverter.parse_csv_row(csv_row, types)
print(parsed)                   # ['Alice', 25, 19.99, True]
```

### Example 3: Configuration File Loader

```python
import json
from pathlib import Path

class ConfigLoader:
    """Load and convert configuration values"""
    
    DEFAULTS = {
        "host": "localhost",
        "port": 5432,
        "debug": False,
        "timeout": 30,
        "max_connections": 100
    }
    
    @staticmethod
    def load_config(filepath):
        """Load config from JSON file"""
        try:
            with open(filepath, 'r') as f:
                config = json.load(f)
        except (FileNotFoundError, json.JSONDecodeError):
            config = {}
        
        # Merge with defaults and convert types
        final_config = {}
        
        for key, default_value in ConfigLoader.DEFAULTS.items():
            value = config.get(key, default_value)
            
            # Type conversion based on default type
            if isinstance(default_value, bool):
                if isinstance(value, str):
                    final_config[key] = value.lower() in ['true', 'yes', '1']
                else:
                    final_config[key] = bool(value)
            elif isinstance(default_value, int):
                final_config[key] = int(value)
            elif isinstance(default_value, float):
                final_config[key] = float(value)
            else:
                final_config[key] = str(value)
        
        return final_config

# Usage
# config.json: {"host": "192.168.1.1", "port": "3306", "debug": "true"}
config = ConfigLoader.load_config("config.json")
print(config)
```

### Example 4: Currency Conversion

```python
from decimal import Decimal, ROUND_HALF_UP

class CurrencyConverter:
    """Handle currency conversion with precision"""
    
    EXCHANGE_RATES = {
        "USD_to_EUR": Decimal("0.92"),
        "USD_to_GBP": Decimal("0.73"),
        "USD_to_INR": Decimal("83.12")
    }
    
    @staticmethod
    def convert(amount, from_currency, to_currency):
        """Convert between currencies"""
        # Convert input to Decimal for precision
        amount_decimal = Decimal(str(amount))
        
        rate_key = f"{from_currency}_to_{to_currency}"
        
        if rate_key not in CurrencyConverter.EXCHANGE_RATES:
            raise ValueError(f"Conversion rate not available: {rate_key}")
        
        rate = CurrencyConverter.EXCHANGE_RATES[rate_key]
        result = amount_decimal * rate
        
        # Round to 2 decimal places
        return float(result.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP))
    
    @staticmethod
    def format_currency(amount, currency="USD"):
        """Format amount as currency"""
        symbols = {
            "USD": "$",
            "EUR": "€",
            "GBP": "£",
            "INR": "₹"
        }
        
        symbol = symbols.get(currency, currency)
        # Convert to float and format with 2 decimals
        amount_float = float(amount)
        return f"{symbol}{amount_float:.2f}"

# Usage
amount_usd = 100
amount_eur = CurrencyConverter.convert(amount_usd, "USD", "EUR")
print(CurrencyConverter.format_currency(amount_eur, "EUR"))  # €92.00
```

### Example 5: Type-Safe Data Validator

```python
from typing import Any, Type, Union
import re

class TypeValidator:
    """Validate and convert data types safely"""
    
    @staticmethod
    def validate_email(email: str) -> str:
        """Validate and return email"""
        if not re.match(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$', email):
            raise ValueError("Invalid email format")
        return email
    
    @staticmethod
    def validate_range(value: Union[int, float], min_val: float, max_val: float) -> float:
        """Validate value is in range"""
        float_value = float(value)
        if not (min_val <= float_value <= max_val):
            raise ValueError(f"Value must be between {min_val} and {max_val}")
        return float_value
    
    @staticmethod
    def validate_length(value: str, min_len: int, max_len: int) -> str:
        """Validate string length"""
        if not (min_len <= len(value) <= max_len):
            raise ValueError(f"Length must be between {min_len} and {max_len}")
        return value
    
    @staticmethod
    def validate_choice(value: str, choices: list) -> str:
        """Validate value is in choices"""
        if value not in choices:
            raise ValueError(f"Value must be one of: {', '.join(choices)}")
        return value

# Usage
try:
    email = TypeValidator.validate_email("user@example.com")
    percentage = TypeValidator.validate_range(75, 0, 100)
    status = TypeValidator.validate_choice("active", ["active", "inactive", "pending"])
    print(f"Valid: {email}, {percentage}, {status}")
except ValueError as e:
    print(f"Validation error: {e}")
```

---

## Summary

**Constants:**
- Use **UPPER_CASE** naming convention
- Python doesn't enforce immutability, use convention
- Use Enums for related constant groups
- Store in separate modules for organization

**Type Casting:**
- **`int()`** - convert to integer (truncates floats)
- **`float()`** - convert to float
- **`str()`** - convert to string
- **`bool()`** - convert to boolean
- **Use Decimal** for precise financial calculations
- **Validate input** before casting
- **Handle exceptions** appropriately
- **Use type hints** for clarity

**Best Practices:**
✅ Use type hints  
✅ Validate before converting  
✅ Handle exceptions  
✅ Use constants for static values  
✅ Use appropriate data types (Decimal for money)  
✅ Prefer modern string formatting (f-strings)  
✅ Use safe conversion functions  
✅ Check types before operations  

**Quick Reference:**
```python
# Constants
PI = 3.14159
MAX_USERS = 100

# Type Casting
int_value = int("42")
float_value = float(3.14)
str_value = str(100)
bool_value = bool(1)

# Safe Conversion
try:
    value = int(user_input)
except ValueError:
    print("Invalid input")
```
