---
title: Analyzing Patient Data
teaching: 30
exercises: 0
questions:
- "How can I process and visualize my data?"
objectives:
- "Get to know the MATLAB environment."
- "Learn about MATLAB arrays."
- "Read tabular data from a file into a program."
- "Assign values to variables."
- "Select individual values and subsections from data."
- "Perform operations on arrays of data."
- "Display simple graphs."
keypoints:
- "MATLAB stores data in arrays."
- "Use `csvread` to read tabular CSV data into a program."
- "Use `plot` to visualize data."
---

We are studying inflammation in patients who have been given a new treatment for arthritis,
and need to analyze the first dozen data sets.
The data sets are stored in
[Comma Separated Values (CSV)](reference.html#comma-separated-values) format:
each row holds the information for a single patient,
each column represents the inflammation in successive days.
The first few rows of our first file,
[`inflammation-01.csv`](data/inflammation-01.csv), look like this:

~~~
0,0,1,3,1,2,4,7,8,3,3,3,10,5,7,4,7,7,12,18,6,13,11,11,7,7,4,6,8,8,4,4,5,7,3,4,2,3,0,0
0,1,2,1,2,1,3,2,2,6,10,11,5,9,4,4,7,16,8,6,18,4,12,5,12,7,11,5,11,3,3,5,4,4,5,5,1,1,0,1
0,1,1,3,3,2,6,2,5,9,5,7,4,5,4,15,5,11,9,10,19,14,12,17,7,12,11,7,4,2,10,5,4,2,2,3,2,2,1,1
0,0,2,0,4,2,2,1,6,7,10,7,9,13,8,8,15,10,10,7,17,4,4,7,6,15,6,4,9,11,3,5,6,3,3,4,2,3,2,1
0,1,1,3,3,1,3,5,2,4,4,7,6,5,3,10,8,10,6,17,9,14,9,7,13,9,12,6,7,7,9,6,3,2,2,4,2,0,1,1
~~~
{: .source}

We want to:

* load that data into memory,
* calculate different statistics for all patients, and
* plot the results.

To do all that, we'll have to learn a little bit about programming.

We have a dozen datasets that need analysis, stored as `.csv` files -
but MATLAB doesn't know about these files yet.
The first thing we need to do is set MATLAB's
[path](reference.html#matlab-path)
to include, if necessary,  the directory containing the files. The MATLAB path is a list of directories
on your computer that MATLAB knows about. The MATLAB path includes, by default, your current working directory (which can be displayed using command `pwd`).
To add other directories to the MATLAB path,
we go to the `Home` tab,
click on `Set Path`,
and then on `Add with Subfolders...`.
We navigate to the desired directory and
add it to the path to tell MATLAB where to look for our files. When you refer
to a file (either code or data), MATLAB will search all the directories in the path
to find it. Alternatively, for data files, we can also provide the relative or
absolute file path.

> ## GNU Octave
>
> Octave has only recently gained a MATLAB-like graphical user interface, and MATLAB can also be launched without it (typing `matlab -nodisplay` in a terminal). To change the
> path in any version of Octave or MATLAB, including command-line-only sessions, use
> `addpath('path/to/directory')`.
>
> There are many small differences between Octave and MATLAB, but we cannot explore all of them in this lesson. One
> difference is that
> the path is *not* used by Octave to search for the file given in the
> the `csvread` command parameter. If you are using Octave you will need
> to specify an absolute or relative path to inflammation-01.csv.
{: .callout}

Before we start programming, let's know a little about the MATLAB graphical interface.
Using the default setup, the MATLAB desktop contains several important sections:

* In the **Command Window** or **shell** we can run and debug our code.
Everything that's typed into the command window is executed immediately (a MATLAB shell is the only thing you get in command-line-only sessions).
* Alternatively, we can open the **Editor**, write our code and run it all at once.
The upside of this is that
we can save our code and run it again in the same way at a later stage.

* **Search Documentation** on the top right of your screen lets you search for functions or commands.
Suggestions for functions that would do what you want to do will pop up.
Clicking on them will open the documentation. You can also access the documentation using command `help`on the MATLAB shell.

~~~
help mean
~~~
{: .matlab}

~~~
 -- Function File: mean (X)
 -- Function File: mean (X, DIM)
 -- Function File: mean (X, OPT)
 -- Function File: mean (X, DIM, OPT)
     Compute the mean of the elements of the vector X.

          mean (x) = SUM_i x(i) / N

     If X is a matrix, compute the mean for each column and return them
     in a row vector.

     The optional argument OPT selects the type of mean to compute.  The
     following options are recognized:

     "a"
          Compute the (ordinary) arithmetic mean.  [default]

     "g"
          Compute the geometric mean.

     "h"
          Compute the harmonic mean.

     If the optional argument DIM is given, operate along this
     dimension.

     Both DIM and OPT are optional.  If both are supplied, either may
     appear first.

     See also: median, mode.
~~~
{: .output}


Reading data from files and writing data to them
are essential tasks in scientific computing,
and admittedly,
something that we'd rather not spend a lot of time thinking about.
Fortunately, MATLAB comes with a number of high-level tools to do these things efficiently,
sparing us the grisly detail.

If we know what our data looks like (in this case, we have comma-separated values)
and we're unsure about what command we want to use,
we can search the documentation.
Type `read csv` into the documentation toolbar.
MATLAB suggests using `csvread`.
If we have a closer look at the documentation,
MATLAB also tells us, which input and output arguments this function has (try also `help csvread` on the MATLAB shell).

To load the data from our CSV file into MATLAB, type the following
command into the MATLAB shell, and press `Enter`:

~~~
csvread('inflammation-01.csv')
~~~
{: .matlab}

You should see a wall of numbers on the screen---these are the values
from the CSV file.
It can sometimes
be useful to see the output from MATLAB commands, but it is often not.
To suppress the
output, simply put a semicolon at the end of your command:

~~~
csvread('inflammation-01.csv');
~~~
{: .matlab}

The expression `csvread(...)` is a
[function call](reference.html#function-call).
Functions generally need [parameters](reference.html#parameter)
to run.
In the case of the `csvread` function, we need to provide a single
parameter: the name of the file we want to read data from. This
parameter needs to be a character string or
[string](reference.html#string), so we put it in quotes.

Our call to `csvread` read our file, and printed the data 
to the screen so we can view it, however, we have no way to modify those values
or compute with them. Adding a semicolon rendered it even less useful. To work with our data we need to assign the set of values to a
[variable](reference.html#variable).

~~~
patient_data = csvread('inflammation-01.csv');
~~~
{: .matlab}

A variable is like a labeled box containing  a piece of data or *value*.
Variable names must begin with a letter, and can have
numbers or underscores. Examples of valid variable names are
`x`, `f_0` or `current_temperature`.

We can create a new variable simply by assigning a value to it using
`=`:

~~~
weight_kg = 55;
~~~
{: .matlab}

Once a variable has a value, we can print it using the `disp` function, or simply typing its name followed by enter:

~~~
disp(weight_kg);
~~~
{: .matlab}

~~~
55
~~~
{: .output}

The `disp` function takes a single parameter -- the value to print. To
print more than one value on a single line, we could print an *array*
of values. All values in this array need to be the same type. So, if
we want to print a string and a numerical value together, we *have* to
convert that numerical value to a string with the `num2str` function.

~~~
weight_lb = 2.2 * weight_kg;
disp(['Weight in pounds: ', num2str(weight_lb)]);
~~~
{: .matlab}

~~~
Weight in pounds: 121
~~~
{: .output}

Assigning a value to one variable does not change the values of other
variables.
For example, let's define two variables

~~~
weight_kg = 57.5;
weight_lb = 2.2 * weight_kg;
disp(['Weight in kg: ', num2str(weight_kg)]);
disp(['Weight in pounds: ', num2str(weight_lb)]);
~~~
{: .matlab}

~~~
Weight in kg: 57.5
Weight in pounds: 126.5
~~~
{: .output}

Now, let's update the value of one of them, and print the values
of both:

~~~
weight_kg = 100;
disp(['Weight in kg: ', num2str(weight_kg), char(10), 'Weight in pounds: ', num2str(weight_lb)]);
~~~
{: .matlab}

~~~
Weight in kg: 100
Weight in pounds: 126.5
~~~
{: .output}

Since `weight_lb` doesn't "remember" where its value came from, it isn't
automatically updated when `weight_kg` changes. This is important to
remember, and different from the way spreadsheets work.

> ## Predicting Variable Values
>
> Predict what variables refer to what values after each statement in the following program:
>
> ~~~
> mass = 47.5
> age = 122
> mass = mass * 2.0
> age = age - 20
> ~~~
> {: .matlab}
{: .challenge}

MATLAB provides a command
to list all variables that have been assigned data.

~~~
who
~~~
{: .matlab}

~~~
Your variables are:

patient_data  weight_kg  weight_lb
~~~
{: .output}

To remove a variable from MATLAB, use the `clear` command:

~~~
clear weight_lb
who
~~~
{: .matlab}


~~~
Your variables are:

patient_data  weight_kg
~~~
{: .output}

Alternatively, we can look at the **Workspace**, another windows in our graphical interface.
The workspace contains all variable names and assigned values that we currently work with.
As long as they pop up in the workspace,
they are universally available.
It's generally a good idea to keep the workspace as clean as possible.
To eliminate all variables in the workspace, type `clear all`.


Now that our data is in memory, we can start doing things with it.
First, let's find out its size and [shape](reference.html#shape):

~~~
size(patient_data)
~~~
{: .matlab}

~~~
ans =

    60 40
~~~
{: .output}

The output tells us that the variable `patient_data`
contains  a two dimensional array (or matrix) 
that has 60 rows and 40 columns. (This means that our file `inflammation-01.csv` contained the data of the inflammation of 60 different patients across 40 successive days).

MATLAB stores *all* data in the form of arrays with different sizes and shapes. For example:

* Numbers, or *scalars* are stored as the single element of an array of one column and one row, as are single
characters,
* Lists of numbers, or *vectors* are stored as arrays with multiple rows (or multiple columns),
* Tables of numbers, or *matrices* are stored as arrays with multiple rows and multiple columns,
* Even character strings, like sentences, are stored as a "list of characters".

Normally, MATLAB arrays can't store elements of different data types. For
instance, a MATLAB array can't store both a `float` and a `char`. To do that,
you have to use a [Cell Array](http://www.mathworks.com/help/matlab/cell-arrays.html).

We can use the `class` function to find out what kind of data lives
inside an array:

~~~
class(patient_data)
~~~
{: .matlab}

~~~
ans = double
~~~
{: .output}

This output tells us that `patient_data` refers to an array of
double precision floating-point numbers. This is the default numeric
data type in MATLAB. If you want to store other numeric data types,
you need to tell MATLAB explicitly. For example, the command,

~~~
x = int16(325);
~~~
{: .matlab}


assigns the value `325` to the name `x`, storing it as a 16-bit signed
integer.

Now that MATLAB has stored our data in an array, we can manipulate the entire array, or access any single value or any set of values.
Let's suppose we want to know the inflammation of the fifth patient in the sixth day. 
To do that, we must provide
its [index](reference.html#index) in parentheses:

~~~
patient_data(5, 6)
~~~
{: .matlab}

~~~
ans = 1
~~~
{: .output}

Indices are provided as (row, column). So the index `(5, 6)` selects the element
on the fifth row (fifth patient) and sixth column (sixth day).

An index like `(5, 6)` selects a single element of
an array, but we can also access sections of the matrix, or [slices](reference.html#slice).
To access a row of values we can do:

~~~
patient_data(5, :)
~~~
{: .matlab}

~~~
ans =

  Columns 1 through 13

     0     1     1     3     3     1     3     5     2     4     4     7     6

  Columns 14 through 26

     5     3    10     8    10     6    17     9    14     9     7    13     9

  Columns 27 through 39

    12     6     7     7     9     6     3     2     2     4     2     0     1

  Column 40

     1

~~~
{: .output}

Providing `:` as the index for a dimension selects *all* elements
along that dimension.
So, the index `(5, :)` selects
the elements on row `5`, and *all* columns---effectively, the entire fifth row (all the data corresponding to the fifth patient).

We can also
select multiple rows,

~~~
patient_data(1:4, :)
~~~
{: .matlab}

~~~
ans =

  Columns 1 through 15

     0     0     1     3     1     2     4     7     8     3     3     3    10     5     7
     0     1     2     1     2     1     3     2     2     6    10    11     5     9     4
     0     1     1     3     3     2     6     2     5     9     5     7     4     5     4
     0     0     2     0     4     2     2     1     6     7    10     7     9    13     8

  Columns 16 through 30

     4     7     7    12    18     6    13    11    11     7     7     4     6     8     8
     4     7    16     8     6    18     4    12     5    12     7    11     5    11     3
    15     5    11     9    10    19    14    12    17     7    12    11     7     4     2
     8    15    10    10     7    17     4     4     7     6    15     6     4     9    11

  Columns 31 through 40

     4     4     5     7     3     4     2     3     0     0
     3     5     4     4     5     5     1     1     0     1
    10     5     4     2     2     3     2     2     1     1
     3     5     6     3     3     4     2     3     2     1
~~~
{: .output}

which in our case give us all data of the first four patients; or select multiple columns:

~~~
patient_data(:, 38:end)
~~~
{: .matlab}

~~~
ans =

     3     0     0
     1     0     1
     2     1     1
     3     2     1
     0     1     1
     3     2     1
     1     1     1
     2     2     1
     1     0     0
     2     0     0
     2     2     1
     0     1     1
     3     0     1
     3     0     0
     0     2     0
     2     2     0
     0     2     1
     0     1     0
     0     1     0
     3     1     1
     2     2     0
     0     2     0
     0     1     0
     1     2     0
     0     2     1
     1     1     0
     0     1     1
     3     2     1
     3     1     0
     1     0     1
     3     2     1
     3     0     0
     0     2     1
     2     1     1
     1     1     1
     2     2     0
     3     2     1
     0     1     0
     3     0     1
     3     2     1
     0     0     1
     2     0     0
     1     2     0
     1     0     1
     3     1     1
     1     1     0
     0     0     0
     1     2     1
     3     0     0
     2     2     1
     1     2     0
     3     1     0
     1     2     1
     2     2     1
     0     0     1
     3     0     1
     2     1     1
     1     1     1
     0     2     0
     1     1     0
~~~
{: .output}

which give us the inflammation of all patients in the last 3 days.

To select a submatrix, we take slices in both dimensions:

~~~
patient_data(1:4, 38:end)
~~~
{: .matlab}

~~~
ans =

     3     0     0
     1     0     1
     2     1     1
     3     2     1
~~~
{: .output}

We don't have to take successive values in a slice. Using
a [stride](reference.html#stride) we can create different selection patterns. To illustrate this, consider the matrix 

~~~
M = magic(8)
~~~
{: .matlab}

~~~
ans =

   64    2    3   61   60    6    7   57
    9   55   54   12   13   51   50   16
   17   47   46   20   21   43   42   24
   40   26   27   37   36   30   31   33
   32   34   35   29   28   38   39   25
   41   23   22   44   45   19   18   48
   49   15   14   52   53   11   10   56
    8   58   59    5    4   62   63    1
~~~
{: .output}

 Let's say we want to start with row `2`,
and subsequently select every third row:

![Accessing strided columns](../fig/matrix-strided-rows.svg)

~~~
M(2:3:end, :)
~~~
{: .matlab}

~~~
ans =

    9   55   54   12   13   51   50   16
   32   34   35   29   28   38   39   25
    8   58   59    5    4   62   63    1
~~~
{: .output}

And we can also select values in a "checkerboard",

![Accessing strided rows and columns](../fig/matrix-strided-rowncols.svg)

by taking appropriate strides in both dimensions:

~~~
M(1:3:end, 2:2:end)
~~~
{: .matlab}

~~~
ans =

    2   61    6   57
   26   37   30   33
   15   52   11   56
~~~
{: .output}

> ## Slicing
>
> A subsection of an array is called a [slice](reference.html#slice). We can take slices of character strings as well:
>
> ~~~
> element = 'oxygen';
> disp(['first three characters: ', element(1:3)])
> disp(['last three characters: ', element(4:6)])
> ~~~
> {: .matlab}
>
> ~~~
> first three characters: oxy
> last three characters: gen
> ~~~
> {: .output}
>
> 1. What is the value of `element(4:end)`? What about `element(1:2:end)`? Or `element(2:end - 1)`?
>
> 2. For any size array, Matlab allows us to index with a single colon operator (`:`).
>    This can have surprising effects.
>    For instance, compare `element` with `element(:)`. What is `size(element)` versus `size(element(:))`?
>    Finally,
>    try using the single colon on the matrix `M` above: `M(:)`.
>    What seems to be happening when we use the single colon operator for slicing?
{: .challenge}

Now that we know how to access data we want to compute with,
we're ready to analyze `patient_data`.
MATLAB knows how to perform common mathematical operations on arrays. When working with the elements inside an array, however, some times we want to tell 
MATLAB across which dimension or axis we wish to work. 

![Operations Across Axes](../fig/matlab-operations-across-axes.svg)

To support this, MATLAB allows us to specify the *dimension* in many of its common functions. If we ask for the average across the dimension 1, for example,
we get:

~~~
mean(patient_data, 1)
~~~
{: .matlab}

~~~
ans =

 Columns 1 through 13:

    0.00000    0.45000    1.11667    1.75000    2.43333    3.15000    3.80000    3.88333    5.23333    5.51667    5.95000    5.90000    8.35000

 Columns 14 through 26:

    7.73333    8.36667    9.50000    9.58333   10.63333   11.56667   12.35000   13.25000   11.96667   11.03333   10.16667   10.00000    8.66667

 Columns 27 through 39:

    9.15000    7.25000    7.33333    6.58333    6.06667    5.95000    5.11667    3.60000    3.30000    3.56667    2.48333    1.50000    1.13333

 Column 40:

    0.56667

~~~
{: .output}

As a quick check, we can take the size of this last array:

~~~
size(ans)
~~~
{: .matlab}

~~~
ans =
    1    40
~~~
{: .output}

This tells us we have a 1-by-40 vector, which means this is the average
inflammation per day for all patients. 

If we average across axis 2, we
get:

~~~
mean(patient_data, 2)
~~~
{: .matlab}

~~~
ans =

   5.4500
   5.4250
   6.1000
   5.9000
   5.5500
   6.2250
   5.9750
   6.6500
   6.6250
   6.5250
   6.7750
   5.8000
   6.2250
   5.7500
   5.2250
   6.3000
   6.5500
   5.7000
   5.8500
   6.5500
   5.7750
   5.8250
   6.1750
   6.1000
   5.8000
   6.4250
   6.0500
   6.0250
   6.1750
   6.5500
   6.1750
   6.3500
   6.7250
   6.1250
   7.0750
   5.7250
   5.9250
   6.1500
   6.0750
   5.7500
   5.9750
   5.7250
   6.3000
   5.9000
   6.7500
   5.9250
   7.2250
   6.1500
   5.9500
   6.2750
   5.7000
   6.1000
   6.8250
   5.9750
   6.7250
   5.7000
   6.2500
   6.4000
   7.0500
   5.9000
~~~
{: .output}

which is the average inflammation per patient across
all days.

If we want to find the average inflammation for all patients on all days,
we just ask for the mean of the whole array:

~~~
mean(patient_data(:))
~~~
{: .matlab}

~~~
ans = 6.1487
~~~
{: .output}

We couldn't just do `mean(patient_data)` because, by default, this is equivalent to `mean(patient_data,1)`
and returns an array with the mean value of each column in our table. The expression `patient_data(:)` *flattens* the matrix into a
vector array by rearranging its values in *column-major order*.

Another way to do this is to compute first `mean(patient_data)`, the average of every day, 

~~~
mean(patient_data)
~~~
{: .matlab}

~~~
ans =

  Columns 1 through 9

         0    0.4500    1.1167    1.7500    2.4333    3.1500    3.8000    3.8833    5.2333

  Columns 10 through 18

    5.5167    5.9500    5.9000    8.3500    7.7333    8.3667    9.5000    9.5833   10.6333

  Columns 19 through 27

   11.5667   12.3500   13.2500   11.9667   11.0333   10.1667   10.0000    8.6667    9.1500

  Columns 28 through 36

    7.2500    7.3333    6.5833    6.0667    5.9500    5.1167    3.6000    3.3000    3.5667

  Columns 37 through 40

    2.4833    1.5000    1.1333    0.5667
~~~
{: .output}

and then average all the results in the variable `ans`(notice that `ans` always contains the output of the last executed command) 

~~~
mean(ans)
~~~
{: .matlab}

~~~
ans = 6.1487
~~~
{: .output}

We can also do this in a single step by combining functions like this:

~~~
mean(mean(patient_data))
~~~
{: .matlab}

~~~
ans = 6.1487
~~~
{: .output}


We may want to compute other statistics as well, like the maximum, minimum and
standard deviation.

~~~
disp(['Maximum inflammation: ', num2str(max(patient_data(:)))]);
disp(['Minimum inflammation: ', num2str(min(patient_data(:)))]);
disp(['Standard deviation: ', num2str(std(patient_data(:)))]);
~~~
{: .matlab}

~~~
Maximum inflammation: 20
Minimum inflammation: 0
Standard deviation: 4.6148
~~~
{: .output}

Or we may want to look at partial statistics 
such as the maximum value of a given patient or the average value for a given day

~~~
max_patient_1=max(patient_data(1, :));
disp(['Maximum inflamation for patient 1: ', num2str(max_patient_1)]);
~~~
{: .matlab}

~~~
Maximum inflamation for patient 1: 18
~~~
{: .output}

The mathematician Richard Hamming once said,
"The purpose of computing is insight, not numbers," and the best
way to develop insight is often to visualize data. Visualization
deserves an entire lecture (or course) of its own, but we can
explore a few features of MATLAB here.

Let's display a heat map of our data:

~~~
imagesc(patient_data)
~~~
{: .matlab}

![First Heat Map](../fig/01-intro_1.png)

The `imagesc` function represents the matrix as a color image. Every
value in the matrix is *mapped* to a color. Blue regions in this heat map
are low values, while red shows high values.
As we can see,
inflammation rises and falls over a 40 day period.
Let's take a look at the average inflammation over time:

~~~
ave_inflammation = mean(patient_data, 1);
plot(ave_inflammation);
~~~
{: .matlab}

![Second Heat Map](../fig/01-intro_2.png)

Here, we have put the average per day across all patients in the
variable `ave_inflammation`, then used the `plot` function to display
a line graph of those values.
The result is roughly a linear rise and fall. Suppose that we suspect this result since, based in other studies, we were expecting a sharper rise and slower fall.
To investigate further, let's have a look at two other statistics: the maximum and minimum
inflammation per day across all patients.

~~~
plot(max(patient_data, [], 1));
title('Maximum inflammation per day');
~~~
{: .matlab}

![Third Heat Map](../fig/01-intro_3.png)

~~~
plot(min(patient_data, [], 1));
title('Minimum inflammation per day');
~~~
{: .matlab}

![Fourth Heat Map](../fig/01-intro_4.png)

(Notice that, like `mean()`, the functions
`max()` and `min()` can also operate across a specified dimension of
the matrix. However, the syntax is slightly different. To see why,
run a `help` on each of these functions).

From the figures, we see that the maximum value rises and falls at a steady rate, while the minimum value seems to be a step function. Neither result
seems likely, so we can conclude that there's something wrong with our data.

> ## Plots
>
> 1. Why do our graphs stop just short of 0 at their left edge?
>    Why are the vertical lines in our plot of the minimum inflammation per day not perfectly vertical?
>
> 2. Create a plot showing the standard deviation of the inflammation data for each day across all patients.
{: .challenge}

It's common to put multiple figures "side-by-side" in a single
window for presentation and convenience. Here's how to use
the `subplot` function to do this:

~~~
subplot(1, 2, 1);
plot(max(patient_data, [], 1));
ylabel('max')

subplot(1, 2, 2);
plot(min(patient_data, [], 1));
ylabel('min')
~~~
{: .matlab}

![Fifth Heat Map](../fig/01-intro_5.png)

Our work so far has convinced us that something is wrong with our
first data file. We would like to check the other 11 files the same way,
but typing in the same commands repeatedly is tedious and error-prone.
Since computers don't get bored (that we know of), we should create a
way to do a complete analysis with a single command, and then figure out
how to repeat that command once for each file. These operations will be studied in the
following lessons.
