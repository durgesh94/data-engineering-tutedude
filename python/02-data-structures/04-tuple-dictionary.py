"""
Tuples and Dictionaries in Python - Practical Examples
Executable examples covering creation, immutability, unpacking,
methods, and common developer scenarios for tuples and dictionaries.
"""

print("\n" + "="*80)
print("TUPLES AND DICTIONARIES IN PYTHON")
print("="*80)


# ============================================================================
# ========================= TUPLES SECTION ==================================
# ============================================================================

print("\n" + "="*80)
print("PART 1: TUPLES")
print("="*80)


# ============================================================================
# WHEN TO USE TUPLES
# ============================================================================
print("\n=== WHEN TO USE TUPLES ===")

# 1. Immutable data that shouldn't change
print("\n1. Immutable data (protection from modification):")
origin = (0, 0)
print(f"Origin coordinates: {origin}")

# 2. Use as dictionary keys (tuples are hashable)
print("\n2. Use as dictionary keys:")
locations = {
	(10, 20): "Point A",
	(30, 40): "Point B",
	(0, 0): "Origin"
}
print(f"Locations: {locations}")
print(f"Location at (10, 20): {locations[(10, 20)]}")

# 3. Multiple return values from function
print("\n3. Return multiple values from function:")
def get_user_info():
	return ("Alice", 25, "alice@email.com")

name, age, email = get_user_info()
print(f"User: {name}, Age: {age}, Email: {email}")

# 4. Fixed structure (e.g., RGB colors)
print("\n4. Fixed structure (RGB colors):")
red = (255, 0, 0)
green = (0, 255, 0)
blue = (0, 0, 255)
print(f"Red: {red}, Green: {green}, Blue: {blue}")

# 5. Prevent accidental modification
print("\n5. Protect configuration from modification:")
DB_CONFIG = ("localhost", 5432, "production")
print(f"Database config: {DB_CONFIG}")
# DB_CONFIG[0] = "otherhost"  # ✗ Error - protected

# 6. Can be set members (lists cannot)
print("\n6. Use in sets (for unique positions):")
unique_points = {(0, 0), (1, 1), (2, 2), (1, 1)}
print(f"Unique points: {unique_points}")


# ============================================================================
# WHY USE TUPLES - ADVANTAGES
# ============================================================================
print("\n=== WHY TO USE TUPLES ===")

# 1. Immutability = Safety
print("\n1. Immutability = Data safety:")
important = (1, 2, 3)
print(f"Original: {important}")

# 2. Hashable - can be keys
print("\n2. Hashable - can be dictionary keys:")
cache = {(1, 2): "value1", (3, 4): "value2"}
print(f"Cache lookup (1,2): {cache[(1, 2)]}")

# 3. Slightly faster than lists
print("\n3. Performance - faster iteration:")
import timeit
tuple_time = timeit.timeit("for x in (1,2,3,4,5): pass", number=1000000)
list_time = timeit.timeit("for x in [1,2,3,4,5]: pass", number=1000000)
print(f"Tuple iteration: {tuple_time:.4f}s, List iteration: {list_time:.4f}s")

# 4. Can be set elements
print("\n4. Set members (lists cannot be):")
coordinates_set = {(0, 0), (10, 20), (5, 15)}
print(f"Coordinates in set: {coordinates_set}")

# 5. Function return values
print("\n5. Clean multiple return values:")
def calculate_stats(numbers):
	return (len(numbers), sum(numbers), sum(numbers) / len(numbers))

result = calculate_stats([10, 20, 30])
count, total, average = result
print(f"Count: {count}, Total: {total}, Average: {average}")


# ============================================================================
# PURPOSE OF TUPLES
# ============================================================================
print("\n=== PURPOSE OF TUPLES ===")

# 1. Fixed records
print("\n1. Fixed record storage:")
student_record = ("Alice", 101, 3.8)
print(f"Student: {student_record}")

# 2. Dictionary keys
print("\n2. Use as dictionary keys:")
grid = {(0, 0): "A", (0, 1): "B", (1, 0): "C", (1, 1): "D"}
print(f"Grid at (0,1): {grid[(0, 1)]}")

