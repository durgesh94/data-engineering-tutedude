"""
Sets in Python - Practical Examples
Executable examples covering creation, operations, methods,
mathematical set operations, and common developer scenarios.
"""

print("\n" + "="*80)
print("SETS IN PYTHON")
print("="*80)


# ============================================================================
# WHEN TO USE SETS
# ============================================================================
print("\n=== WHEN TO USE SETS ===")

# 1. When you need unique values only
print("\n1. Remove duplicates from a collection:")
numbers = [1, 2, 2, 3, 3, 3, 4, 4, 5]
unique = set(numbers)
print(f"Original: {numbers}")
print(f"Unique: {unique}")

# 2. Fast membership testing
print("\n2. Fast membership testing (O(1)):")
banned_users = {"user123", "user456", "user789"}
check_user = "user123"
if check_user in banned_users:
	print(f"✗ {check_user} is banned")
else:
	print(f"✓ {check_user} is allowed")

# 3. Mathematical set operations
print("\n3. Mathematical set operations:")
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}
print(f"Set 1: {set1}")
print(f"Set 2: {set2}")
print(f"Common (intersection): {set1 & set2}")
print(f"Combined (union): {set1 | set2}")
print(f"Only in Set 1 (difference): {set1 - set2}")

# 4. Eliminate duplicates
print("\n4. Create unique list from duplicates:")
items = ["apple", "banana", "apple", "orange", "banana"]
unique_items = set(items)
print(f"Original: {items}")
print(f"Unique: {unique_items}")

# 5. Check if all conditions are true
print("\n5. Find elements in all groups:")
group1 = {"a", "b", "c", "d"}
group2 = {"c", "d", "e", "f"}
group3 = {"d", "e", "f", "g"}
in_all = group1 & group2 & group3
print(f"In all groups: {in_all}")

# 6. Database-like operations
print("\n6. Find followers from different sources:")
twitter_followers = {"alice", "bob", "charlie"}
facebook_followers = {"bob", "diana", "eve"}
all_followers = twitter_followers | facebook_followers
print(f"All followers: {all_followers}")
print(f"Only on Twitter: {twitter_followers - facebook_followers}")


# ============================================================================
# WHY USE SETS - ADVANTAGES
# ============================================================================
print("\n=== WHY TO USE SETS ===")

# 1. O(1) fast membership testing
print("\n1. O(1) fast membership testing:")
large_set = set(range(1000000))
import time
start = time.time()
result = 999999 in large_set
end = time.time()
print(f"Found {999999} instantly in {(end-start)*1000:.4f}ms")

# 2. Automatic duplicate removal
print("\n2. Duplicates are silently ignored:")
data = [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]
unique = set(data)
print(f"Original length: {len(data)}, Unique length: {len(unique)}")

# 3. Mathematical operations
print("\n3. Mathematical set operations:")
a = {1, 2, 3}
b = {2, 3, 4}
print(f"a & b (intersection): {a & b}")
print(f"a | b (union): {a | b}")
print(f"a - b (difference): {a - b}")
print(f"a ^ b (symmetric diff): {a ^ b}")

# 4. Find patterns in data
print("\n4. Find common patterns:")
list1 = ["apple", "banana", "orange"]
list2 = ["banana", "orange", "grape"]
common = set(list1) & set(list2)
only_in_list1 = set(list1) - set(list2)
print(f"Common fruits: {common}")
print(f"Only in list1: {only_in_list1}")

# 5. Memory efficient for large lookups
print("\n5. Memory efficiency and speed:")
large_list = list(range(100000))
large_set = set(range(100000))
# Lookup in large_set is much faster than in large_list

# 6. Prevents accidental duplicates
print("\n6. Prevents adding duplicates:")
visited_urls = set()
urls = ["home", "about", "contact", "home", "about"]
for url in urls:
	visited_urls.add(url)
print(f"Unique URLs visited: {visited_urls}")


# ============================================================================
# PURPOSE OF SETS
# ============================================================================
print("\n=== PURPOSE OF SETS ===")

# 1. Deduplication
print("\n1. Deduplication:")
emails = ["alice@email.com", "bob@email.com", "alice@email.com", "charlie@email.com"]
unique_emails = set(emails)
print(f"Unique emails: {unique_emails}")

# 2. Membership queries
print("\n2. Membership validation:")
blocked_ids = {101, 102, 103, 104, 105}
user_id = 203
if user_id not in blocked_ids:
	print(f"✓ User {user_id} can proceed")

# 3. Finding common elements
print("\n3. Find what's common (skills both know):")
python_devs = {"alice", "bob", "charlie"}
java_devs = {"bob", "diana", "eve"}
full_stack = python_devs & java_devs
print(f"Developers skilled in both: {full_stack}")

