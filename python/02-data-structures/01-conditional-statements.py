"""
Conditional Statements in Python - Practical Examples
Executable examples for if, elif, else, nested conditions, and ternary expressions.
"""

print("\n=== CONDITIONAL STATEMENTS IN PYTHON ===")


# ============================================================================
# 1. BASIC IF STATEMENT
# ============================================================================
print("\n=== 1. BASIC IF STATEMENT ===")

temperature = 35

if temperature > 30:
	print("It is a hot day")


# ============================================================================
# 2. IF ELSE STATEMENT
# ============================================================================
print("\n=== 2. IF ELSE STATEMENT ===")

number = 7

if number % 2 == 0:
	print(f"{number} is even")
else:
	print(f"{number} is odd")


# ============================================================================
# 3. IF ELIF ELSE STATEMENT
# ============================================================================
print("\n=== 3. IF ELIF ELSE STATEMENT ===")

score = 82

if score >= 90:
	print("Grade A")
elif score >= 80:
	print("Grade B")
elif score >= 70:
	print("Grade C")
else:
	print("Need improvement")


# ============================================================================
# 4. NESTED CONDITIONALS
# ============================================================================
print("\n=== 4. NESTED CONDITIONALS ===")

age = 22
has_id = True

if age >= 18:
	if has_id:
		print("Entry allowed")
	else:
		print("ID is required")
else:
	print("Underage")


# ============================================================================
# 5. COMPARISON OPERATORS IN CONDITIONS
# ============================================================================
print("\n=== 5. COMPARISON OPERATORS ===")

salary = 50000

if salary >= 40000:
	print("Eligible for loan review")

print(f"10 == 10: {10 == 10}")
print(f"10 != 5: {10 != 5}")
print(f"15 > 8: {15 > 8}")
print(f"7 < 3: {7 < 3}")
print(f"20 >= 20: {20 >= 20}")
print(f"11 <= 9: {11 <= 9}")


# ============================================================================
# 6. LOGICAL OPERATORS
# ============================================================================
print("\n=== 6. LOGICAL OPERATORS ===")

age = 25
citizen = True

if age >= 18 and citizen:
	print("Eligible to vote")

is_weekend = False
is_holiday = True

if is_weekend or is_holiday:
	print("Office closed")

is_logged_in = False

if not is_logged_in:
	print("Please log in")


# ============================================================================
# 7. TRUTHY AND FALSY VALUES
# ============================================================================
print("\n=== 7. TRUTHY AND FALSY VALUES ===")

items = []

if items:
	print("List has data")
else:
	print("List is empty")

username = "admin"

if username:
	print("Username accepted")


# ============================================================================
# 8. TERNARY CONDITIONAL EXPRESSION
# ============================================================================
print("\n=== 8. TERNARY CONDITIONAL ===")

age = 17
status = "Adult" if age >= 18 else "Minor"
print(f"Status: {status}")


# ============================================================================
# 9. PRACTICAL EXAMPLE - EVEN OR ODD
# ============================================================================
print("\n=== 9. EXAMPLE: EVEN OR ODD ===")


def check_even_odd(value):
	if value % 2 == 0:
		return "Even"
	return "Odd"


for value in [10, 7, 24, 13]:
	print(f"{value} -> {check_even_odd(value)}")


# ============================================================================
# 10. PRACTICAL EXAMPLE - GRADE CALCULATOR
# ============================================================================
print("\n=== 10. EXAMPLE: GRADE CALCULATOR ===")


def calculate_grade(marks):
	if marks >= 90:
		return "A"
	if marks >= 80:
		return "B"
	if marks >= 70:
		return "C"
	if marks >= 60:
		return "D"
	return "F"


for marks in [95, 84, 76, 61, 40]:
	print(f"Marks: {marks}, Grade: {calculate_grade(marks)}")


# ============================================================================
# 11. PRACTICAL EXAMPLE - MAXIMUM OF TWO NUMBERS
# ============================================================================
print("\n=== 11. EXAMPLE: MAXIMUM OF TWO NUMBERS ===")


def maximum_of_two(first, second):
	if first > second:
		return first
	return second


print(f"Maximum of 15 and 20 is {maximum_of_two(15, 20)}")
print(f"Maximum of 99 and 45 is {maximum_of_two(99, 45)}")


# ============================================================================
# 12. PRACTICAL EXAMPLE - POSITIVE, NEGATIVE, ZERO
# ============================================================================
print("\n=== 12. EXAMPLE: POSITIVE, NEGATIVE, ZERO ===")


def number_type(value):
	if value > 0:
		return "Positive"
	if value < 0:
		return "Negative"
	return "Zero"


for value in [8, -4, 0]:
	print(f"{value} -> {number_type(value)}")


# ============================================================================
# 13. PRACTICAL EXAMPLE - LOGIN ACCESS
# ============================================================================
print("\n=== 13. EXAMPLE: LOGIN ACCESS ===")


def access_dashboard(is_authenticated, is_admin):
	if is_authenticated and is_admin:
		return "Admin dashboard"
	if is_authenticated:
		return "User dashboard"
	return "Access denied"


print(access_dashboard(True, True))
print(access_dashboard(True, False))
print(access_dashboard(False, False))


# ============================================================================
# 14. PRACTICAL EXAMPLE - DISCOUNT SYSTEM
# ============================================================================
print("\n=== 14. EXAMPLE: DISCOUNT SYSTEM ===")


def calculate_discount(amount):
	if amount >= 5000:
		return 0.20
	if amount >= 2000:
		return 0.10
	if amount >= 1000:
		return 0.05
	return 0.0


for amount in [800, 1200, 2500, 6000]:
	discount = calculate_discount(amount)
	print(f"Amount: {amount}, Discount: {discount * 100:.0f}%")


# ============================================================================
# 15. PRACTICAL EXAMPLE - ELIGIBILITY CHECK
# ============================================================================
print("\n=== 15. EXAMPLE: ELIGIBILITY CHECK ===")


def can_enter(age_value, has_ticket_value):
	if age_value >= 18 and has_ticket_value:
		return "You can enter"
	return "Entry denied"


print(can_enter(21, True))
print(can_enter(17, True))
print(can_enter(22, False))


print("\n=== END OF CONDITIONAL STATEMENTS EXAMPLES ===")
