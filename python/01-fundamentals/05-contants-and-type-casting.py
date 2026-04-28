"""
Constants and Type Casting - Practical Examples
All examples from 05-contants-and-type-casting.md in executable form
"""

import json
import ast
from decimal import Decimal, ROUND_HALF_UP
from enum import Enum
from datetime import datetime
from pathlib import Path

# ============================================================================
# 1. DEFINING CONSTANTS
# ============================================================================
print("\n=== DEFINING CONSTANTS ===")

# Mathematical constants
PI = 3.14159
E = 2.71828

# Application constants
APP_NAME = "MyApp"
APP_VERSION = "1.0.0"
DEBUG_MODE = False

# Database constants
DB_HOST = "localhost"
DB_PORT = 5432
DB_NAME = "myapp"

# Limits and thresholds
MAX_USERS = 100
MIN_PASSWORD_LENGTH = 8
MAX_FILE_SIZE = 10 * 1024 * 1024  # 10 MB
TIMEOUT_SECONDS = 30

print(f"App: {APP_NAME} v{APP_VERSION}")
print(f"Database: {DB_HOST}:{DB_PORT}")
print(f"Max users: {MAX_USERS}")


# ============================================================================
# 2. ENUM FOR CONSTANTS
# ============================================================================
print("\n=== ENUM FOR CONSTANTS ===")

class Status(Enum):
    """Status constants"""
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

current_status = Status.ACTIVE
task_priority = Priority.HIGH

print(f"Current status: {current_status.name} = {current_status.value}")
print(f"Task priority: {task_priority.name} = {task_priority.value}")

if current_status == Status.ACTIVE:
    print("System is active")

# Iterate through constants
print("\nAll statuses:")
for status in Status:
    print(f"  {status.name}: {status.value}")


# ============================================================================
# 3. CASTING TO INTEGER
# ============================================================================
print("\n=== TYPE CASTING TO INTEGER ===")

# From string
string_num = "42"
number = int(string_num)
print(f"int('{string_num}'): {number}")

# With spaces
number = int("  100  ")
print(f"int('  100  '): {number}")

# With sign
number = int("-50")
print(f"int('-50'): {number}")

# Different bases
binary = int("1010", 2)
print(f"int('1010', 2): {binary}")

octal = int("77", 8)
print(f"int('77', 8): {octal}")

hexadecimal = int("FF", 16)
print(f"int('FF', 16): {hexadecimal}")

# From float (truncates)
number = int(3.7)
print(f"int(3.7): {number}")

number = int(3.1)
print(f"int(3.1): {number}")

# From boolean
print(f"int(True): {int(True)}")
print(f"int(False): {int(False)}")


# ============================================================================
# 4. CASTING TO FLOAT
# ============================================================================
print("\n=== TYPE CASTING TO FLOAT ===")

# From string
float_num = float("3.14")
print(f"float('3.14'): {float_num}")

# From integer
float_num = float(42)
print(f"float(42): {float_num}")

# Scientific notation
float_num = float("1.5e-3")
print(f"float('1.5e-3'): {float_num}")

float_num = float("2.5e2")
print(f"float('2.5e2'): {float_num}")

# Special values
float_num = float("inf")
print(f"float('inf'): {float_num}")

float_num = float("-inf")
print(f"float('-inf'): {float_num}")

float_num = float("nan")
print(f"float('nan'): {float_num}")

# From boolean
print(f"float(True): {float(True)}")
print(f"float(False): {float(False)}")


# ============================================================================
# 5. FLOAT PRECISION WITH DECIMAL
# ============================================================================
print("\n=== FLOAT PRECISION ===")

# Regular float (precision issues)
print(f"0.1 + 0.2 = {0.1 + 0.2}")
print(f"0.1 + 0.2 == 0.3: {0.1 + 0.2 == 0.3}")

# Decimal (precise)
result = Decimal('0.1') + Decimal('0.2')
print(f"Decimal('0.1') + Decimal('0.2') = {result}")

# Currency example
price = Decimal('19.99')
quantity = 3
total = price * quantity
print(f"{quantity} × ${price} = ${total}")


# ============================================================================
# 6. CASTING TO STRING
# ============================================================================
print("\n=== TYPE CASTING TO STRING ===")

