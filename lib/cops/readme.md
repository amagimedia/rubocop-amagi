# Amagi Rubocop CustomCop Rules

## How to use CustomCops?
***
**Using any cop**
---
Open .rubocop.yml in your working directory and set the enabled option as true.
~~~ruby
CustomCop/Copname: 
  Enabled: true
~~~
### PutLoggerFormatCop
PutLoggerFormatCop ensures that the message format received on encountering **puts** is of the standard format 
~~~ruby
"<module/class>#method_name:<space><message>". 
~~~
Enabling the cop inside .rubocop.yml :
~~~ruby
CustomCop/PutLoggerFormatCop:
  Enabled: true
~~~

### DuplicateConstantCop
DuplicateConstantCop ensures that there is no two constants in a file which has same string value

#### Reason to add this cop
if we have a same value for two constants and we try to fetch constant name using its value which ends in picking up the same constant always ignoring the other one. 

~~~ruby
 # not allowed
 TEST = "abc"
 TEST1 = "abc"
~~~

~~~ruby
 # allowed
 TEST = "abc"
 TEST1 = "abcd"
~~~

~~~ruby
 # allowed
 TEST = 10
 TEST1 = 10
~~~

~~~ruby
 # allowed
 TEST = ["abc", "def"]
 TEST1 = ["abc", "def"]
~~~

Enabled by default

to disable it add the following lines in .rubocop.yml of your repo:
~~~ruby
CustomCop/DuplicateConstantCop:
  Enabled: false
~~~
