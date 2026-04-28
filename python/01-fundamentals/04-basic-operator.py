"""
Basic Operators - Practical Examples
All examples from 04-basic-operator.md in executable form
"""

# ============================================================================
# 1. ARITHMETIC OPERATORS
# ============================================================================
print("\n=== ARITHMETIC OPERATORS ===")

a = 10
b = 3

print(f"{a} + {b} = {a + b}")           # 13
print(f"{a} - {b} = {a - b}")           # 7
print(f"{a} * {b} = {a * b}")           # 30
print(f"{a} / {b} = {a / b}")           # 3.333...
print(f"{a} // {b} = {a // b}")         # 3
print(f"{a} % {b} = {a % b}")           # 1
print(f"{a} ** {b} = {a ** b}")         # 1000

# String operations
print(f"\nString Addition: {'Hello' + ' ' + 'World'}")
print(f"String Repetition: {'Hi' * 3}")

# List operations
list1 = [1, 2]
list2 = [3, 4]
print(f"List Addition: {list1 + list2}")


# ============================================================================
# 2. INTEGER BASE CONVERSIONS
# ============================================================================
print("\n=== INTEGER BASES ===")

decimal = 255
binary = 0b11111111
octal = 0o377
hexadecimal = 0xFF

print(f"Decimal: {decimal}")
print(f"Binary: {binary}")
print(f"Octal: {octal}")
print(f"Hexadecimal: {hexadecimal}")
print(f"All equal: {decimal == binary == octal == hexadecimal}")

# Underscore for readability
million = 1_000_000
print(f"Million: {million}")


# ============================================================================
# 3. FLOOR DIVISION AND MODULUS
# ============================================================================
print("\n=== FLOOR DIVISION AND MODULUS ===")

print(f"10 // 3 = {10 // 3}")          # 3
print(f"-10 // 3 = {-10 // 3}")        # -4 (rounds down)

print(f"10 % 3 = {10 % 3}")            # 1
print(f"-10 % 3 = {-10 % 3}")          # 2

# Checking even/odd
print(f"7 is odd: {7 % 2 == 1}")
print(f"8 is even: {8 % 2 == 0}")

# Cycling through values
day_of_week = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
day_number = 10
print(f"Day {day_number} is {day_of_week[day_number % 7]}")


# ============================================================================
# 4. EXPONENTIATION
# ============================================================================
print("\n=== EXPONENTIATION ===")

print(f"2 ** 3 = {2 ** 3}")             # 8
print(f"5 ** 2 = {5 ** 2}")             # 25
print(f"2 ** -1 = {2 ** -1}")           # 0.5
print(f"9 ** 0.5 = {9 ** 0.5}")        # 3.0 (square root)
print(f"8 ** (1/3) = {8 ** (1/3)}")    # 2.0 (cube root)


# ============================================================================
# 5. COMPARISON OPERATORS
# ============================================================================
print("\n=== COMPARISON OPERATORS ===")

x = 5
y = 10

print(f"{x} == {y}: {x == y}")          # False
print(f"{x} != {y}: {x != y}")          # True
print(f"{x} > {y}: {x > y}")            # False
print(f"{x} < {y}: {x < y}")            # True
print(f"{x} >= {y}: {x >= y}")          # False
print(f"{x} <= {y}: {x <= y}")          # True

# String comparison
print(f"\n'apple' < 'banana': {'apple' < 'banana'}")
print(f"'Apple' < 'apple': {'Apple' < 'apple'}")

# Comparison chains
print(f"\n0 < 5 < 10: {0 < 5 < 10}")    # True
print(f"1 < 2 > 0: {1 < 2 > 0}")       # True


# ============================================================================
# 6. LOGICAL OPERATORS
# ============================================================================
print("\n=== LOGICAL OPERATORS ===")

print(f"True and True: {True and True}")    # True
print(f"True and False: {True and False}")  # False
print(f"False and False: {False and False}")  # False

print(f"\nTrue or True: {True or True}")     # True
print(f"True or False: {True or False}")    # True
print(f"False or False: {False or False}")  # False

print(f"\nnot True: {not True}")             # False
print(f"not False: {not False}")            # True

# Logical operators with expressions
age = 25
has_license = True
can_drive = age >= 18 and has_license
print(f"\nCan drive: {can_drive}")

# Short-circuit evaluation
print(f"\nFalse and 1/0: {False and 'skipped'}")  # 'skipped' (1/0 never evaluated)


# ============================================================================
# 7. LOGICAL OPERATORS WITH TRUTHY/FALSY
# ============================================================================
print("\n=== LOGICAL OPERATORS WITH TRUTHY/FALSY ===")

