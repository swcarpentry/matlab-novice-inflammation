---
title: Working With Variables
teaching: 60
exercises: 5
questions:
- "How can I store values and do simple calculations with them?"
objectives:
- "Navigate among important sections of the MATLAB environment."
- "Assign values to variables."
- "Identify what type of data is stored in MATLAB arrays."
- "Read tabular data from a file into a program."
keypoints:
- "MATLAB stores data in arrays."
- "Use `readmatrix` to read tabular CSV data into a program."
---



## Introduction to the MATLAB GUI
Before we can start programming, we need to know a little about the MATLAB interface.
Using the default setup, the MATLAB desktop contains several important sections:

* In the **Command Window** we can execute commands.
Commands are typed after the prompt `>>` and are executed immediately after pressing <kbd>Enter</kbd>.
* Alternatively, we can open the **Editor**, write our code and run it all at once.
The advantage of this is that
we can save our code and run it again in the same way at a later stage.
* The **Workspace** contains all the variables which we have loaded into memory.
* The **Current Folder** window shows files in the current directory,
  and we can change the current folder using this window.
* **Search Documentation** on the top right of your screen lets you search for functions.
Suggestions for functions that would do what you want to do will pop up.
Clicking on them will open the documentation.
Another way to access the documentation is via the `help` command --- we will return to this later.

## Working with variables
In this lesson we will learn how to manipulate the inflammation dataset with MATLAB.
But before we discuss how to deal with many data points,
we will show how to store a single value on the computer.

