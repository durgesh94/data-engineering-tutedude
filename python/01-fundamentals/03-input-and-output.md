# Input and Output (I/O) in Python - Comprehensive Developer Guide

## Table of Contents
1. [Introduction](#introduction)
2. [Output with print()](#output-with-print)
3. [Input with input()](#input-with-input)
4. [String Formatting Methods](#string-formatting-methods)
5. [Standard I/O Streams](#standard-io-streams)
6. [File I/O Operations](#file-io-operations)
7. [Advanced Output Formatting](#advanced-output-formatting)
8. [Error Handling for I/O](#error-handling-for-io)
9. [Best Practices](#best-practices)
10. [Real-World Examples](#real-world-examples)

---

## Introduction

Input/Output (I/O) is fundamental to any program. It allows:
- **Input**: Receiving data from users, files, or other sources
- **Output**: Displaying data to users, writing to files, or sending to other processes
- **Processing**: Manipulating data between input and output

### I/O Types
```python
# 1. Console I/O (standard)
print("Output")
user_input = input("Prompt: ")

# 2. File I/O
with open("file.txt", "r") as f:
    content = f.read()

# 3. Network I/O (advanced)
import socket
# Network operations

# 4. Database I/O (advanced)
import sqlite3
# Database operations
```

---

## Output with print()

### Basic print() Function

The `print()` function outputs text to the console (standard output).

#### Syntax
```python
print(*objects, sep=' ', end='\n', file=sys.stdout, flush=False)
```

#### Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `*objects` | Required | Values to print (can be multiple) |
| `sep` | `' '` | Separator between objects |
| `end` | `'\n'` | String appended after all objects |
| `file` | `sys.stdout` | File object to write to |
| `flush` | `False` | Whether to forcibly flush the stream |

### Basic Output

```python
# Single output
print("Hello, World!")

# Multiple outputs (separated by default space)
print("Hello", "World")              # Hello World
print(1, 2, 3)                       # 1 2 3
print("Age:", 25, "Height:", 5.9)   # Age: 25 Height: 5.9

# Multiple lines
print("Line 1")
print("Line 2")
print("Line 3")
```

### Controlling Separators

```python
# Default separator (space)
print("a", "b", "c")                # a b c

# Custom separator
print("a", "b", "c", sep="-")       # a-b-c
print("a", "b", "c", sep="")        # abc
print("a", "b", "c", sep="::")      # a::b::c
print("a", "b", "c", sep="\n")      # a
                                    # b
                                    # c

# Practical example: CSV-like output
print("Name", "Age", "City", sep=",")           # Name,Age,City
print("Alice", 25, "NYC", sep=",")              # Alice,25,NYC
```

### Controlling Line Endings

```python
# Default end (newline)
print("Hello")
print("World")
# Output:
# Hello
# World

# Custom end character
print("Hello", end=" ")
print("World")                       # Hello World

# No newline
print("Loading", end="")
print(".", end="")
print(".", end="")
print(".", end="")
print(" Done!")                      # Loading... Done!

# Tab at end
print("Data:", end="\t")
print("Value")                       # Data:	Value

# Custom string at end
print("Part 1", end=" | ")
print("Part 2", end=" | ")
print("Part 3")                      # Part 1 | Part 2 | Part 3
```

### Printing Multiple Data Types

```python
# Integers
print(42)                            # 42

# Floats
print(3.14159)                       # 3.14159

# Strings
print("Hello")                       # Hello

# Booleans
print(True)                          # True
print(False)                         # False

# Lists
print([1, 2, 3])                     # [1, 2, 3]

# Dictionaries
print({"name": "Alice", "age": 25})  # {'name': 'Alice', 'age': 25}

# None
print(None)                          # None

# Mixed types
print(10, "items", 3.5, "kg")        # 10 items 3.5 kg
```

### Escape Sequences

Escape sequences are special character combinations:

| Escape | Meaning | Example |
|--------|---------|---------|
| `\n` | Newline | `print("Line1\nLine2")` |
| `\t` | Tab | `print("Col1\tCol2")` |
| `\r` | Carriage return | `print("Begin\rEnd")` |
| `\\` | Backslash | `print("C:\\Users\\")` |
| `\'` | Single quote | `print("It\'s")` |
| `\"` | Double quote | `print("He said \"Hi\"")` |
| `\b` | Backspace | `print("abc\bdef")` |

```python
# Examples
print("Line 1\nLine 2")              # Line 1
                                    # Line 2

print("Column1\tColumn2\tColumn3")  # Column1	Column2	Column3

print("Path: C:\\Users\\Documents") # Path: C:\Users\Documents

# Raw strings (ignore escape sequences)
print(r"C:\Users\Documents")         # C:\Users\Documents (backslash literal)
```

---

## Input with input()

### Basic input() Function

The `input()` function reads a line of text from the user (standard input).

#### Syntax
```python
input(prompt='')
```

#### Parameters
- `prompt` (optional): String to display before waiting for input

#### Return Value
- Always returns a **string**, regardless of what the user types

### Basic Input

```python
# Simple input
name = input("What is your name? ")
print(f"Hello, {name}!")

# Input without prompt
data = input()  # Just waits for input

# Multiple inputs
first_name = input("First name: ")
last_name = input("Last name: ")
print(f"Full name: {first_name} {last_name}")
```

### Important: input() Always Returns String

```python
# ✗ Common mistake
age = input("Enter your age: ")  # Returns string!
next_year_age = age + 1          # Error: can't add string + int

# ✓ Correct way
age = int(input("Enter your age: "))
next_year_age = age + 1          # Works!

# ✓ Alternative
age_str = input("Enter your age: ")
age = int(age_str)
next_year_age = age + 1
```

### Input Validation

```python
# Reading integers
while True:
    try:
        age = int(input("Enter your age: "))
        if age < 0 or age > 150:
            print("Please enter a valid age between 0 and 150")
            continue
        break
    except ValueError:
        print("Please enter a valid number")

print(f"Your age is {age}")

# Reading floats
while True:
    try:
        height = float(input("Enter your height (in meters): "))
        if height <= 0:
            print("Height must be positive")
            continue
        break
    except ValueError:
        print("Please enter a valid number")

print(f"Your height is {height}m")
```

### Handling Multiple Inputs

```python
# Method 1: Multiple separate inputs
x = int(input("Enter x: "))
y = int(input("Enter y: "))

# Method 2: Single line, space-separated
x, y = map(int, input("Enter x and y: ").split())
print(f"x={x}, y={y}")

# Method 3: Parse with specific logic
data = input("Enter name and age: ").split(',')
name = data[0].strip()
age = int(data[1].strip())
print(f"{name} is {age} years old")

# Method 4: Using list comprehension
numbers = [int(x) for x in input("Enter numbers separated by space: ").split()]
print(f"Numbers: {numbers}, Sum: {sum(numbers)}")
```

### Input with Default Values

```python
# Manual default handling
response = input("Do you want to continue? (yes/no) [yes]: ").strip() or "yes"
print(f"Response: {response}")

# Function for defaulting
def get_input(prompt, default, required_type=str):
    user_input = input(f"{prompt} [{default}]: ").strip()
    if not user_input:
        return default
    if required_type == int:
        return int(user_input)
    elif required_type == float:
        return float(user_input)
    return user_input

# Usage
name = get_input("Name", "Anonymous")
age = get_input("Age", 0, int)
```

---

## String Formatting Methods

### 1. f-strings (Python 3.6+) - Modern Choice

f-strings are the most modern and readable way to format strings.

#### Basic Syntax
```python
name = "Alice"
age = 25
height = 5.9

# Simple substitution
print(f"Name: {name}")               # Name: Alice

# Multiple variables
print(f"{name} is {age} years old")  # Alice is 25 years old

# Expressions inside {}
print(f"Next year: {age + 1}")       # Next year: 26
print(f"Age squared: {age ** 2}")    # Age squared: 625

# Method calls
text = "hello"
print(f"Uppercase: {text.upper()}")  # Uppercase: HELLO
```

#### Formatting Specifiers

```python
# Basic formatting syntax: {value:format_spec}

# Float precision
price = 19.99
print(f"Price: ${price:.2f}")        # Price: $19.99
print(f"Value: {price:.1f}")         # Value: 20.0

# Large numbers with separators
count = 1000000
print(f"Count: {count:,}")           # Count: 1,000,000
print(f"Count: {count:_}")           # Count: 1_000_000

# Padding and alignment
text = "Python"
print(f"|{text:10}|")                # |Python    | (right-aligned)
print(f"|{text:<10}|")               # |Python    | (left-aligned)
print(f"|{text:^10}|")               # |  Python  | (centered)
print(f"|{text:>10}|")               # |    Python| (right-aligned explicit)

# Padding with specific character
print(f"|{text:*^10}|")              # |**Python**|
print(f"|{text:.>10}|")              # |....Python|

# Width and precision
value = 3.14159
print(f"|{value:10.2f}|")            # |      3.14|

# Binary, hexadecimal, octal
num = 255
print(f"Binary: {num:b}")            # Binary: 11111111
print(f"Hex: {num:x}")               # Hex: ff
print(f"Octal: {num:o}")             # Octal: 377

# Percentage
percentage = 0.856
print(f"Completion: {percentage:.1%}") # Completion: 85.6%
```

#### Alignment Examples

```python
# Left align with padding
data = [("Name", "Alice"), ("Age", 25), ("City", "NYC")]
for key, value in data:
    print(f"{key:<10} : {value}")
# Output:
# Name       : Alice
# Age        : 25
# City       : NYC

# Right align with padding
for key, value in data:
    print(f"{key:>10} : {value}")
# Output:
#       Name : Alice
#        Age : 25
#       City : NYC

# Center with padding
for key, value in data:
    print(f"{key:^10} : {value}")
# Output:
#    Name    : Alice
#    Age     : 25
#    City    : NYC
```

### 2. .format() Method

The `.format()` method is older but still widely used.

```python
# Basic substitution
print("Hello, {}!".format("Alice"))      # Hello, Alice!

# Multiple placeholders
print("{} is {} years old".format("Bob", 30))  # Bob is 30 years old

# Indexed placeholders
print("{0} {1} {0}".format("A", "B"))   # A B A
print("{name} is {age}".format(name="Charlie", age=35))  # Charlie is 35

# Format specifiers
price = 19.99
print("Price: ${:.2f}".format(price))   # Price: $19.99

numbers = [1, 2, 3, 4]
print("Numbers: {}".format(", ".join(map(str, numbers))))  # Numbers: 1, 2, 3, 4

# Alignment
text = "Python"
print("|{:10}|".format(text))           # |Python    |
print("|{:<10}|".format(text))          # |Python    |
print("|{:^10}|".format(text))          # |  Python  |
print("|{:>10}|".format(text))          # |    Python|
```

### 3. % Formatting (Older Style)

Not recommended for new code, but useful to understand for legacy code.

```python
# Basic substitution
name = "Alice"
age = 25
print("Hello, %s!" % name)              # Hello, Alice!

# Multiple values
print("%s is %d years old" % (name, age))  # Alice is 25 years old

# Format specifiers
price = 19.99
print("Price: $%.2f" % price)            # Price: $19.99

# Common format codes
print("String: %s" % "text")            # String: text
print("Integer: %d" % 42)               # Integer: 42
print("Float: %.2f" % 3.14159)          # Float: 3.14
print("Hex: %x" % 255)                  # Hex: ff
```

### 4. String Concatenation

Simple but not recommended for complex formatting.

```python
# Using + operator
name = "Alice"
age = 25
message = "Hello, " + name + "! You are " + str(age) + " years old."
print(message)

# Using join() for multiple strings
words = ["Python", "is", "awesome"]
sentence = " ".join(words)
print(sentence)                         # Python is awesome

# Using * for repetition
print("-" * 20)                         # --------------------
print("Hello " * 3)                     # Hello Hello Hello
```

### Comparison of Formatting Methods

```python
name = "Alice"
age = 25

# f-string (RECOMMENDED)
print(f"{name} is {age} years old")

# .format()
print("{} is {} years old".format(name, age))

# % formatting
print("%s is %d years old" % (name, age))

# String concatenation
print(name + " is " + str(age) + " years old")

# Test performance
import timeit

print("\nPerformance comparison:")
print("f-string:", timeit.timeit(f"'{name} is {age}'", number=1000000))
print(".format():", timeit.timeit("'{} is {}'.format('{}', {})".format(name, age), number=1000000))
```

---

## Standard I/O Streams

### Understanding sys.stdout, sys.stderr, sys.stdin

Python has three standard streams:

```python
import sys

# Standard output (print goes here by default)
print("This is normal output")         # goes to sys.stdout

# Standard error (for error messages)
print("Error occurred!", file=sys.stderr)  # goes to sys.stderr

# Standard input (default for input())
# user_input = sys.stdin.readline()
```

### Writing to Different Streams

```python
import sys

# Print to stdout (default)
print("Normal message")

# Print to stderr
print("Error: Something went wrong", file=sys.stderr)

# Print to a file
with open("output.txt", "w") as f:
    print("Writing to file", file=f)

# Multiple outputs simultaneously
import io
output = io.StringIO()
print("Message 1", file=output)
print("Message 2", file=output)
result = output.getvalue()
print(result)
```

### Capturing and Redirecting Streams

```python
import sys
import io

# Capture stdout
original_stdout = sys.stdout
sys.stdout = io.StringIO()
print("This is captured")
captured = sys.stdout.getvalue()
sys.stdout = original_stdout
print(f"Captured: {captured.strip()}")

# Redirect stderr to stdout
sys.stderr = sys.stdout
print("Error message", file=sys.stderr)
```

---

## File I/O Operations

### Reading Files

```python
# Method 1: Using with statement (recommended)
with open("file.txt", "r") as file:
    content = file.read()  # Read entire file
print(content)

# Method 2: Read line by line
with open("file.txt", "r") as file:
    for line in file:
        print(line.strip())  # strip() removes newline

# Method 3: Read all lines as list
with open("file.txt", "r") as file:
    lines = file.readlines()
    for line in lines:
        print(line.strip())

# Method 4: Read first N characters
with open("file.txt", "r") as file:
    first_100 = file.read(100)
    print(first_100)
```

### Writing to Files

```python
# Method 1: Write mode (overwrites file)
with open("output.txt", "w") as file:
    file.write("Line 1\n")
    file.write("Line 2\n")

# Method 2: Append mode (adds to file)
with open("output.txt", "a") as file:
    file.write("Line 3\n")

# Method 3: Write multiple lines
lines = ["First\n", "Second\n", "Third\n"]
with open("output.txt", "w") as file:
    file.writelines(lines)

# Method 4: Using print to file
with open("output.txt", "w") as file:
    print("Line 1", file=file)
    print("Line 2", file=file)
```

### File Modes

| Mode | Description |
|------|-------------|
| `'r'` | Read (default) - file must exist |
| `'w'` | Write - creates/overwrites file |
| `'a'` | Append - adds to end of file |
| `'r+'` | Read and write |
| `'w+'` | Write and read (overwrites) |
| `'a+'` | Append and read |
| `'b'` | Binary mode (e.g., `'rb'`, `'wb'`) |

```python
# Binary mode examples
with open("image.png", "rb") as file:  # Read binary
    data = file.read()

with open("output.bin", "wb") as file:  # Write binary
    file.write(b"binary data")
```

---

## Advanced Output Formatting

### Formatted Tables

```python
# Method 1: Using format()
print(f"{'Name':<15} {'Age':>5} {'City':>10}")
print("-" * 30)
data = [("Alice", 25, "NYC"), ("Bob", 30, "LA"), ("Charlie", 28, "Chicago")]
for name, age, city in data:
    print(f"{name:<15} {age:>5} {city:>10}")

# Output:
# Name               Age       City
# ==============================
# Alice               25        NYC
# Bob                 30         LA
# Charlie             28    Chicago

# Method 2: Using tabulate library (for complex tables)
# pip install tabulate
from tabulate import tabulate

headers = ["Name", "Age", "City"]
rows = [("Alice", 25, "NYC"), ("Bob", 30, "LA")]
print(tabulate(rows, headers=headers))
```

### Colored Output

```python
# Using ANSI escape codes
class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    BLUE = '\033[94m'
    END = '\033[0m'

print(f"{Colors.RED}Error!{Colors.END}")
print(f"{Colors.GREEN}Success!{Colors.END}")

# Using colorama library (cross-platform)
# pip install colorama
from colorama import Fore, Back, Style, init

init()  # Initialize colorama
print(f"{Fore.RED}Red text{Style.RESET_ALL}")
print(f"{Back.GREEN}Green background{Style.RESET_ALL}")
```

### Progress Indicators

```python
import time

# Method 1: Simple progress bar
for i in range(1, 11):
    print(f"Progress: {i * 10}%", end="\r")
    time.sleep(0.5)
print("\nDone!")

# Method 2: Using tqdm library
# pip install tqdm
from tqdm import tqdm
import time

for i in tqdm(range(100)):
    time.sleep(0.01)
```

---

## Error Handling for I/O

### Common I/O Exceptions

```python
# FileNotFoundError
try:
    with open("nonexistent.txt", "r") as file:
        content = file.read()
except FileNotFoundError:
    print("File not found!")

# ValueError (invalid conversion)
try:
    age = int(input("Enter age: "))
except ValueError:
    print("Please enter a valid number")

# IOError (general I/O problems)
try:
    with open("file.txt", "r") as file:
        content = file.read()
except IOError as e:
    print(f"I/O Error: {e}")

# PermissionError
try:
    with open("/root/restricted.txt", "r") as file:
        content = file.read()
except PermissionError:
    print("Permission denied!")
```

### Comprehensive Error Handling

```python
def read_file_safe(filename):
    """Safely read a file with comprehensive error handling"""
    try:
        with open(filename, "r") as file:
            content = file.read()
        return content
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        return None
    except PermissionError:
        print(f"Error: Permission denied to read '{filename}'")
        return None
    except IOError as e:
        print(f"Error reading file: {e}")
        return None
    except Exception as e:
        print(f"Unexpected error: {e}")
        return None
    finally:
        print("File reading attempt completed")

# Usage
content = read_file_safe("data.txt")
```

### Input Validation with Error Handling

```python
def get_integer_input(prompt, min_val=None, max_val=None):
    """Get validated integer input from user"""
    while True:
        try:
            value = int(input(prompt))
            
            if min_val is not None and value < min_val:
                print(f"Value must be at least {min_val}")
                continue
            
            if max_val is not None and value > max_val:
                print(f"Value must be at most {max_val}")
                continue
            
            return value
        
        except ValueError:
            print("Please enter a valid integer")

# Usage
age = get_integer_input("Enter your age: ", min_val=0, max_val=150)
```

---

## Best Practices

### 1. Always Use Context Managers for Files

```python
# ✓ Correct - automatically closes file
with open("file.txt", "r") as f:
    content = f.read()

# ✗ Risky - file might not close if error occurs
f = open("file.txt", "r")
content = f.read()
f.close()
```

### 2. Use f-strings for String Formatting

```python
# ✓ Modern and readable
message = f"Hello, {name}! You are {age} years old"

# ✗ Older style
message = "Hello, {}! You are {} years old".format(name, age)
message = "Hello, %s! You are %d years old" % (name, age)
```

### 3. Validate User Input

```python
# ✓ Validate and handle errors
try:
    age = int(input("Enter age: "))
    assert age >= 0 and age <= 150
except (ValueError, AssertionError):
    print("Invalid age")

# ✗ Assume input is correct
age = int(input("Enter age: "))
```

### 4. Use Meaningful Error Messages

```python
# ✓ Clear message
print(f"Error: Cannot process file '{filename}' - file size exceeds 10MB")

# ✗ Vague message
print("Error")
```

### 5. Handle Exceptions Specifically

```python
# ✓ Handle specific exceptions
try:
    value = int(user_input)
except ValueError:
    print("Enter a valid number")
except TypeError:
    print("Invalid type")

# ✗ Catch all exceptions
try:
    value = int(user_input)
except:
    print("Error")
```

### 6. Use Appropriate Output Streams

```python
import sys

# ✓ Use stderr for errors
print("Error processing file", file=sys.stderr)

# Use stdout for normal output
print("Processing successful")

# ✗ Mix error and normal output
print("Error or success?")
```

---

## Real-World Examples

### Example 1: Interactive Calculator

```python
def interactive_calculator():
    """Interactive calculator with error handling"""
    print("=== Interactive Calculator ===")
    print("Type 'quit' to exit\n")
    
    while True:
        try:
            expression = input("Enter expression: ").strip()
            
            if expression.lower() == 'quit':
                print("Goodbye!")
                break
            
            result = eval(expression)  # ⚠️ Be careful with eval in production!
            print(f"Result: {result}\n")
        
        except ZeroDivisionError:
            print("Error: Cannot divide by zero\n")
        except SyntaxError:
            print("Error: Invalid expression\n")
        except Exception as e:
            print(f"Error: {e}\n")

interactive_calculator()
```

### Example 2: Data Logger

```python
import sys
from datetime import datetime

class DataLogger:
    def __init__(self, filename):
        self.filename = filename
        self.file = None
    
    def __enter__(self):
        self.file = open(self.filename, "a")
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        if self.file:
            self.file.close()
    
    def log(self, level, message):
        """Log message with timestamp"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_message = f"[{timestamp}] {level}: {message}"
        
        # Print to console
        print(log_message)
        
        # Write to file
        if self.file:
            self.file.write(log_message + "\n")
            self.file.flush()

# Usage
with DataLogger("app.log") as logger:
    logger.log("INFO", "Application started")
    logger.log("WARNING", "High memory usage detected")
    logger.log("ERROR", "Failed to connect to database")
```

### Example 3: CSV Data Processing

```python
def read_csv_interactive():
    """Read and display CSV file with formatting"""
    filename = input("Enter CSV filename: ")
    
    try:
        with open(filename, "r") as f:
            # Read header
            header = f.readline().strip().split(",")
            print(f"\n{'Columns:'} {', '.join(header)}\n")
            print("-" * 50)
            
            # Read and display rows
            for i, line in enumerate(f, 1):
                values = line.strip().split(",")
                print(f"{i:3} | " + " | ".join(f"{v:10}" for v in values))
    
    except FileNotFoundError:
        print(f"File '{filename}' not found")
    except Exception as e:
        print(f"Error processing file: {e}")

read_csv_interactive()
```

### Example 4: Survey Questionnaire

```python
def survey():
    """Interactive survey with input validation"""
    responses = {}
    
    # Question 1: Name
    responses['name'] = input("What is your name? ").strip()
    
    # Question 2: Age (validated)
    while True:
        try:
            responses['age'] = int(input("What is your age? "))
            if 0 <= responses['age'] <= 150:
                break
            print("Please enter a valid age")
        except ValueError:
            print("Please enter a valid number")
    
    # Question 3: Multiple choice
    print("\nHow satisfied are you? (1-5)")
    while True:
        try:
            responses['satisfaction'] = int(input("Rate (1-5): "))
            if 1 <= responses['satisfaction'] <= 5:
                break
            print("Please enter a number between 1 and 5")
        except ValueError:
            print("Please enter a valid number")
    
    # Question 4: Yes/No
    while True:
        responses['recommend'] = input("Would you recommend us? (yes/no): ").lower()
        if responses['recommend'] in ['yes', 'no']:
            break
        print("Please enter 'yes' or 'no'")
    
    # Display summary
    print("\n" + "="*40)
    print("SURVEY SUMMARY")
    print("="*40)
    for key, value in responses.items():
        print(f"{key.upper():<15}: {value}")
    print("="*40)
    print("Thank you for completing the survey!")

survey()
```

---

## Summary

**Key Takeaways:**

✅ Use `print()` for output with control over format  
✅ Use `input()` for user input (always returns string)  
✅ Use **f-strings** for modern string formatting  
✅ Always **validate** user input with error handling  
✅ Use **context managers** (`with` statement) for file I/O  
✅ Write to **stderr** for error messages  
✅ Provide **clear error messages**  
✅ Use **specific exception handling**  
✅ Format output for **readability** and **usability**  
✅ Test edge cases and error scenarios  

**Quick Reference:**
```python
# Output
print("text", end="", sep="", file=sys.stdout)

# Input
user_input = input("Prompt: ")

# String Formatting (modern)
f"Value: {variable:format_spec}"

# File I/O
with open("file.txt", "r") as f:
    content = f.read()
```