print(f"5 and 10: {5 and 10}")          # 10
print(f"0 and 10: {0 and 10}")          # 0
print(f"5 and 0: {5 and 0}")            # 0
print(f"'Hello' and 'World': {'Hello' and 'World'}")  # 'World'

print(f"\n5 or 10: {5 or 10}")           # 5
print(f"0 or 10: {0 or 10}")            # 10
print(f"0 or 0: {0 or 0}")              # 0
print(f"'' or 'Hello': {'' or 'Hello'}")  # 'Hello'

# Default values
username = None
name = username or "Anonymous"
print(f"\nDefault username: {name}")


# ============================================================================
# 8. BITWISE OPERATORS
# ============================================================================
print("\n=== BITWISE OPERATORS ===")

# AND
print(f"5 & 3 = {5 & 3}")              # 1 (101 & 011 = 001)
print(f"12 & 10 = {12 & 10}")          # 8

# OR
print(f"5 | 3 = {5 | 3}")              # 7 (101 | 011 = 111)
print(f"12 | 10 = {12 | 10}")          # 14

# XOR
print(f"5 ^ 3 = {5 ^ 3}")              # 6 (101 ^ 011 = 110)
print(f"12 ^ 10 = {12 ^ 10}")          # 6

# NOT
print(f"~5 = {~5}")                    # -6
print(f"~0 = {~0}")                    # -1

# Left shift
print(f"5 << 1 = {5 << 1}")            # 10 (5 * 2)
print(f"5 << 2 = {5 << 2}")            # 20 (5 * 4)

# Right shift
print(f"20 >> 1 = {20 >> 1}")          # 10 (20 / 2)
print(f"20 >> 2 = {20 >> 2}")          # 5 (20 / 4)


# ============================================================================
# 9. ASSIGNMENT OPERATORS
# ============================================================================
print("\n=== ASSIGNMENT OPERATORS ===")

x = 10
print(f"x = {x}")

x += 5
print(f"After x += 5: {x}")

x -= 3
print(f"After x -= 3: {x}")

x *= 2
print(f"After x *= 2: {x}")

x /= 3
print(f"After x /= 3: {x}")

x = 10
x //= 3
print(f"x //= 3: {x}")

x = 10
x %= 3
print(f"x %= 3: {x}")

x = 2
x **= 3
print(f"x **= 3: {x}")


# ============================================================================
# 10. MEMBERSHIP OPERATORS
# ============================================================================
print("\n=== MEMBERSHIP OPERATORS ===")

print(f"3 in [1, 2, 3, 4]: {3 in [1, 2, 3, 4]}")
print(f"5 in [1, 2, 3, 4]: {5 in [1, 2, 3, 4]}")

print(f"'o' in 'Hello': {'o' in 'Hello'}")
print(f"'x' in 'Hello': {'x' in 'Hello'}")

print(f"2 in (1, 2, 3): {2 in (1, 2, 3)}")

print(f"'name' in {{'name': 'Alice'}}: {'name' in {'name': 'Alice'}}")
print(f"'Alice' in {{'name': 'Alice'}}.values(): {'Alice' in {'name': 'Alice'}.values()}")

# Using not in
print(f"\n5 not in [1, 2, 3]: {5 not in [1, 2, 3]}")
print(f"'x' not in 'Hello': {'x' not in 'Hello'}")


# ============================================================================
# 11. IDENTITY OPERATORS
# ============================================================================
print("\n=== IDENTITY OPERATORS ===")

x = None
print(f"None is None: {x is None}")

# Integer identity
a = 5
b = 5
print(f"5 is 5: {a is b}")              # True (small integers cached)

# List identity
list1 = [1, 2, 3]
list2 = [1, 2, 3]
list3 = list1

print(f"list1 == list2: {list1 == list2}")    # True (same content)
print(f"list1 is list2: {list1 is list2}")    # False (different objects)
print(f"list1 is list3: {list1 is list3}")    # True (same object)


# ============================================================================
# 12. OPERATOR PRECEDENCE
# ============================================================================
print("\n=== OPERATOR PRECEDENCE ===")

print(f"2 + 3 * 4 = {2 + 3 * 4}")              # 14 (not 20)
print(f"(2 + 3) * 4 = {(2 + 3) * 4}")          # 20

print(f"2 * 3 ** 2 = {2 * 3 ** 2}")            # 18
print(f"(2 * 3) ** 2 = {(2 * 3) ** 2}")        # 36