# 4. Finding unique elements
print("\n4. Find items in one set but not another:")
all_products = {"A", "B", "C", "D", "E"}
discontinued = {"B", "D"}
available = all_products - discontinued
print(f"Available products: {available}")

# 5. Tracking visited/processed items
print("\n5. Track processed items:")
processed_orders = set()
order_ids = [1001, 1002, 1001, 1003, 1002, 1004]
for order_id in order_ids:
	if order_id not in processed_orders:
		print(f"  Processing order {order_id}")
		processed_orders.add(order_id)

# 6. Set algebra
print("\n6. Complex set algebra operations:")
a = {1, 2, 3, 4}
b = {3, 4, 5, 6}
c = {4, 5, 6, 7}
print(f"(a | b) & c: {(a | b) & c}")
print(f"a ^ (b ^ c): {a ^ (b ^ c)}")

# 7. Data analysis - find unique values
print("\n7. Find unique products purchased:")
purchases = ["A", "B", "A", "C", "B", "A", "D", "C"]
unique_products = set(purchases)
print(f"Total purchases: {len(purchases)}")
print(f"Unique products: {len(unique_products)}")
print(f"Products: {unique_products}")


# ============================================================================
# SET CREATION
# ============================================================================
print("\n=== SET CREATION ===")

# 1. Empty set
print("\n1. Create empty set:")
empty_set = set()
print(f"Empty set: {empty_set}, Type: {type(empty_set)}")

# 2. Set with values
print("\n2. Set with initial values:")
numbers = {1, 2, 3, 4, 5}
colors = {"red", "green", "blue"}
mixed = {1, "two", 3.14}
print(f"Numbers: {numbers}")
print(f"Colors: {colors}")
print(f"Mixed: {mixed}")

# 3. Using set() constructor
print("\n3. Convert from other types:")
from_list = set([1, 2, 3, 2, 1])
print(f"From list: {from_list}")

from_string = set("hello")
print(f"From string: {from_string}")

from_range = set(range(5))
print(f"From range: {from_range}")

# 4. Set comprehensions
print("\n4. Set comprehensions:")
squares = {x**2 for x in range(1, 6)}
print(f"Squares: {squares}")

even_numbers = {x for x in range(10) if x % 2 == 0}
print(f"Even numbers: {even_numbers}")


# ============================================================================
# ADDING ELEMENTS
# ============================================================================
print("\n=== ADDING ELEMENTS ===")

# 1. add() - single element
print("\n1. Add single element:")
colors = {"red", "blue"}
colors.add("green")
print(f"After add: {colors}")

# 2. Adding duplicate (silently ignored)
print("\n2. Adding duplicate (no effect):")
colors.add("red")
print(f"After adding duplicate: {colors}")

# 3. update() - multiple elements
print("\n3. Update with multiple elements:")
numbers = {1, 2, 3}
numbers.update([4, 5, 6])
print(f"After update: {numbers}")

# 4. update() with multiple iterables
print("\n4. Update with multiple iterables:")
items = {"a"}
items.update({1, 2}, {"x", "y"})
print(f"After multiple updates: {items}")


# ============================================================================
# REMOVING ELEMENTS
# ============================================================================
print("\n=== REMOVING ELEMENTS ===")

# 1. remove() - error if missing
print("\n1. Remove with remove() (error if missing):")
colors = {"red", "green", "blue"}
colors.remove("green")
print(f"After remove: {colors}")

# 2. discard() - no error if missing
print("\n2. Discard method (no error if missing):")
colors = {"red", "green", "blue"}
colors.discard("green")
colors.discard("yellow")  # No error
print(f"After discard: {colors}")

# 3. pop() - remove and return random
print("\n3. Pop removes random element:")
numbers = {1, 2, 3, 4, 5}
removed = numbers.pop()
print(f"Removed: {removed}, Remaining: {numbers}")

# 4. clear() - remove all
print("\n4. Clear all elements:")
items = {1, 2, 3}
items.clear()
print(f"After clear: {items}")


# ============================================================================
# SET OPERATIONS
# ============================================================================
print("\n=== SET OPERATIONS ===")

# 1. Union - all from both
print("\n1. Union (all from both sets):")
set1 = {1, 2, 3}
set2 = {3, 4, 5}
result = set1 | set2
print(f"Set 1: {set1}")
print(f"Set 2: {set2}")
print(f"Union: {result}")
print(f"Using method: {set1.union(set2)}")

# 2. Intersection - common elements
print("\n2. Intersection (common elements):")
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}
result = set1 & set2
print(f"Intersection: {result}")
print(f"Using method: {set1.intersection(set2)}")