# From integer
string_num = str(42)
print(f"str(42): '{string_num}'")

# From float
string_num = str(3.14159)
print(f"str(3.14159): '{string_num}'")

# From boolean
print(f"str(True): '{str(True)}'")
print(f"str(False): '{str(False)}'")

# From collection
list_data = [1, 2, 3]
print(f"str([1, 2, 3]): '{str(list_data)}'")

dict_data = {"name": "Alice", "age": 25}
print(f"str(dict): '{str(dict_data)}'")

# From None
print(f"str(None): '{str(None)}'")

# Concatenation requires string
result = "Age: " + str(25)
print(f"Concatenation: '{result}'")


# ============================================================================
# 7. CUSTOM STRING REPRESENTATION
# ============================================================================
print("\n=== CUSTOM STRING REPRESENTATION ===")

class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def __str__(self):
        return f"{self.name} ({self.age} years old)"
    
    def __repr__(self):
        return f"Person('{self.name}', {self.age})"

person = Person("Alice", 30)
print(f"str(person): '{str(person)}'")
print(f"repr(person): '{repr(person)}'")


# ============================================================================
# 8. CASTING TO BOOLEAN
# ============================================================================
print("\n=== TYPE CASTING TO BOOLEAN ===")

# From integer
print(f"bool(0): {bool(0)}")
print(f"bool(1): {bool(1)}")
print(f"bool(-1): {bool(-1)}")
print(f"bool(42): {bool(42)}")

# From string
print(f"bool(''): {bool('')}")           # False
print(f"bool('0'): {bool('0')}")         # True (non-empty string!)
print(f"bool('False'): {bool('False')}")  # True (non-empty string!)
print(f"bool('Hello'): {bool('Hello')}")  # True

# From collection
print(f"bool([]): {bool([])}")           # False
print(f"bool([1, 2]): {bool([1, 2])}")   # True
print(f"bool({{}})): {bool({})}")        # False
print(f"bool({{'a': 1}}}): {bool({'a': 1})}")  # True

# From None
print(f"bool(None): {bool(None)}")       # False


# ============================================================================
# 9. PRACTICAL BOOLEAN CASTING
# ============================================================================
print("\n=== PRACTICAL BOOLEAN CASTING ===")

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


# ============================================================================
# 10. CONVERTING BETWEEN COLLECTIONS
# ============================================================================
print("\n=== CONVERTING BETWEEN COLLECTIONS ===")

# List to Tuple
list_data = [1, 2, 3]
tuple_data = tuple(list_data)
print(f"tuple([1, 2, 3]): {tuple_data}")

# Tuple to List
tuple_data = (1, 2, 3)
list_data = list(tuple_data)
print(f"list((1, 2, 3)): {list_data}")

# List to Set (removes duplicates)
list_data = [1, 2, 2, 3, 3, 3]
set_data = set(list_data)
print(f"set([1, 2, 2, 3, 3, 3]): {set_data}")

# String to List (characters)
text = "Hello"
char_list = list(text)
print(f"list('Hello'): {char_list}")

# List of characters to String
char_list = ['H', 'e', 'l', 'l', 'o']
text = ''.join(char_list)
print(f"''.join({char_list}): '{text}'")


# ============================================================================
# 11. CONVERTING BYTES
# ============================================================================
print("\n=== CONVERTING BYTES ===")

# String to Bytes
text = "Hello"
bytes_data = text.encode()
print(f"'Hello'.encode(): {bytes_data}")

# Bytes to String
bytes_data = b'Hello'
text = bytes_data.decode()
print(f"b'Hello'.decode(): '{text}'")

# Integer to Bytes
number = 255
bytes_data = bytes([number])
print(f"bytes([255]): {bytes_data}")

# Bytearray (mutable)
bytes_data = bytearray([72, 101, 108, 108, 111])
print(f"bytearray: {bytes_data}")
bytes_data[0] = 74
print(f"After modification: {bytes_data}")


# ============================================================================
# 12. SAFE LITERAL EVALUATION
# ============================================================================
print("\n=== SAFE LITERAL EVALUATION ===")

# String to actual list
string_list = "[1, 2, 3]"
actual_list = ast.literal_eval(string_list)
print(f"ast.literal_eval('[1, 2, 3]'): {actual_list}")