print(f"True or False and False = {True or False and False}")  # True
print(f"(True or False) and False = {(True or False) and False}")  # False

result = 2 + 3 * 4 ** 2 / 5 - 1
print(f"\n2 + 3 * 4 ** 2 / 5 - 1 = {result}")  # 10.6


# ============================================================================
# 13. CHAINED ASSIGNMENT
# ============================================================================
print("\n=== CHAINED ASSIGNMENT ===")

x = y = z = 10
print(f"x = y = z = 10")
print(f"x: {x}, y: {y}, z: {z}")

# Tuple unpacking
a, b, c = 1, 2, 3
print(f"\na, b, c = 1, 2, 3")
print(f"a: {a}, b: {b}, c: {c}")

# Swap variables
x, y = 5, 10
x, y = y, x
print(f"\nAfter swap: x: {x}, y: {y}")


# ============================================================================
# 14. PRACTICAL EXAMPLE 1: TEMPERATURE CONVERTER
# ============================================================================
print("\n=== Example 1: Temperature Converter ===")

def celsius_to_fahrenheit(celsius):
    """Convert Celsius to Fahrenheit"""
    return (celsius * 9/5) + 32

def check_temperature(temp_c):
    """Check if temperature is comfortable"""
    if 18 <= temp_c <= 25:
        return "comfortable"
    elif temp_c < 18:
        return "cold"
    else:
        return "hot"

temp_c = 25
temp_f = celsius_to_fahrenheit(temp_c)
print(f"{temp_c}°C = {temp_f:.1f}°F")
print(f"Temperature is {check_temperature(temp_c)}")


# ============================================================================
# 15. PRACTICAL EXAMPLE 2: USER AUTHENTICATION
# ============================================================================
print("\n=== Example 2: User Authentication ===")

def check_login(username, password, is_admin=False):
    """Check if user can login"""
    valid_username = username == "admin" or username == "user"
    valid_password = len(password) >= 8
    
    if is_admin and username != "admin":
        return False, "Only admin can login with admin privileges"
    
    if valid_username and valid_password:
        return True, "Login successful"
    elif not valid_username:
        return False, "Invalid username"
    else:
        return False, "Password too short"

success, message = check_login("admin", "password123", is_admin=True)
print(f"{'✓' if success else '✗'} {message}")

success, message = check_login("user", "pass")
print(f"{'✓' if success else '✗'} {message}")


# ============================================================================
# 16. PRACTICAL EXAMPLE 3: GRADE CALCULATOR
# ============================================================================
print("\n=== Example 3: Grade Calculator ===")

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
    
    is_perfect = score == 100
    is_failing = score < 60
    
    return grade, "Perfect!" if is_perfect else ("Failing" if is_failing else "")

scores = [85, 72, 91, 58]
for score in scores:
    grade, note = calculate_grade(score)
    print(f"Score: {score}, Grade: {grade} {note}")

average = sum(scores) / len(scores)
qualified = average >= 70 and all(s >= 60 for s in scores)
print(f"Average: {average:.2f}, Qualified: {qualified}")


# ============================================================================
# 17. PRACTICAL EXAMPLE 4: BITWISE PERMISSIONS
# ============================================================================
print("\n=== Example 4: Bitwise Permissions ===")

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

file_perms = FilePermissions()
file_perms.add_permission(FilePermissions.READ)
file_perms.add_permission(FilePermissions.WRITE)

print(f"Permissions: {file_perms.display()}")

if file_perms.has_permission(FilePermissions.READ):
    print("Can read file")

file_perms.remove_permission(FilePermissions.WRITE)
print(f"After removal: {file_perms.display()}")


# ============================================================================
# 18. PRACTICAL EXAMPLE 5: LOAN ELIGIBILITY
# ============================================================================
print("\n=== Example 5: Loan Eligibility ===")

def check_loan_eligibility(age, income, credit_score, employment_years):
    """Check if customer is eligible for loan"""
    
    age_valid = 21 <= age <= 65
    income_valid = income >= 30000
    credit_valid = credit_score >= 600
    employment_valid = employment_years >= 2
    
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

# Test cases
test_cases = [
    (28, 35000, 580, 1),    # New graduate
    (25, 25000, 620, 5),    # Low income
    (45, 50000, 750, 10),   # Ideal case
]

for age, income, credit, employment in test_cases:
    result = check_loan_eligibility(age, income, credit, employment)
    print(f"Age: {age}, Income: ${income}, Credit: {credit}, Employment: {employment}y")
    print(f"  Eligible: {result['eligible']}")
    print()

print("=== End of Basic Operators Examples ===")
