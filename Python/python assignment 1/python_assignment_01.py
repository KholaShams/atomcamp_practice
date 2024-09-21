# -*- coding: utf-8 -*-
"""python assignment-01

Automatically generated by Colab.

Original file is located at
    https://colab.research.google.com/drive/1hcYBHsuKGBWPIEzEry3RKWBsme3IIL-g

# Assignment - 1: Python Basics

##Instructions:
1. Complete the following tasks based on the concepts covered in the &quot;Python Basics&quot; session. Write
your Python code using Google Colab Notebook to solve the problems.
2. Ensure that your code is well-commented, and variable names are descriptive.
3. If any task requires output, print the result to the console.
4. Submit the completed Notebook as .ipynb file.

## **Task 1**: Variables and Data Types
1. Create three variables: one for storing your age (integer), one for your
name (string), and one to
check if you are a student (Boolean). Print the variables.
2.  Perform the following operations and print the results:
- Add 25 to your age variable.
- Concatenate your name with the string &quot;Smith.&quot;
- Negate the Boolean variable (if True, make it False, and vice versa).
"""

# creating variables and assigning them values
age = 25
name =  "Smith"
student = True

# printing the values
print(f" age : {age}\n",
      f"Name : {name}\n",
      f"Student : {student}")

# b) Performing operations
age_plus_25 = age + 25  # Adding 25 to age
print(f"Age + 25: {age_plus_25}")

name_with_surname = "Khola " + name  # Concatenating name with "Smith"
print(f"Name with surname: {name_with_surname}")

student = not(student)  # Negating the boolean value
print(f"Negated student status: {student}")

"""## **Task 2**: Expressions and Operators
1.  A rectangle has a width of 5.5 units and a height of 3.25 units. Store width and height in variables.
Create a new variable called area and write an expression to calculate the area. Print the area in the
output.
2.  Take temperature input from user in Celsius. Convert it to Fahrenheit using the formula:
F = (C * 9/5) + 32
Store this temperature in a variable called Fahrenheit and print this variable.
3. Take radius of the circle as input from user. Calculate the area of a circle with this radius and store
it in a variable called area. Print area at the end of your code.
(Use the formula: area = π * radius^2, where π (pi) is approximately 3.14159).
"""

# part 1
width = 5.5
height = 3.25
area = width * height
print(f"The area of rectangle with width : {width} units and height : {height} units is {area} unit^2")

# part 2
temp_celcius = eval(input("Enter the temperature in celcius: "))

fahrenheit = (temp_celcius * (9/5)) + 32

print(f"the temperature in celcius {temp_celcius}C is equals to {fahrenheit}F in Fahrenheit")

# part 3

import math as m
radius = eval(input("Enter the radius of the circle: "))
area = round(m.pi * radius*2, 2)
print (area)

"""## **Task 3**: List Manipulation
a) Create a list called &quot;fruits&quot; containing the following fruits: &quot;apple&quot;, &quot;banana&quot;, &quot;cherry&quot;, &quot;date&quot;,
&quot;strawberry&quot;, &quot;fig&quot;, and &quot;grape&quot;. Print the list.
1. Remove the first and last elements from the &quot;fruits&quot; list. Print the updated list.
2. Replace the second to fourth items with [&quot;kiwi&quot;, &quot;lemon&quot;, &quot;mango&quot;] using list slicing.

3. Use the len() function to find how many fruits are in the list.
"""

fruits = ["apple", "banana", "cherry", "date", "strawberry", "fig", "grape"]
print(fruits)

# part 1
fruits[1:-1]
fruits.pop(0)
fruits.pop(-1)

print(f"Here is the update list after removing the first and last elements from it:\n{fruits}")

# part 2
fruits[1:4] =  ["kiwi", "lemon", "mango"]

print(fruits)

# part 3
print(f"The total number of fruits in the list called fruits are:  {len(fruits)}")

"""## **Task 4**: Dictionary Operations
1.  Create a dictionary named &quot;capitals&quot; with three key-value pairs: &quot;USA&quot; - &quot;Washington D.C.,&quot;
&quot;France&quot; - &quot;Paris,&quot; and &quot;Japan&quot; - &quot;Tokyo.&quot; Print the dictionary.
2.  Add a new country and its capital to the &quot;capitals&quot; dictionary. The country is &quot;Germany,&quot; and the
capital is &quot;Berlin.&quot; Print the updated dictionary.
3.  Check if &quot;France&quot; exists in the &quot;capitals&quot; dictionary. If it does, print &quot;France is in the dictionary,&quot;
otherwise, print &quot;France is not in the dictionary.&quot;
"""

#part 1
capitals ={
    "USA" : "Washington D.c",
    "France" : "Paris",
    "Japan" : "Tokyo"
}
print(capitals)

# part 2
capitals["Germany"] = "Berlin"

print(capitals)

# part 3
if "France" in capitals:
  print("France is in the dictionary")
else:
  print("France is not in the dictionary")

"""## **Task 5:** Comparison Operators, Logical Operators and If/Else:
1. Create a variable called number that takes user input. Write a block of code that checks if the
number is positive or negative. If the number is positive only then further check if it is even or odd.
Your output should print “The number is even”, or the “The number is odd”.
2.  Create two variables called age and GPA. Give them values of your choice. Next, write a block of
code to check if a student with this age and GPA is eligible for admission. The following are the
conditions:
- The student must be at least 18 years old.
- The student&#39;s GPA must be 3.0 or higher on a scale of 4.0.
Your output should print “Eligible for admission” or “Not eligible for admission”.
"""

# part 1

number = int(input("Enter a number of your choice: "))

if (number > 0):
  if (number % 2 == 0):
    print(f"The number {number} is EVEN")
  else:
    print(f"The number {number} is ODD")
elif (number == 0):
  print("Number is 0")
else:
  print("the number is negative")

# part 2
age = 22
gpa = 3.5

if (age >= 18 and (gpa >= 3.0 and gpa <= 4.0)):
  print("Eligible for admission")
else:
  print("Not eligible for admission")

"""## **Task 6**: Strings Manipulation
1.  Create a string variable containing the following sentence:
&quot;Python programming is fun and powerful!&quot;
Write Python code to do the following and print the results:
- Find the length of the string.
- Convert the string to uppercase.
- Replace &quot;fun&quot; with &quot;exciting.&quot;
- Check if the string contains the word &quot;Python.&quot;
- Extract the last word &quot;powerful!&quot;
- Remove the word programming from the sentence and print the rest of the sentence.
2.  Given the string email = &quot;user@example.com&quot;, perform the following:
- Extract the username part (everything before the &quot;@&quot; symbol).
- Extract the domain part (everything after the &quot;@&quot; symbol).
- Check if the email contains the substring &quot;example&quot;.
"""

# part 1
sentence =  "Python programming is fun and powerful!"

# find length of the string
print(len(sentence))

# convert string to uppercase
print(f"uppercase :\n{sentence.upper()}")

# replace fun with exciting
print(sentence.replace("fun", "exciting"))

# Check if the string contains the word "Python."
print("Python" in sentence)

# Extract the last word "powerful!"

print(sentence.split()[-1])

# Remove the word programming from the sentence and print the rest of the sentence.
print(sentence.replace("programming", ''))

# part 2
email = "user@example.com"

# Extract the username part (everything before the "@" symbol).
email.split("@")[0]

# Extract the domain part (everything after the "@" symbol).
email.split("@")[-1]

# Check if the email contains the substring "example".
print("example" in email)