# 3. Difference - in first but not second
print("\n3. Difference (in first but not second):")
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}
result = set1 - set2
print(f"Difference: {result}")
print(f"Using method: {set1.difference(set2)}")

# 4. Symmetric difference - in either but not both
print("\n4. Symmetric difference (in either but not both):")
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}
result = set1 ^ set2
print(f"Symmetric difference: {result}")
print(f"Using method: {set1.symmetric_difference(set2)}")

# 5. Multiple set operations
print("\n5. Combine multiple operations:")
a = {1, 2, 3}
b = {2, 3, 4}
c = {3, 4, 5}
result = (a | b) & c  # (union of a and b) intersected with c
print(f"(a|b)&c: {result}")


# ============================================================================
# SET METHODS
# ============================================================================
print("\n=== SET METHODS ===")

# 1. copy() - create independent copy
print("\n1. Copy method:")
original = {1, 2, 3}
copied = original.copy()
copied.add(4)
print(f"Original: {original}")
print(f"Copied: {copied}")

# 2. issubset() - all elements present
print("\n2. issubset (is first a subset of second):")
subset_test = {1, 2}
full_set = {1, 2, 3, 4}
print(f"{subset_test} ⊆ {full_set}: {subset_test.issubset(full_set)}")

# 3. issuperset() - contains all from another
print("\n3. issuperset (does first contain all of second):")
full_set = {1, 2, 3, 4}
partial_set = {1, 2}
print(f"{full_set} ⊇ {partial_set}: {full_set.issuperset(partial_set)}")

# 4. isdisjoint() - no common elements
print("\n4. isdisjoint (no common elements):")
a = {1, 2, 3}
b = {4, 5, 6}
c = {3, 4, 5}
print(f"{a} disjoint from {b}: {a.isdisjoint(b)}")
print(f"{a} disjoint from {c}: {a.isdisjoint(c)}")

# 5. intersection_update() - modify in place
print("\n5. intersection_update (modify in place):")
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}
set1.intersection_update(set2)
print(f"After intersection_update: {set1}")

# 6. difference_update() - remove in place
print("\n6. difference_update (remove matching):")
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}
set1.difference_update(set2)
print(f"After difference_update: {set1}")


# ============================================================================
# MEMBERSHIP TESTING
# ============================================================================
print("\n=== MEMBERSHIP TESTING ===")

# 1. Check if element in set
print("\n1. Check membership:")
colors = {"red", "green", "blue"}
print(f"'red' in colors: {'red' in colors}")
print(f"'yellow' in colors: {'yellow' in colors}")

# 2. Check if element not in set
print("\n2. Check non-membership:")
print(f"'yellow' not in colors: {'yellow' not in colors}")

# 3. Multiple membership checks
print("\n3. Multiple membership checks:")
allowed = {"admin", "moderator", "editor"}
user = "admin"
guest = "viewer"
print(f"'{user}' allowed: {user in allowed}")
print(f"'{guest}' allowed: {guest in allowed}")


# ============================================================================
# LOOPING AND ITERATION
# ============================================================================
print("\n=== LOOPING AND ITERATION ===")

# 1. Simple loop
print("\n1. Loop through set:")
colors = {"red", "green", "blue"}
for color in colors:
	print(f"  {color}")

# 2. Loop with enumerate
print("\n2. Loop with enumerate:")
colors = {"red", "green", "blue"}
for idx, color in enumerate(colors, start=1):
	print(f"  {idx}. {color}")

# 3. Loop with condition
print("\n3. Loop with condition:")
numbers = {1, 2, 3, 4, 5, 6}
print("Even numbers:")
for num in numbers:
	if num % 2 == 0:
		print(f"  {num}")


# ============================================================================
# SET COMPARISONS
# ============================================================================
print("\n=== SET COMPARISONS ===")

# 1. Equality
print("\n1. Set equality:")
set1 = {1, 2, 3}
set2 = {1, 2, 3}
set3 = {1, 2}
print(f"{set1} == {set2}: {set1 == set2}")
print(f"{set1} != {set3}: {set1 != set3}")

# 2. Subset/superset
print("\n2. Subset and superset:")
a = {1, 2}
b = {1, 2, 3}
print(f"{a} < {b} (strict subset): {a < b}")
print(f"{b} > {a} (strict superset): {b > a}")


# ============================================================================
# PRACTICAL EXAMPLES
# ============================================================================
print("\n=== PRACTICAL EXAMPLES ===")

# Example 11: Remove duplicates from list
print("\n11. Remove duplicates from list:")
data = [1, 2, 2, 3, 3, 3, 4, 4]
unique = list(set(data))
print(f"Original: {data}")
print(f"Unique: {unique}")

