"""
Input and Output (I/O) - Practical Examples
All examples from input-and-output.md in executable form
"""

import sys
import io

# ============================================================================
# 1. BASIC PRINT OUTPUT
# ============================================================================
print("\n=== Basic Print Output ===")

print("Hello, World!")

x = 10
y = 20
print(x, y)  # Output: 10 20
print("x =", x, "and y =", y)  # Output: x = 10 and y = 20


# ============================================================================
# 2. PRINT WITH SEPARATORS
# ============================================================================
print("\n=== Print Separators ===")

print("a", "b", "c")                # Default separator (space)
print("a", "b", "c", sep="-")       # Custom separator
print("a", "b", "c", sep="")        # No separator
print("a", "b", "c", sep="::")      # Double colon separator

# CSV-like output
print("Name", "Age", "City", sep=",")
print("Alice", 25, "NYC", sep=",")


# ============================================================================
# 3. PRINT WITH LINE ENDINGS
# ============================================================================
print("\n=== Print Line Endings ===")

print("Hello", end=" ")
print("World")                       # Hello World

# Loading animation effect
print("Loading", end="")
print(".", end="")
print(".", end="")
print(".", end="")
print(" Done!")                      # Loading... Done!


# ============================================================================
# 4. ESCAPE SEQUENCES
# ============================================================================
print("\n=== Escape Sequences ===")

print("Line 1\nLine 2")              # Newline
print("Column1\tColumn2\tColumn3")  # Tab
print("Path: C:\\Users\\Documents") # Backslash

# Raw strings
print(r"C:\Users\Documents")         # Raw string (literal backslash)


# ============================================================================
# 5. PRINTING DIFFERENT DATA TYPES
# ============================================================================
print("\n=== Printing Different Types ===")

print("Integer:", 42)
print("Float:", 3.14159)
print("String:", "Hello")
print("Boolean:", True)
print("List:", [1, 2, 3])
print("Dictionary:", {"name": "Alice", "age": 25})
print("None:", None)


# ============================================================================
# 6. STRING FORMATTING - F-STRINGS (MODERN)
# ============================================================================
print("\n=== F-String Formatting ===")

name = "Bob"
age = 30
print(f"My name is {name} and I am {age} years old")

# Expressions in f-strings
x = 5
print(f"Next year: {age + 1}")
print(f"Age squared: {age ** 2}")

# Method calls
text = "hello"
print(f"Uppercase: {text.upper()}")

# Float precision
price = 19.99
print(f"Price: ${price:.2f}")

# Large numbers with separators
count = 1000000
print(f"Count: {count:,}")

# Padding and alignment
text = "Python"
print(f"|{text:10}|")                # |Python    |
print(f"|{text:<10}|")               # |Python    |
print(f"|{text:^10}|")               # |  Python  |
print(f"|{text:>10}|")               # |    Python|

# Padding with character
print(f"|{text:*^10}|")              # |**Python**|

# Binary, hex, octal
num = 255
print(f"Binary: {num:b}")            # Binary: 11111111
print(f"Hex: {num:x}")               # Hex: ff
print(f"Octal: {num:o}")             # Octal: 377


# ============================================================================
# 7. STRING FORMATTING - .format() METHOD
# ============================================================================
print("\n=== .format() Formatting ===")

print("Hello, {}!".format("Alice"))
print("{} is {} years old".format("Bob", 30))

# Indexed placeholders
print("{0} {1} {0}".format("A", "B"))  # A B A

# Named placeholders
print("{name} is {age}".format(name="Charlie", age=35))

# Format specifiers
price = 19.99
print("Price: ${:.2f}".format(price))


# ============================================================================
# 8. STRING FORMATTING - % FORMATTING (OLDER STYLE)
# ============================================================================
print("\n=== % Formatting ===")

name = "Alice"
age = 25
print("Hello, %s!" % name)
print("%s is %d years old" % (name, age))
print("Price: $%.2f" % price)


# ============================================================================
# 9. STRING CONCATENATION
# ============================================================================
print("\n=== String Concatenation ===")

