# Conditional Statements in Python

## Introduction

Conditional statements let a program make decisions. They help Python choose which block of code to run based on whether a condition is `True` or `False`.

Conditional logic is one of the most important fundamentals for any developer because it is used in:
- Input validation
- Authentication and authorization
- Business rules
- Error handling
- Data filtering
- Application flow control

---

## Why Conditional Statements Matter

Without conditions, a program would execute every line in the same order every time. With conditions, your program can respond differently depending on values, user input, or system state.

```python
age = 20

if age >= 18:
	print("You are eligible to vote")
```

In the example above, the message is printed only when the condition is true.

---

## The `if` Statement

The `if` statement is used to run code only when a condition is true.

### Syntax

```python
if condition:
	# code block
```

### Example

```python
temperature = 35

if temperature > 30:
	print("It is a hot day")
```

### Important Notes

- The condition must evaluate to `True` or `False`
- A colon `:` is required after the condition
- Indentation is required in Python to define the block

---

## The `if...else` Statement

Use `else` when you want one block to run if the condition is true and another block if it is false.

### Syntax

```python
if condition:
	# code if condition is true
else:
	# code if condition is false
```

### Example

```python
number = 7

if number % 2 == 0:
	print("Even number")
else:
	print("Odd number")
```

---

## The `if...elif...else` Statement

Use `elif` when you have multiple conditions to check.

### Syntax

```python
if condition1:
	# block 1
elif condition2:
	# block 2
elif condition3:
	# block 3
else:
	# default block
```

### Example

```python
score = 82

if score >= 90:
	print("Grade A")
elif score >= 80:
	print("Grade B")
elif score >= 70:
	print("Grade C")
else:
	print("Need improvement")
```

### Key Rule

Python checks conditions from top to bottom and stops at the first matching condition.

---

## Nested Conditional Statements

You can place one conditional statement inside another.

### Example

```python
age = 22
has_id = True

if age >= 18:
	if has_id:
		print("Entry allowed")
	else:
		print("ID is required")
else:
	print("Underage")
```

### When to Use Nested Conditions

- Multi-step validation
- Permission checks
- Dependent business rules

Try not to nest too deeply, because deeply nested logic becomes harder to read and maintain.

---

## Comparison Operators in Conditions

Conditional statements often use comparison operators.

| Operator | Meaning | Example |
|----------|---------|---------|
| `==` | Equal to | `x == 10` |
| `!=` | Not equal to | `x != 10` |
| `>` | Greater than | `x > 10` |
| `<` | Less than | `x < 10` |
| `>=` | Greater than or equal to | `x >= 10` |
| `<=` | Less than or equal to | `x <= 10` |

### Example

```python
salary = 50000

if salary >= 40000:
	print("Eligible for loan review")
```

---

## Logical Operators in Conditions

Logical operators combine multiple conditions.

| Operator | Meaning |
|----------|---------|
| `and` | Both conditions must be true |
| `or` | At least one condition must be true |
| `not` | Reverses the condition |

### Example with `and`

```python
age = 25
citizen = True

if age >= 18 and citizen:
	print("Eligible to vote")
```

### Example with `or`

```python
is_weekend = False
is_holiday = True

if is_weekend or is_holiday:
	print("Office closed")
```

### Example with `not`

```python
is_logged_in = False

if not is_logged_in:
	print("Please log in")
```

---

## Truthy and Falsy Values

In Python, not every condition has to be written as a direct comparison. Some values are treated as `False`, and others are treated as `True`.

### Falsy Values

- `False`
- `0`
- `0.0`
- `""`
- `[]`
- `{}`
- `set()`
- `None`

Everything else is generally truthy.

### Example

```python
items = []

if items:
	print("List has data")
else:
	print("List is empty")
```

---

## Ternary Conditional Expression

Python provides a short form for simple `if...else` logic.

### Syntax

```python
value_if_true if condition else value_if_false
```

### Example

```python
age = 17
status = "Adult" if age >= 18 else "Minor"
print(status)
```

Use this only for short and simple conditions. For more complex logic, regular `if...else` is clearer.

---

## Common Developer Use Cases

### 1. Input Validation

```python
username = "admin"

if username:
	print("Username accepted")
else:
	print("Username cannot be empty")
```

### 2. Login Check

```python
is_authenticated = True
is_admin = False

if is_authenticated and is_admin:
	print("Admin dashboard")
elif is_authenticated:
	print("User dashboard")
else:
	print("Access denied")
```

### 3. Discount Logic

```python
purchase_amount = 1200

if purchase_amount >= 1000:
	print("10% discount applied")
else:
	print("No discount")
```

### 4. Error Handling Logic

```python
file_found = False

if not file_found:
	print("File does not exist")
```

---

## Common Mistakes to Avoid

### 1. Using `=` instead of `==`

```python
# Wrong
# if age = 18:

# Correct
if age == 18:
	print("Age is 18")
```

### 2. Wrong Indentation

```python
# Correct indentation
if True:
	print("This is inside the if block")
```

### 3. Poor Ordering of Conditions

```python
score = 95

if score >= 90:
	print("A")
elif score >= 80:
	print("B")
```

If you reverse the order carelessly, higher conditions may never be reached.

### 4. Overusing Nested Conditions

Too many nested levels reduce readability. In real projects, try to simplify logic with helper functions.

---

## Best Practices

- Keep conditions readable and explicit
- Use parentheses for clarity when combining complex conditions
- Prefer `if value is None` instead of `if value == None`
- Avoid deeply nested blocks when possible
- Use meaningful variable names in conditions
- Extract repeated logic into functions

### Example

```python
user_age = 25
has_membership = True

if user_age >= 18 and has_membership:
	print("Access granted")
```

---

## Practical Examples

### Example 1: Even or Odd

```python
number = 10

if number % 2 == 0:
	print("Even")
else:
	print("Odd")
```

### Example 2: Grade Calculator

```python
marks = 76

if marks >= 90:
	print("A")
elif marks >= 80:
	print("B")
elif marks >= 70:
	print("C")
elif marks >= 60:
	print("D")
else:
	print("F")
```

### Example 3: Maximum of Two Numbers

```python
a = 15
b = 20

if a > b:
	print("a is greater")
else:
	print("b is greater")
```

### Example 4: Eligibility Check

```python
age = 21
has_ticket = True

if age >= 18 and has_ticket:
	print("You can enter")
else:
	print("Entry denied")
```

### Example 5: Positive, Negative, or Zero

```python
num = -4

if num > 0:
	print("Positive")
elif num < 0:
	print("Negative")
else:
	print("Zero")
```

---

## Summary

Conditional statements are used to make decisions in Python.

### Main Keywords

- `if`
- `elif`
- `else`

### Important Points

- Conditions return `True` or `False`
- Python uses indentation to define code blocks
- Logical operators help combine multiple checks
- `elif` is useful for multiple branches
- Ternary expressions are useful for short conditions

### Quick Example

```python
age = 19

if age >= 18:
	print("Adult")
else:
	print("Minor")
```

This is the core idea of conditional programming in Python: the program decides what to do based on conditions.
