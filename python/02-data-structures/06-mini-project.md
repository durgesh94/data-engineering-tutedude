# Mini Project: Student Enrollment System

## Project Introduction

This mini project combines the main Python data structures you have learned so far:

- **Tuple** for fixed course data
- **List** for student names
- **Dictionary** for student-course mapping
- **Set** for unique course collection

The project simulates a simple **student enrollment system** where students are enrolled in different courses and the program prints a summary of all enrollments.

This is a practical beginner-friendly project because it shows how different data structures work together in a real program.

---

## Project Goal

The goal of this project is to:

- store available courses
- store student names
- map each student to their enrolled courses
- add a new student dynamically
- collect all unique enrolled courses
- display a final summary

---

## Learning Objectives

After completing this mini project, you should understand how to:

- use a **tuple** for fixed values that should not change
- use a **list** for a collection that can grow or shrink
- use a **dictionary** to connect keys with values
- use a **set** to keep only unique values
- loop through dictionary values
- update collections dynamically
- combine multiple data structures in one meaningful project

---

## Full Project Code

```python
#student enrollment system
# ============================================================================
# 1. STUDENT ENROLLMENT SYSTEM
# ============================================================================
print("\n=== 1. STUDENT ENROLLMENT SYSTEM ===")

available_courses = ("Math", "Science", "History", "English")

students = ["Alice", "Bob", "Charlie"]

enrollments = {
	"Alice": ["Math", "Science"],
	"Bob": ["History"],
	"Charlie": ["English", "Science"]
}

unique_courses = set()

students.append("David")
enrollments["David"] = ["Math", "History"]

for courses in enrollments.values():
	unique_courses.update(courses)

print("\n=== 2. ENROLLMENT SUMMARY ===")
print("available_courses:", available_courses)
print(f"Total students enrolled: {len(students)}")
print(f"Enrolled students: {students}")
print(f"Student enrollments: {enrollments}")
print(f"Unique courses offered: {unique_courses}")
```

---

## Project Breakdown

### 1. Available Courses Using a Tuple

```python
available_courses = ("Math", "Science", "History", "English")
```

This tuple stores the list of courses offered.

### Why a tuple is used:

- course names are fixed in this example
- tuples are good for data that should not be changed accidentally
- tuples maintain order

### Meaning:

The system starts with four available courses:

- Math
- Science
- History
- English

---

### 2. Student Names Using a List

```python
students = ["Alice", "Bob", "Charlie"]
```

This list stores student names.

### Why a list is used:

- lists are mutable
- new students can be added later
- order of students is preserved

This is useful because enrollment systems often need to add or remove students over time.

---

### 3. Enrollments Using a Dictionary

```python
enrollments = {
	"Alice": ["Math", "Science"],
	"Bob": ["History"],
	"Charlie": ["English", "Science"]
}
```

This dictionary connects each student name to a list of courses.

### Why a dictionary is used:

- each **key** is a student name
- each **value** is a list of courses taken by that student
- dictionaries are ideal for fast lookup by key

### Example meaning:

- Alice is enrolled in Math and Science
- Bob is enrolled in History
- Charlie is enrolled in English and Science

---

### 4. Unique Courses Using a Set

```python
unique_courses = set()
```

This creates an empty set.

### Why a set is used:

- sets store only unique values
- duplicate course names are automatically removed
- useful for getting a final list of all different courses actually enrolled by students

For example, if multiple students take Science, the set will still keep only one `Science` value.

---

## Adding a New Student

```python
students.append("David")
enrollments["David"] = ["Math", "History"]
```

This part updates the system by adding a new student.

### What happens here:

1. `David` is added to the `students` list
2. a new dictionary entry is created for David
3. David is enrolled in Math and History

### Why this matters:

This demonstrates how lists and dictionaries can be updated dynamically while the program is running.

---

## Collecting Unique Courses

```python
for courses in enrollments.values():
	unique_courses.update(courses)
```

This loop collects all courses from all students and stores them in the set.

### Step-by-step explanation:

1. `enrollments.values()` gives only the dictionary values
2. each value is a list of courses for one student
3. `update(courses)` adds all course names from that list into the set
4. the set automatically ignores duplicates

### Example flow:

- Alice contributes `Math`, `Science`
- Bob contributes `History`
- Charlie contributes `English`, `Science`
- David contributes `Math`, `History`

Final unique set:

```python
{'Math', 'Science', 'History', 'English'}
```

The order may vary because sets are unordered.

---

## Printing the Summary

```python
print("available_courses:", available_courses)
print(f"Total students enrolled: {len(students)}")
print(f"Enrolled students: {students}")
print(f"Student enrollments: {enrollments}")
print(f"Unique courses offered: {unique_courses}")
```

This section prints a final report of the system.

### It displays:

- all available courses
- total number of students
- list of enrolled students
- complete enrollment mapping
- unique list of enrolled courses

---

## Expected Output

The exact order of the set may vary, but the output will look similar to this:

```python
=== 1. STUDENT ENROLLMENT SYSTEM ===

=== 2. ENROLLMENT SUMMARY ===
available_courses: ('Math', 'Science', 'History', 'English')
Total students enrolled: 4
Enrolled students: ['Alice', 'Bob', 'Charlie', 'David']
Student enrollments: {
	'Alice': ['Math', 'Science'],
	'Bob': ['History'],
	'Charlie': ['English', 'Science'],
	'David': ['Math', 'History']
}
Unique courses offered: {'Math', 'Science', 'History', 'English'}
```

---

## Concepts Used in This Project

This mini project uses multiple concepts together:

### Tuple Concepts

- tuple creation
- ordered fixed data
- immutable collection

### List Concepts

- list creation
- `append()` method
- dynamic updates
- `len()` function

### Dictionary Concepts

- key-value pairs
- accessing dictionary values
- adding new keys
- `values()` method

### Set Concepts

- creating an empty set
- `update()` method
- storing unique values
- automatic duplicate removal

### Loop Concepts

- `for` loop
- iterating through dictionary values

---

## Why This Project Is Important

This project is important because it shows how Python data structures are used together in a practical problem.

In real applications:

- tuples can store fixed configuration
- lists can store dynamic collections
- dictionaries can map relationships
- sets can remove duplicates and support fast membership checks

This combination appears often in backend systems, data processing tasks, student records, inventory tools, and analytics workflows.

---

## Real-World Use Cases

This same project idea can be extended into:

- a college course registration system
- an employee training enrollment system
- an online learning platform
- a workshop registration tracker
- a club membership and event enrollment system

---

## Possible Improvements

This project is simple, but it can be improved in many ways.

### Ideas for extension:

1. allow user input to add students
2. check whether selected courses exist in `available_courses`
3. prevent duplicate student names
4. show students enrolled in a specific course
5. count how many students are in each course
6. remove a student from the system
7. print a better formatted report

---

## Practice Tasks

Try these exercises yourself:

1. Add a new course called `Computer Science`
2. Add two more students and assign them courses
3. Print only students taking `Science`
4. Count total enrollments across all students
5. Find which course has the highest number of students

---

## Summary

This mini project demonstrates how to build a simple student enrollment system using core Python data structures.

- **Tuple** stores fixed available courses
- **List** stores student names
- **Dictionary** stores student-course enrollments
- **Set** stores unique enrolled courses

It is a strong beginner project because it connects multiple concepts into one useful program and helps build confidence in using Python data structures together.