words = ["Python", "is", "awesome"]
sentence = " ".join(words)
print(sentence)

# Repetition
print("-" * 20)
print("Hello " * 3)


# ============================================================================
# 10. FORMATTED TABLE OUTPUT
# ============================================================================
print("\n=== Formatted Table Output ===")

headers = ["Name", "Age", "City"]
print(f"{'Name':<15} {'Age':>5} {'City':>10}")
print("-" * 30)

data = [("Alice", 25, "NYC"), ("Bob", 30, "LA"), ("Charlie", 28, "Chicago")]
for name, age, city in data:
    print(f"{name:<15} {age:>5} {city:>10}")


# ============================================================================
# 11. INPUT BASICS
# ============================================================================
print("\n=== User Input (Simulated) ===")

# Simulating input with predefined values
# In real usage: name = input("What is your name? ")
name = "Alice"
print(f"Hello, {name}!")

# Multiple inputs
first_name = "John"
last_name = "Doe"
print(f"Full name: {first_name} {last_name}")


# ============================================================================
# 12. INPUT VALIDATION - INTEGER
# ============================================================================
print("\n=== Input Validation Example ===")

def get_valid_age(age_str):
    """Validate age input"""
    try:
        age = int(age_str)
        if age < 0 or age > 150:
            print("Please enter a valid age between 0 and 150")
            return None
        return age
    except ValueError:
        print("Please enter a valid number")
        return None

# Test with valid input
age = get_valid_age("25")
if age:
    print(f"Your age is {age}")

# Test with invalid input
age = get_valid_age("abc")


# ============================================================================
# 13. PARSING MULTIPLE INPUTS
# ============================================================================
print("\n=== Parsing Multiple Inputs ===")

# Simulating: x, y = map(int, input("Enter x and y: ").split())
input_str = "10 20"
x, y = map(int, input_str.split())
print(f"x={x}, y={y}")

# Using list comprehension
numbers_str = "1 2 3 4 5"
numbers = [int(x) for x in numbers_str.split()]
print(f"Numbers: {numbers}, Sum: {sum(numbers)}")


# ============================================================================
# 14. WRITING TO DIFFERENT STREAMS
# ============================================================================
print("\n=== Standard I/O Streams ===")

# Print to stdout (default)
print("Normal message")

# Print to stderr
print("Error occurred!", file=sys.stderr)

# Capture output
output = io.StringIO()
print("Message 1", file=output)
print("Message 2", file=output)
result = output.getvalue()
print(f"Captured output:\n{result}")


# ============================================================================
# 15. FILE I/O - READING FILES
# ============================================================================
print("\n=== File I/O - Reading ===")

# Example: Reading a file (would need actual file)
# with open("file.txt", "r") as file:
#     content = file.read()
# with open("file.txt", "r") as file:
#     for line in file:
#         print(line.strip())

# For demonstration, create a test file
test_content = "Line 1\nLine 2\nLine 3"
with open("/tmp/test.txt", "w") as f:
    f.write(test_content)

# Read entire file
with open("/tmp/test.txt", "r") as f:
    content = f.read()
print(f"File content:\n{content}")

# Read line by line
print("\nReading line by line:")
with open("/tmp/test.txt", "r") as f:
    for line in f:
        print(f"  {line.strip()}")


# ============================================================================
# 16. FILE I/O - WRITING FILES
# ============================================================================
print("\n=== File I/O - Writing ===")

# Write mode (overwrites)
with open("/tmp/output.txt", "w") as f:
    f.write("Line 1\n")
    f.write("Line 2\n")

# Append mode
with open("/tmp/output.txt", "a") as f:
    f.write("Line 3\n")

# Using print to file
with open("/tmp/output2.txt", "w") as f:
    print("Using print", file=f)
    print("to write", file=f)
    print("to file", file=f)

# Read and display
with open("/tmp/output.txt", "r") as f:
    print(f"Output file content:\n{f.read()}")


# ============================================================================
# 17. ERROR HANDLING FOR I/O
# ============================================================================
print("\n=== Error Handling for I/O ===")

