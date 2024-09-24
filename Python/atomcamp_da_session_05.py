# -*- coding: utf-8 -*-
"""atomcamp DA session -05.ipynb

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1f_3aj9khVU8miqrXIuHacODQLKgzWmRs

Functions
"""

l = (1, 2, 3, 4, 5)
# will only work for list or tuple
def list_sum(list):
  if type(list) not in [list, tuple]:
    print("not valid iterable")
  else:
    sum = 0
    for i in list:
      sum += i
    return sum
list_sum(l)


#list_sum("khola")

# *args converts infinite number of values into tuple for the function
# need * ..... args name can be changed.... can call it *iterable
def my_sum3(*args):
  sum = 0
  for i in args:
    sum += i
  return sum
# my_sum3()

my_sum3(1,2,3,4,5,5,6)

# also have quargs

"""exceptional handling"""

try:

  num = 5
  denom = 0

  div =  num / denom

except Exception:
  print("error,", "division by zero")

try:

  num = 5
  denom = 0

  div =  num / denom

except ZeroDivisionError:
  print("error,", "division by zero")

try:

  num = 5
  denom = 0

  div =  num / denom
  print(div)

except ZeroDivisionError:
  denom +=1

  div =  num / denom
  print(div)

finally:
  print("Program Ended")

"""List Comprehension"""

# one line for loop is called lsit comprehension

x = [1, 2, 3, 4, 5]
x2 = []
for i in x:
  x2.append(i**2)
print(x2)

x4 = [i**2 for i in x]
print(x4)

# dictionary comprehension

string = "python"


dict1 = {
    letter : letter.upper() for letter in string
}

print(dict1)

students = ["Hassan", "Rabbiya", "Bushra"]

marks = [60, 40, 90]

grades = {
    students[i] : marks[i] for i in range(len(students))
}

print(grades)

students = ["Hassan", "Rabbiya", "Bushra"]

marks = [60, 40, 90]


grade_x = {}

for i in range(len(students)):
  grades[students[i]] = marks[i]


print(grades)

dic = {i: j for i, j in zip(students, marks)}

print(dic)

# list comprehension using if else in it

list("python")

x = [i for i in "python"]
x

x = [i.upper() for i in "python" if i != "p"]
x

# adding else clause to the list comprehension
x = [i.upper() if i != "p" else "M" for i in "python"]
x

"""# coargs

"""

# coargs are used to design function that can use any number of key number arguments

# in case of coargs we use **coargs
# it stores value in form of dictionary {key1 : value, key2 : value}
def potential_energy(**kwargs):
  PE = (kwargs["m"] * kwargs["g"] * kwargs["h"])
  return (round(PE, 2))

potential_energy(m = 10, g = 9.81, h = 10)

# *args and **kwargs are used in function definitions to allow for a flexible number of arguments.

# *args (Arbitrary Arguments):
# - Used to pass a variable number of non-keyword arguments to a function.
# - The arguments are collected into a tuple within the function.
# - Useful when you don't know in advance how many arguments will be passed to the function.

# Example:
def my_function(*args):
  for arg in args:
    print(arg)

my_function(1, 2, 3, 4)  # Output: 1, 2, 3, 4


# **kwargs (Keyword Arguments):
# - Used to pass a variable number of keyword arguments to a function.
# - The arguments are collected into a dictionary within the function.
# - Useful when you want to pass named arguments to a function without knowing their exact names in advance.

# Example:
def my_function(**kwargs):
  for key, value in kwargs.items():
    print(key, value)

my_function(name="Alice", age=30, city="London")  # Output: name Alice, age 30, city London

# Key Differences:
# - *args collects positional arguments as a tuple, while **kwargs collects keyword arguments as a dictionary.
# - *args arguments are accessed by their position in the tuple, while **kwargs arguments are accessed by their key in the dictionary.
# - You can use both *args and **kwargs in the same function definition.


def my_function(*args, **kwargs):
  print("args:", args)
  print("kwargs:", kwargs)


my_function(1, 2, 3, name="Alice", age=30)



