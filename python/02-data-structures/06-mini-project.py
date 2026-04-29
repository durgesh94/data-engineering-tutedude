#student enrollment system
# ============================================================================
# 1. STUDENT ENROLLMENT SYSTEM
# ============================================================================
print("\n=== 1. STUDENT ENROLLMENT SYSTEM ===")

available_courses = ("Math", "Science", "History", "English") # Tuple of available courses: immutable and ordered collection 

students = ["Alice", "Bob", "Charlie"] # List to store enrolled students: mutable and ordered collection

enrollments = {
  "Alice": ["Math", "Science"],
  "Bob": ["History"],
  "Charlie": ["English", "Science"]
} # Dictionary to store student enrollments: mutable and unordered collection of key-value pairs in which keys are student names and values are lists of enrolled courses

unique_courses = set() # Set to store unique courses: mutable and unordered collection of unique items

students.append("David") # Enroll a new student by adding to the list
enrollments["David"] = ["Math", "History"] # Enroll the new student in courses

for courses in enrollments.values():
  unique_courses.update(courses) # Update the set with courses from each student's enrollment

print("\n=== 2. ENROLLMENT SUMMARY ===")
# print available courses
print("available_courses:", available_courses)
# print enrolled students 
print(f"Total students enrolled: {len(students)}")
print(f"Enrolled students: {students}")
# print student enrollments
print(f"Student enrollments: {enrollments}")
# print unique courses offered
print(f"Unique courses offered: {unique_courses}")