def read_file_safe(filename):
    """Safely read a file"""
    try:
        with open(filename, "r") as file:
            content = file.read()
        return content
    except FileNotFoundError:
        print(f"Error: File '{filename}' not found")
        return None
    except IOError as e:
        print(f"Error reading file: {e}")
        return None

# Test with non-existent file
content = read_file_safe("/nonexistent/file.txt")


# ============================================================================
# 18. INTERACTIVE CALCULATOR EXAMPLE
# ============================================================================
print("\n=== Interactive Calculator Example ===")

def simple_calculator(num1, operation, num2):
    """Perform simple calculation"""
    try:
        if operation == "+":
            return num1 + num2
        elif operation == "-":
            return num1 - num2
        elif operation == "*":
            return num1 * num2
        elif operation == "/":
            if num2 != 0:
                return num1 / num2
            else:
                print("Error: Division by zero!")
                return None
        else:
            print("Invalid operation!")
            return None
    except Exception as e:
        print(f"Error: {e}")
        return None

# Simulated input
result = simple_calculator(15, "+", 5)
print(f"15 + 5 = {result}")

result = simple_calculator(20, "/", 4)
print(f"20 / 4 = {result}")


# ============================================================================
# 19. DATA LOGGER EXAMPLE
# ============================================================================
print("\n=== Data Logger Example ===")

from datetime import datetime

class SimpleLogger:
    def __init__(self, filename):
        self.filename = filename
    
    def log(self, level, message):
        """Log message with timestamp"""
        timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_message = f"[{timestamp}] {level}: {message}"
        print(log_message)
        
        # Write to file
        with open(self.filename, "a") as f:
            f.write(log_message + "\n")

# Usage
logger = SimpleLogger("/tmp/app.log")
logger.log("INFO", "Application started")
logger.log("WARNING", "High memory usage detected")
logger.log("ERROR", "Failed to connect to database")

# Display log file
print("\nLog file content:")
with open("/tmp/app.log", "r") as f:
    print(f.read())


# ============================================================================
# 20. SURVEY QUESTIONNAIRE EXAMPLE
# ============================================================================
print("\n=== Survey Example ===")

def simple_survey():
    """Simple survey with simulated input"""
    responses = {}
    
    # Simulated responses
    responses['name'] = "Alice"
    responses['age'] = 30
    responses['satisfaction'] = 4
    responses['recommend'] = "yes"
    
    # Display summary
    print("\n" + "="*40)
    print("SURVEY SUMMARY")
    print("="*40)
    for key, value in responses.items():
        print(f"{key.upper():<15}: {value}")
    print("="*40)
    print("Thank you for completing the survey!")

simple_survey()


# ============================================================================
# 21. PRACTICAL FORMATTING EXAMPLES
# ============================================================================
print("\n=== Practical Formatting Examples ===")

# Receipt format
items = [("Apple", 1, 1.50), ("Banana", 2, 0.75), ("Orange", 3, 1.25)]
total = sum(qty * price for _, qty, price in items)

print("\n" + "="*40)
print("RECEIPT")
print("="*40)
print(f"{'Item':<15} {'Qty':>5} {'Price':>8} {'Total':>8}")
print("-"*40)
for item, qty, price in items:
    item_total = qty * price
    print(f"{item:<15} {qty:>5} ${price:>7.2f} ${item_total:>7.2f}")
print("-"*40)
print(f"{'TOTAL':<15} {' ':>5} {' ':>8} ${total:>7.2f}")
print("="*40)

# Report with alignment
print("\n" + "="*50)
print("PERFORMANCE REPORT")
print("="*50)
employees = [
    ("Alice Johnson", 1250, 95),
    ("Bob Smith", 1100, 87),
    ("Charlie Brown", 1300, 92),
]
print(f"{'Name':<20} {'Salary':>10} {'Score':>10}")
print("-"*50)
for name, salary, score in employees:
    print(f"{name:<20} ${salary:>9} {score:>10}%")
print("="*50)

print("\n=== End of Input and Output Examples ===")