# 3. Function return protocol
print("\n3. Tuple unpacking in function returns:")
def divide_with_remainder(a, b):
	return (a // b, a % b)

quotient, remainder = divide_with_remainder(17, 5)
print(f"17 ÷ 5 = {quotient} remainder {remainder}")

# 4. Set members for uniqueness
print("\n4. Unique position tracking:")
visited = set()
visited.add((0, 0))
visited.add((0, 1))
visited.add((0, 0))  # Duplicate not added
print(f"Visited positions: {visited}")

# 5. Data protection
print("\n5. Immutable configuration:")
API_CONFIG = ("https://api.example.com", 443, True)
print(f"API endpoint: {API_CONFIG[0]}:{API_CONFIG[1]}")

# 6. Multiple assignment
print("\n6. Clean multiple variable assignment:")
x, y, z = (10, 20, 30)
print(f"Variables: x={x}, y={y}, z={z}")


# ============================================================================
# TUPLE OPERATIONS
# ============================================================================
print("\n=== TUPLE OPERATIONS ===")

# 1. Single element tuple (note the comma)
print("\n1. Single element tuple:")
single = (42,)
print(f"Single tuple: {single}, Type: {type(single)}")

# 2. Tuple unpacking
print("\n2. Unpacking tuples:")
point = (10, 20)
x, y = point
print(f"Unpacked: x={x}, y={y}")

# 3. Unpacking with *
print("\n3. Unpacking with rest collection:")
data = (1, 2, 3, 4, 5)
first, *middle, last = data
print(f"First: {first}, Middle: {middle}, Last: {last}")

# 4. Tuple methods
print("\n4. Tuple methods (count and index):")
numbers = (1, 2, 2, 3, 2, 4)
print(f"Count of 2: {numbers.count(2)}")
fruits = ("apple", "banana", "mango")
print(f"Index of banana: {fruits.index('banana')}")

# 5. Slicing tuples
print("\n5. Slicing tuples:")
sequence = (10, 20, 30, 40, 50)
print(f"Original: {sequence}")
print(f"sequence[1:4]: {sequence[1:4]}")
print(f"sequence[::2]: {sequence[::2]}")
print(f"sequence[::-1]: {sequence[::-1]}")

# 6. Nested tuples
print("\n6. Nested tuples:")
matrix = ((1, 2), (3, 4), (5, 6))
print(f"Matrix: {matrix}")
print(f"Element at [1][0]: {matrix[1][0]}")

# 7. Tuple comprehension
print("\n7. Tuple comprehensions:")
squares = tuple(x**2 for x in range(1, 6))
print(f"Squares: {squares}")

# 8. Concatenation and repetition
print("\n8. Tuple concatenation and repetition:")
t1 = (1, 2)
t2 = (3, 4)
print(f"t1 + t2: {t1 + t2}")
print(f"t1 * 3: {t1 * 3}")

# 9. Looping with enumerate
print("\n9. Looping with enumerate:")
colors = ("red", "green", "blue")
for index, color in enumerate(colors, start=1):
	print(f"  {index}. {color}")

# 10. Membership testing
print("\n10. Membership testing:")
fruits = ("apple", "banana", "mango")
print(f"'banana' in fruits: {'banana' in fruits}")
print(f"'orange' not in fruits: {'orange' not in fruits}")


# ============================================================================
# ======================== DICTIONARIES SECTION =============================
# ============================================================================

print("\n\n" + "="*80)
print("PART 2: DICTIONARIES")
print("="*80)


# ============================================================================
# WHEN TO USE DICTIONARIES
# ============================================================================
print("\n=== WHEN TO USE DICTIONARIES ===")

# 1. Key-value relationships
print("\n1. Key-value relationships (student record):")
student = {"name": "Bob", "roll": 101, "gpa": 3.8}
print(f"Student: {student}")

# 2. Fast lookup by key
print("\n2. Fast lookup by key:")
phone_book = {"alice": "555-1234", "bob": "555-5678", "charlie": "555-9999"}
print(f"Charlie's phone: {phone_book['charlie']}")

# 3. Counting things
print("\n3. Count occurrences:")
items = ["apple", "banana", "apple", "orange", "banana", "apple"]
count = {}
for item in items:
	count[item] = count.get(item, 0) + 1
print(f"Item counts: {count}")

# 4. Configuration storage
print("\n4. Configuration storage:")
config = {"host": "localhost", "port": 8080, "debug": True}
print(f"Config: {config}")

# 5. Representing real-world objects
print("\n5. Object representation (product):")
product = {"name": "Laptop", "price": 999, "stock": 10, "color": "silver"}
print(f"Product: {product}")

# 6. API responses
print("\n6. API response structure:")
api_response = {
	"status": "success",
	"code": 200,
	"data": {"user_id": 123, "username": "alice"}
}
print(f"Response: {api_response}")


# ============================================================================
# WHY USE DICTIONARIES
# ============================================================================
print("\n=== WHY TO USE DICTIONARIES ===")

# 1. Fast O(1) lookup
print("\n1. O(1) fast lookup by key:")
users = {f"user_{i}": f"email_{i}@example.com" for i in range(1000)}
print(f"Found email for user_500: {users['user_500']}")

# 2. Descriptive keys (readable)
print("\n2. Descriptive keys vs indexed access:")
person_dict = {"name": "Alice", "age": 30}
print(f"Dict (clear): name={person_dict['name']}, age={person_dict['age']}")

# 3. Flexible structure
print("\n3. Flexible structure (different keys for different objects):")
emp1 = {"name": "Alice", "salary": 80000}
emp2 = {"name": "Bob", "salary": 75000, "bonus": 5000}
print(f"Employee 1: {emp1}")
print(f"Employee 2: {emp2}")

# 4. Mirrors real-world data
print("\n4. Works with JSON-like data:")
user_data = {
	"id": 1,
	"name": "Alice",
	"email": "alice@example.com",
	"preferences": {
		"theme": "dark",
		"notifications": True
	}
}
print(f"User theme preference: {user_data['preferences']['theme']}")

# 5. Rich methods
print("\n5. Rich built-in methods:")
d = {"a": 1, "b": 2, "c": 3}
print(f"Keys: {list(d.keys())}")
print(f"Values: {list(d.values())}")

# 6. Mutable (can be modified)
print("\n6. Mutable - can change dynamically:")
settings = {"mode": "basic"}
print(f"Initial: {settings}")
settings["theme"] = "dark"
settings["mode"] = "advanced"
print(f"Updated: {settings}")


# ============================================================================
# PURPOSE OF DICTIONARIES
# ============================================================================
print("\n=== PURPOSE OF DICTIONARIES ===")

# 1. Object representation
print("\n1. Represent objects/entities:")
book = {"title": "Python 101", "author": "John Doe", "pages": 350}
print(f"Book: {book}")

# 2. Data lookup service
print("\n2. Fast lookup database:")
city_codes = {"NYC": "001", "LA": "002", "CHI": "003"}
print(f"Code for NYC: {city_codes.get('NYC', 'Not found')}")

# 3. Configuration management
print("\n3. Configuration management:")
db_config = {
	"host": "db.example.com",
	"port": 5432,
	"user": "admin",
	"password": "secret123"
}
print(f"Connecting to {db_config['host']}:{db_config['port']}")

# 4. Counting/statistics
print("\n4. Frequency counting and statistics:")
test_scores = {"math": 90, "english": 85, "science": 92, "history": 88}
avg_score = sum(test_scores.values()) / len(test_scores)
print(f"Scores: {test_scores}")
print(f"Average: {avg_score:.1f}")

# 5. Caching results
print("\n5. Cache computed results:")
memo_cache = {}
def expensive_function(n):
	if n not in memo_cache:
		memo_cache[n] = n ** 2
	return memo_cache[n]

print(f"Calculate 5²: {expensive_function(5)}")
print(f"Cache hit for 5²: {expensive_function(5)} (from cache)")

# 6. Grouping related data
print("\n6. Grouping related information:")
user_profile = {
	"personal": {"name": "Alice", "age": 30},
	"contact": {"email": "alice@email.com", "phone": "555-1234"},
	"social": {"github": "alice123", "twitter": "@alice"}
}
print(f"User email: {user_profile['contact']['email']}")

# 7. Merging/consolidating data
print("\n7. Merge multiple data sources:")
user_info = {"id": 1, "name": "Alice"}
user_stats = {"posts": 50, "followers": 1000}
complete_profile = {**user_info, **user_stats}
print(f"Complete profile: {complete_profile}")


# ============================================================================
# DICTIONARY OPERATIONS
# ============================================================================
print("\n=== DICTIONARY OPERATIONS ===")

# 1. Creating dictionaries
print("\n1. Creating dictionaries (various methods):")
dict1 = {"a": 1, "b": 2}
dict2 = dict(x=10, y=20)
dict3 = dict([("p", 100), ("q", 200)])
print(f"Dict 1: {dict1}")
print(f"Dict 2: {dict2}")
print(f"Dict 3: {dict3}")

# 2. Accessing values
print("\n2. Accessing values (safe with .get()):")
person = {"name": "Bob", "age": 25}
print(f"Name: {person['name']}")
print(f"Phone (safe): {person.get('phone', 'Not provided')}")

# 3. Adding/updating items
print("\n3. Adding and updating items:")
data = {}
data["key1"] = "value1"
data["key2"] = "value2"
data["key1"] = "updated"
print(f"After updates: {data}")

# 4. Removing items
print("\n4. Removing items (del, pop, clear):")
d = {"a": 1, "b": 2, "c": 3}
del d["a"]
print(f"After del 'a': {d}")
popped = d.pop("b")
print(f"Popped 'b': {popped}, Remaining: {d}")

# 5. Dictionary methods
print("\n5. Dictionary methods (keys, values, items):")
scores = {"alice": 90, "bob": 85, "charlie": 92}
print(f"Keys: {list(scores.keys())}")
print(f"Values: {list(scores.values())}")
print(f"Items: {list(scores.items())}")

# 6. Looping methods
print("\n6. Three ways to loop:")
d = {"x": 10, "y": 20, "z": 30}
print("Loop through keys:")
for key in d:
	print(f"  {key}")
print("Loop through values:")
for value in d.values():
	print(f"  {value}")
print("Loop through key-value pairs:")
for k, v in d.items():
	print(f"  {k}: {v}")

# 7. Membership testing
print("\n7. Membership testing (key in dict):")
person = {"name": "Alice", "age": 25}
print(f"'name' in person: {'name' in person}")
print(f"'email' not in person: {'email' not in person}")

# 8. Nested dictionaries
print("\n8. Nested dictionary access:")
employees = {
	"emp001": {"name": "Alice", "dept": "IT", "salary": 80000},
	"emp002": {"name": "Bob", "dept": "HR", "salary": 75000}
}
print(f"emp001 name: {employees['emp001']['name']}")
print(f"emp002 salary: {employees['emp002']['salary']}")

# 9. Dictionary comprehension
print("\n9. Dictionary comprehensions:")
squares = {x: x**2 for x in range(1, 6)}
print(f"Squares dict: {squares}")
filtered = {k: v for k, v in squares.items() if v > 10}
print(f"Filtered (>10): {filtered}")

# 10. Updating dictionaries
print("\n10. Update dictionary with .update():")
config = {"host": "localhost", "port": 8080}
config.update({"debug": True, "timeout": 30})
print(f"Updated config: {config}")


# ============================================================================
# PRACTICAL EXAMPLES
# ============================================================================
print("\n=== PRACTICAL EXAMPLES ===")

# Example 1: Word frequency counter
print("\n11. Example: Word frequency counter")
text = "python python java swift python java ruby"
words = text.split()
word_freq = {}
for word in words:
	word_freq[word] = word_freq.get(word, 0) + 1

print(f"Word frequencies: {word_freq}")
print(f"Most common: {max(word_freq, key=word_freq.get)}")

# Example 2: Find highest scorer
print("\n12. Example: Find highest scorer")
scores = {"alice": 85, "bob": 92, "charlie": 88, "diana": 95}
top_scorer = max(scores, key=scores.get)
print(f"Highest score: {top_scorer} with {scores[top_scorer]} points")

# Example 3: Filter dictionary
print("\n13. Example: Filter passing scores")
all_scores = {"alice": 45, "bob": 75, "charlie": 82, "diana": 55}
passing = {k: v for k, v in all_scores.items() if v >= 70}
print(f"Passing students: {passing}")

# Example 4: Group by category
print("\n14. Example: Group items by category")
items = [
	{"name": "apple", "category": "fruit"},
	{"name": "carrot", "category": "vegetable"},
	{"name": "banana", "category": "fruit"},
	{"name": "lettuce", "category": "vegetable"}
]
grouped = {}
for item in items:
	cat = item["category"]
	if cat not in grouped:
		grouped[cat] = []
	grouped[cat].append(item["name"])
print(f"Grouped: {grouped}")

# Example 5: Swap keys and values
print("\n15. Example: Swap dictionary keys and values")
currency_rates = {"USD": 1.0, "EUR": 0.85, "GBP": 0.73}
reversed_rates = {v: k for k, v in currency_rates.items()}
print(f"Original: {currency_rates}")
print(f"Reversed: {reversed_rates}")

# Example 6: Merge multiple dicts
print("\n16. Example: Merge dictionaries")
dict_a = {"name": "Alice", "age": 30}
dict_b = {"city": "NYC", "job": "Engineer"}
merged = {**dict_a, **dict_b}
print(f"Merged: {merged}")

# Example 7: Authentication check
print("\n17. Example: User authentication")
users_db = {
	"alice": "pass123",
	"bob": "pass456",
	"charlie": "pass789"
}
username = "alice"
password = "pass123"
if username in users_db and users_db[username] == password:
	print(f"✓ Login successful for {username}")
else:
	print(f"✗ Invalid credentials")

# Example 8: API response handling
print("\n18. Example: Parse API response")
response = {
	"status": 200,
	"success": True,
	"data": {
		"id": 123,
		"name": "Alice",
		"email": "alice@example.com"
	}
}
if response["success"]:
	user = response["data"]
	print(f"User loaded: {user['name']} ({user['email']})")

# Example 9: Tuple as dict keys
print("\n19. Example: Tuples as dictionary keys")
coordinates = {
	(0, 0): "Origin",
	(1, 0): "X-axis",
	(0, 1): "Y-axis",
	(1, 1): "Quadrant 1"
}
print(f"Location at (1, 1): {coordinates[(1, 1)]}")

# Example 20: Multiple returns with tuple unpacking
print("\n20. Example: Tuple unpacking from function")
def get_statistics(data):
	return (len(data), sum(data), sum(data)/len(data))

numbers = [10, 20, 30, 40, 50]
count, total, average = get_statistics(numbers)
print(f"Stats: count={count}, total={total}, average={average}")

# Example 21: Tuple for fixed configuration
print("\n21. Example: Immutable configuration tuple")
APP_CONFIG = ("https://api.example.com", 8443, "production", True)
api_url, port, environment, ssl_enabled = APP_CONFIG
print(f"Running in {environment} at {api_url}:{port} (SSL: {ssl_enabled})")

# Example 22: Dictionary with tuple values
print("\n22. Example: Dict storing tuple values")
inventory = {
	"item_a": (100, 5.99, "Available"),
	"item_b": (50, 9.99, "Available"),
	"item_c": (0, 15.99, "Out of Stock")
}
for item, (quantity, price, status) in inventory.items():
	print(f"{item}: {quantity} units at ${price} - {status}")

# Example 23: Default dict behavior
print("\n23. Example: Safe dict access with setdefault")
user_preferences = {}
user_preferences.setdefault("theme", "light")
user_preferences.setdefault("language", "en")
print(f"Preferences: {user_preferences}")

# Example 24: Dictionary copy (shallow vs reference)
print("\n24. Example: Dictionary copying")
original = {"a": 1, "b": 2}
reference = original
copy_dict = original.copy()
reference["a"] = 999
copy_dict["b"] = 999
print(f"Original (modified by reference): {original}")
print(f"Copy (independent): {copy_dict}")

# Example 25: Complex nested structure
print("\n25. Example: Complex nested data structure")
company = {
	"name": "Tech Corp",
	"employees": [
		{"id": 1, "name": "Alice", "skills": ("Python", "SQL")},
		{"id": 2, "name": "Bob", "skills": ("Java", "C++")}
	],
	"location": {"city": "NYC", "zip": "10001"}
}
print(f"Company: {company['name']}")
print(f"Employee 1: {company['employees'][0]['name']}")
print(f"Employee 1 skills: {company['employees'][0]['skills']}")
print(f"Location: {company['location']['city']}")

print("\n" + "="*80)
print("END OF TUPLES AND DICTIONARIES EXAMPLES")
print("="*80)