# Example 12: Find common friends
print("\n12. Find common friends:")
alice_friends = {"bob", "charlie", "diana"}
bob_friends = {"alice", "charlie", "eve"}
common = alice_friends & bob_friends
print(f"Alice's friends: {alice_friends}")
print(f"Bob's friends: {bob_friends}")
print(f"Common friends: {common}")

# Example 13: Find differences in datasets
print("\n13. Find differences in datasets:")
dataset_a = {1, 2, 3, 4, 5}
dataset_b = {4, 5, 6, 7, 8}
only_in_a = dataset_a - dataset_b
only_in_b = dataset_b - dataset_a
print(f"Only in A: {only_in_a}")
print(f"Only in B: {only_in_b}")

# Example 14: Membership validation
print("\n14. Membership validation (fast):")
valid_statuses = {"active", "inactive", "pending"}
status = "active"
if status in valid_statuses:
	print(f"✓ Status '{status}' is valid")

# Example 15: Track visited pages
print("\n15. Track visited pages:")
visited = set()
page_visits = ["home", "about", "home", "contact", "about"]
for page in page_visits:
	if page not in visited:
		print(f"✓ First visit to: {page}")
		visited.add(page)
	else:
		print(f"△ Revisiting: {page}")

# Example 16: Find unique words
print("\n16. Find unique words in text:")
text = "the quick brown fox jumps over the lazy dog"
words = set(text.split())
print(f"Total words: {len(text.split())}")
print(f"Unique words: {len(words)}")
print(f"Words: {words}")

# Example 17: Set algebra with 3+ sets
print("\n17. Complex operations with 3 sets:")
python_devs = {"alice", "bob", "charlie"}
javascript_devs = {"bob", "diana", "eve"}
ruby_devs = {"charlie", "diana", "frank"}
all_developers = python_devs | javascript_devs | ruby_devs
full_stack = python_devs & javascript_devs & ruby_devs
print(f"All developers: {all_developers}")
print(f"Multi-language experts: {full_stack}")

# Example 18: Find symmetric difference
print("\n18. Symmetric difference (unique to each):")
team_a = {1, 2, 3, 4}
team_b = {3, 4, 5, 6}
unique_to_each = team_a ^ team_b
print(f"Unique to each team: {unique_to_each}")

# Example 19: Check for intersection
print("\n19. Check if sets have overlap:")
group1 = {1, 2, 3}
group2 = {3, 4, 5}
if group1 & group2:
	print(f"Sets overlap: {group1 & group2}")
else:
	print("Sets have no common elements")

# Example 20: Subset/superset checking
print("\n20. Check subset and superset:")
admin_roles = {"read", "write", "delete"}
user_roles = {"read", "write"}
print(f"User roles ⊆ Admin roles: {user_roles.issubset(admin_roles)}")
print(f"Admin roles ⊇ User roles: {admin_roles.issuperset(user_roles)}")

# Example 21: Find unique items in multiple lists
print("\n21. Unique items across multiple lists:")
list1 = ["a", "b", "c"]
list2 = ["b", "c", "d"]
list3 = ["c", "d", "e"]
unique_overall = set(list1) | set(list2) | set(list3)
print(f"All unique items: {unique_overall}")

# Example 22: Filter based on set membership
print("\n22. Filter items in set:")
all_ids = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10}
valid_ids = {2, 4, 6, 8, 10}
filtered = [x for x in all_ids if x in valid_ids]
print(f"Filtered results: {filtered}")

# Example 23: Multiple intersections
print("\n23. Find common items across many sets:")
s1 = {1, 2, 3, 4, 5}
s2 = {2, 3, 4, 5, 6}
s3 = {3, 4, 5, 6, 7}
s4 = {4, 5, 6, 7, 8}
common_all = s1 & s2 & s3 & s4
print(f"Common to all: {common_all}")

# Example 24: Remove excluded items
print("\n24. Remove items in exclusion set:")
items = {1, 2, 3, 4, 5, 6, 7, 8}
exclude = {2, 4, 6}
result = items - exclude
print(f"After excluding: {result}")

# Example 25: Frequency counting unique
print("\n25. Count unique items and frequency:")
purchases = ["apple", "banana", "apple", "orange", "banana", "apple"]
unique_items = set(purchases)
freq_count = {item: purchases.count(item) for item in unique_items}
print(f"Purchase frequency: {freq_count}")
print(f"Most purchased: {max(freq_count, key=freq_count.get)}")

print("\n" + "="*80)
print("END OF SETS EXAMPLES")
print("="*80)