# String to dictionary
string_dict = "{'name': 'Alice', 'age': 25}"
actual_dict = ast.literal_eval(string_dict)
print(f"ast.literal_eval(dict): {actual_dict}")

# String to tuple
string_tuple = "(1, 2, 3)"
actual_tuple = ast.literal_eval(string_tuple)
print(f"ast.literal_eval(tuple): {actual_tuple}")


# ============================================================================
# 13. JSON CONVERSION
# ============================================================================
print("\n=== JSON CONVERSION ===")

# Dictionary to JSON
data = {"name": "Alice", "age": 25, "skills": ["Python", "SQL"]}
json_string = json.dumps(data)
print(f"json.dumps(dict): {json_string}")

# JSON to Dictionary
json_string = '{"name": "Bob", "age": 30}'
data = json.loads(json_string)
print(f"json.loads(json_str): {data}")

# Pretty JSON
pretty_json = json.dumps(data, indent=2)
print(f"Pretty JSON:\n{pretty_json}")


# ============================================================================
# 14. ERROR HANDLING FOR TYPE CASTING
# ============================================================================
print("\n=== ERROR HANDLING ===")

def safe_int(value, default=0):
    """Safely convert to int with default"""
    try:
        return int(value)
    except (ValueError, TypeError):
        return default

def safe_float(value, default=0.0):
    """Safely convert to float with default"""
    try:
        return float(value)
    except (ValueError, TypeError):
        return default

def safe_bool(value, default=False):
    """Safely convert to bool with default"""
    try:
        if isinstance(value, str):
            return value.lower() in ['true', 'yes', '1']
        return bool(value)
    except:
        return default

print(f"safe_int('42'): {safe_int('42')}")
print(f"safe_int('abc'): {safe_int('abc')}")
print(f"safe_float('3.14'): {safe_float('3.14')}")
print(f"safe_bool('true'): {safe_bool('true')}")
print(f"safe_bool('false'): {safe_bool('false')}")


# ============================================================================
# 15. TYPE VALIDATION
# ============================================================================
print("\n=== TYPE VALIDATION ===")

from collections.abc import Iterable
import numbers

# Check if numeric
value = 42
if isinstance(value, numbers.Number):
    print(f"{value} is numeric")

# Check if iterable
value = [1, 2, 3]
if isinstance(value, Iterable):
    print(f"{value} is iterable")

# Check type before conversion
value = "42"
if isinstance(value, str):
    try:
        number = int(value)
        print(f"Successfully converted '{value}' to {number}")
    except ValueError:
        print(f"Cannot convert '{value}' to int")


# ============================================================================
# 16. EXAMPLE 1: USER REGISTRATION
# ============================================================================
print("\n=== Example 1: User Registration ===")

class UserRegistration:
    """Handle user registration"""
    
    MIN_AGE = 18
    MAX_AGE = 120
    MIN_PASSWORD_LENGTH = 8
    
    @staticmethod
    def validate_and_convert(username, age_str, password):
        """Validate and convert inputs"""
        
        if not isinstance(username, str) or len(username) < 3:
            raise ValueError("Username must be at least 3 characters")
        
        try:
            age = int(age_str)
        except ValueError:
            raise ValueError("Age must be a valid number")
        
        if not (UserRegistration.MIN_AGE <= age <= UserRegistration.MAX_AGE):
            raise ValueError(f"Age must be between {UserRegistration.MIN_AGE} and {UserRegistration.MAX_AGE}")
        
        if len(password) < UserRegistration.MIN_PASSWORD_LENGTH:
            raise ValueError(f"Password must be at least {UserRegistration.MIN_PASSWORD_LENGTH} characters")
        
        return username, age, password

try:
    username, age, password = UserRegistration.validate_and_convert("alice_123", "25", "secure_pass_123")
    print(f"✓ Registration successful: {username}, Age: {age}")
except ValueError as e:
    print(f"✗ Registration error: {e}")

try:
    username, age, password = UserRegistration.validate_and_convert("bob", "200", "pass")
except ValueError as e:
    print(f"✗ Error: {e}")