We can create a new [variable]({{ page.root }}/reference.html#variable) by assigning a value to it using `=`:

~~~
>> weight_kg = 55;
~~~
{: .language-matlab}

At first glance nothing appears to have happened!
We don't get any output in the command window because we put a semi-colon after the variable assignment:
this suppresses output, which is generally a good thing because it makes code run more quickly.
Let's run the command again without the semi-colon, and this time we have some output in the command window:

~~~
>> weight_kg = 55
~~~
{: .language-matlab}

```
weight_kg =
    55
```
{: .output}

A variable is just a name for a piece of data or *value*.
Variable names must begin with a letter, and are case sensitive.
They can contain also numbers or underscores. Examples of valid variable names are
`x`, `f_0` or `current_temperature`.

Once a variable has a value, we can print it using the `disp` function:

~~~
>> disp(weight_kg)
~~~
{: .language-matlab}

~~~
    55
~~~
{: .output}

or simply typing its name, followed by <kbd>Enter</kbd>

```
>> weight_kg
```
{: .language-matlab}

```
weight_kg =
    55
```
{: .output}


Storing single values is fine, but how can we store multiple values in the same variable?
We can create an array using square brackets, separating each value with a comma:

```
>> a = [1, 2, 3]
```
{: .language-matlab}

```
a =
     1     2     3
```
{: .output}

In a similar way, we can create matrices using semi-colons to separate rows:

```
>> b = [a; 4, 5, 6]
``` 
{: .language-matlab}


```
b =
     1     2     3
     4     5     6
```
{: .output}

Something to bear in mind about arrays and matrices is that all values in an array
must be of the same type e.g. all numbers or all strings.
It is however possible to convert between data types e.g. `num2str` which converts
numbers to a string representation.

```
>> num2str(a)
ans =
    '1  2  3'
```
{: .language-matlab}

So once we have a numeric value stored in a variable, we can do arithmetic with it:

~~~
>> weight_lb = 2.2 * weight_kg;
>> disp(['Weight in pounds: ', num2str(weight_lb)])
~~~
{: .language-matlab}

~~~
Weight in pounds: 121
~~~
{: .output}

That last command combines several new concepts,
so let's break it down:

The `disp` function takes a single argument --- the value to print.
So if we want to print more than one value on a single line,
we can print an *array* of values (i.e. one argument),
which we create using square brackets,
and recall that an array must contain values all of the same type.
In this case we convert the number to a string so that we
can print an array of characters.

We can change the value of a variable by assigning it a new one:
~~~
>> weight_kg = 57.5
~~~
{: .language-matlab}

~~~
weight_kg =
    57.5
~~~
{: .output}

Assigning a value to one variable does not change the values of other
variables.

For example, we just changed the value of `weight_kg` from 55 to 57.5,
but `weight_lb` hasn't changed:

~~~
>> weight_lb
~~~
{: .language-matlab}

~~~
weight_lb =
    121
~~~
{: .output}

Since `weight_lb` doesn't "remember" where its value came from, it isn't
automatically updated when `weight_kg` changes. This is important to
remember, and different from the way spreadsheets work.

Now that we know how to assign values to variables, let's
view a list of all the variables in our workspace:

~~~
>> who
~~~
{: .language-matlab}

~~~
Your variables are:

a  b  weight_kg  weight_lb
~~~
{: .output}

To remove a variable from MATLAB, use the `clear` command:

~~~
>> clear weight_lb
>> who
~~~
{: .language-matlab}


~~~
Your variables are:

a  b  weight_kg
~~~
{: .output}

Alternatively, we can look at the **Workspace**.
The workspace contains all variable names and assigned values that we currently work with.
As long as they pop up in the workspace,
they are universally available.
It's generally a good idea to keep the workspace as clean as possible.
To remove all variables from the workspace, execute the command `clear` on its own.

> ## Predicting Variable Values
>
> Predict what variables refer to what values after each statement in the following program:
>
> ~~~
> >> mass = 47.5
> >> age = 122
> >> mass = mass * 2.0
> >> age = age - 20
> ~~~
> {: .language-matlab}
>
> > ## Solution
> > The first two lines assign the initial values to the variables, so mass = 47.5 and age = 122.
> > The next line evaluates `mass * 2.0` i.e. `47.5 * 2.0 = 95`,
> > *then* assigns the result to the variable `mass`. 
> > The last line evaulates `age - 20` i.e. `122 - 20`, *then* assigns the result to the variable `age`.
> > So the final values are mass = 95, and age = 102.
> >
> > The key point to understand here is that the expression to the right of the `=` sign is evaluated first,
> > and the result is then assigned to the variable specified to the left of the `=` sign.
> {: .solution}
{: .challenge}


## Good practices for project organisation
Before we get started, let's create some directories to help organise this project.

> ## Tip: Good Enough Practices for Scientific Computing
>
> [Good Enough Practices for Scientific Computing](https://swcarpentry.github.io/good-enough-practices-in-scientific-computing/)
> gives the following recommendations for project organization:
>
> 1. Put each project in its own directory, which is named after the project.
> 2. Put text documents associated with the project in the `doc` directory.
> 3. Put raw data and metadata in the `data` directory, and files generated during clean-up and analysis in a `results` directory.
> 4. Put source code for the project in the `src` directory,
>    and programs brought in from elsewhere or compiled locally in the `bin` directory.
> 5. Name all files to reflect their content or function.
>
{: .callout}

We already have a `data` directory in our `matlab-novice-inflammation` project directory,
so we only need to create a `results` directory for this project.
You can use your computer's file browser to create this directory.
We'll save all our scripts and function files in the main project directory.

A final step is to set the *current folder* in MATLAB to our project folder.
Use the **Current Folder** window in the MATLAB GUI to browse to your project folder
(`matlab-novice-inflammation`).

In order to check the current directory, we can run `pwd` (print working directory).
A second check we can do is to run the `ls` (list) command in the Command Window to list the contents
of the working directory ---
we should get the following output:

```
data   results
```
{: .language-matlab}



Reading data from files and writing data to them
are essential tasks in scientific computing,
and admittedly,
something that we'd rather not spend a lot of time thinking about.
Fortunately, MATLAB comes with a number of high-level tools to do these things efficiently,
sparing us the grisly detail.

If we know what our data looks like (in this case, we have comma-separated values)
and we're unsure about what command we want to use,
we can search the documentation.
Type `read matrix` into the documentation toolbar.
MATLAB suggests using `readmatrix`.
If we have a closer look at the documentation,
MATLAB also tells us, which in- and output arguments this function has.

To load the data from our CSV file into MATLAB, type the following
command into the MATLAB command window, and press <kbd>Enter</kbd>:

~~~
>> patient_data = readmatrix('data/inflammation-01.csv');
~~~
{: .language-matlab}

This loads the data and assigns it to a variable, *patient_data*.
This is a good example of when to use a semi-colon to suppress output ---
try re-running the command without the semi-colon to find out why.
You should see a wall of numbers printed, which is the data from the file.

~~~
>> patient_data = readmatrix('data/inflammation-01.csv')
~~~
{: .language-matlab}

The expression `readmatrix(...)` is a
[function call]({{ page.root }}/reference.html#function-call).
Functions generally need [arguments]({{ page.root }}/reference.html#argument)
to run.
In the case of the `readmatrix` function, we need to provide a single
argument: the name of the file we want to read data from. This
argument needs to be a character string or
[string]({{ page.root }}/reference.html#string), so we put it in quotes.


Now that our data is in memory, we can start doing things with it.
First, let's find out its [size]({{ page.root }}/reference.html#size):

~~~
>> size(patient_data)
~~~
{: .language-matlab}

~~~
ans =

    60 40
~~~
{: .output}

The output tells us that the variable `patient_data`
refers to a table of values
that has 60 rows and 40 columns.

MATLAB stores *all* data in the form of multi-dimensional arrays. For example:

* Numbers, or *scalars* are represented as two dimensional arrays with only one row and one column, as are single characters. 
* Lists of numbers, or *vectors* are two dimensional as well, but the value of one of the dimensions equals one.
  By default vectors are row vectors, meaning they have one row and as many columns as there are elements in the vector.
* Tables of numbers, or *matrices* are arrays with more than one column and more than one row.
* Even character strings, like sentences, are stored as an "array
of characters".

Normally, MATLAB arrays can't store elements of different data types. For
instance, a MATLAB array can't store both a `float` and a `char`. To do that,
you have to use a [Cell Array](http://www.mathworks.com/help/matlab/cell-arrays.html).

We can use the `class` function to find out what type of data lives
inside an array:

~~~
>> class(patient_data)
~~~
{: .language-matlab}

~~~
ans =
    'double'
~~~
{: .output}

This output tells us that `patient_data` refers to an array of
double precision floating-point numbers. This is the default numeric
data type in MATLAB. If you want to store other numeric data types,
you need to tell MATLAB explicitly. For example, the command,

~~~
>> x = int16(325);
~~~
{: .language-matlab}


assigns the value `325` to the name `x`, storing it as a 16-bit signed
integer.