# ============================================================================
# 17. EXAMPLE 2: DATA TYPE CONVERSION PIPELINE
# ============================================================================
print("\n=== Example 2: Data Conversion Pipeline ===")

class DataConverter:
    """Convert different data types"""
    
    @staticmethod
    def normalize_phone(phone_input):
        """Normalize phone number"""
        phone_str = str(phone_input)
        phone_clean = ''.join(c for c in phone_str if c.isdigit())
        
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

phone = DataConverter.normalize_phone(9876543210)
print(f"Normalized phone: {phone}")

csv_row = "Alice,25,19.99,true"
types = [str, int, float, lambda x: x.lower() == 'true']
parsed = DataConverter.parse_csv_row(csv_row, types)
print(f"Parsed CSV: {parsed}")


# ============================================================================
# 18. EXAMPLE 3: CURRENCY CONVERSION
# ============================================================================
print("\n=== Example 3: Currency Conversion ===")

class CurrencyConverter:
    """Handle currency conversion"""
    
    EXCHANGE_RATES = {
        "USD_to_EUR": Decimal("0.92"),
        "USD_to_GBP": Decimal("0.73"),
        "USD_to_INR": Decimal("83.12")
    }
    
    @staticmethod
    def convert(amount, from_currency, to_currency):
        """Convert between currencies"""
        amount_decimal = Decimal(str(amount))
        
        rate_key = f"{from_currency}_to_{to_currency}"
        
        if rate_key not in CurrencyConverter.EXCHANGE_RATES:
            raise ValueError(f"Conversion not available: {rate_key}")
        
        rate = CurrencyConverter.EXCHANGE_RATES[rate_key]
        result = amount_decimal * rate
        
        return float(result.quantize(Decimal("0.01"), rounding=ROUND_HALF_UP))
    
    @staticmethod
    def format_currency(amount, currency="USD"):
        """Format as currency"""
        symbols = {
            "USD": "$",
            "EUR": "€",
            "GBP": "£",
            "INR": "₹"
        }
        
        symbol = symbols.get(currency, currency)
        amount_float = float(amount)
        return f"{symbol}{amount_float:.2f}"

amount_usd = 100
amount_eur = CurrencyConverter.convert(amount_usd, "USD", "EUR")
print(f"{amount_usd} USD = {CurrencyConverter.format_currency(amount_eur, 'EUR')}")

amount_inr = CurrencyConverter.convert(amount_usd, "USD", "INR")
print(f"{amount_usd} USD = {CurrencyConverter.format_currency(amount_inr, 'INR')}")


# ============================================================================
# 19. EXAMPLE 4: TYPE-SAFE DATA VALIDATOR
# ============================================================================
print("\n=== Example 4: Type-Safe Validator ===")

import re
from typing import Union

class TypeValidator:
    """Validate and convert data"""
    
    @staticmethod
    def validate_email(email: str) -> str:
        """Validate email format"""
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

try:
    email = TypeValidator.validate_email("user@example.com")
    print(f"✓ Valid email: {email}")
    
    percentage = TypeValidator.validate_range(75, 0, 100)
    print(f"✓ Valid percentage: {percentage}")
    
    password = TypeValidator.validate_length("secure123", 8, 20)
    print(f"✓ Valid password length")
except ValueError as e:
    print(f"✗ Validation error: {e}")


# ============================================================================
# 20. EXAMPLE 5: CONFIGURATION LOADER
# ============================================================================
print("\n=== Example 5: Configuration Loader ===")

class ConfigLoader:
    """Load and convert configuration"""
    
    DEFAULTS = {
        "host": "localhost",
        "port": 5432,
        "debug": False,
        "timeout": 30,
        "max_connections": 100
    }
    
    @staticmethod
    def load_config(config_dict):
        """Convert config values to proper types"""
        final_config = {}
        
        for key, default_value in ConfigLoader.DEFAULTS.items():
            value = config_dict.get(key, default_value)
            
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

# Simulated configuration
config_input = {
    "host": "192.168.1.1",
    "port": "3306",
    "debug": "true",
    "timeout": "60"
}

config = ConfigLoader.load_config(config_input)
print("Loaded Configuration:")
for key, value in config.items():
    print(f"  {key}: {value} ({type(value).__name__})")


print("\n=== End of Constants and Type Casting Examples ===")
