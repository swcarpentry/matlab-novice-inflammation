---
title: Creating Functions
teaching: 30
exercises: 0
questions:
- "How can I teach MATLAB how to do new things?"
objectives:
- "Compare and contrast MATLAB function files with MATLAB scripts."
- "Define a function that takes arguments."
- "Test a function."
- "Recognize why we should divide programs into small, single-purpose functions."
keypoints:
- "Break programs up into short, single-purpose functions with meaningful names."
- "Define functions using the `function` keyword."
---

If we only had one data set to analyze,
it would probably be faster to load the file into a spreadsheet
and use that to plot some simple statistics.
But we have twelve files to check,
and may have more in future.
In this lesson,
we'll learn how to write a function
so that we can repeat several operations with a single command.

Let's start by defining a function `fahr_to_kelvin` that converts temperatures from Fahrenheit to Kelvin:

~~~
% file fahr_to_kelvin.m

function ktemp = fahr_to_kelvin(ftemp)
    ktemp = ((ftemp - 32) * (5/9)) + 273.15;
end
~~~
{: .matlab}

A MATLAB function *must* be saved in a text file with a `.m` extension.
The name of that file must be the same as the function defined
inside it. The name must start with a letter and cannot contain spaces.
So, you will need to save the above code in a file called
`fahr_to_kelvin.m`.

The first line of our function:

~~~
function ktemp = fahr_to_kelvin(ftemp)
~~~
{: .matlab}

is called the *function definition*, and it declares that we're
writing a function named `fahr_to_kelvin`, that has a single parameter,
`ftemp`, and outputs a single value, `ktemp`.  Anything following the
function definition line is called the *body* of the
function. The keyword `end` marks the end of the function body, and the
function won't know about any code after `end`.

Just as we saw with scripts, functions must be _visible_ to MATLAB, i.e.,
a file containing a function has to be placed in a directory that
MATLAB knows  about. The most convenient of those directories is the
current working directory.

> ## GNU Octave
>
> In common with MATLAB, Octave searches the current working directory and
> the path for functions called from the command line.
{: .callout}

We can call our function from the command line
like any other MATLAB function:

~~~
fahr_to_kelvin(32)
~~~
{: .matlab}

~~~
ans = 273.15
~~~
{: .output}

When we pass a value, like `32`, to the function, the value is assigned
to the variable `ftemp` so that it can be used inside the function. If we
want to return a value from the function, we must assign that value to a
variable named `ktemp`---in the first line of our function, we promised
that the output of our function would be named `ktemp`.

Outside of the function, the names `ftemp` and `ktemp` don't matter,
they are only used by the function body to refer to the input and
output values.

Now that we've seen how to turn Fahrenheit to Kelvin, it's easy to turn
Kelvin to Celsius.

~~~
% file kelvin_to_celsius.m

function ctemp = kelvin_to_celsius(ktemp)
    ctemp = ktemp - 273.15;
end
~~~
{: .matlab}

Again, we can call this function like any other:

~~~
kelvin_to_celsius(0.0)
~~~
{: .matlab}

~~~
ans = -273.15
~~~
{: .output}

What about converting Fahrenheit to Celsius?
We could write out the formula, but we don't need to.
Instead, we can [compose](../reference/index.html#function-composition) the two
functions we have already created:

~~~
% file fahr_to_celsius.m

function ctemp = fahr_to_celsius(ftemp)
    ktemp = fahr_to_kelvin(ftemp);
    ctemp = kelvin_to_celsius(ktemp);
end
~~~
{: .matlab}

Calling this function,

~~~
fahr_to_celsius(32.0)
~~~
{: .matlab}

we get, as expected:

~~~
ans = 0
~~~
{: .output}

This is our first taste of how larger programs are built:
we define basic operations,
then combine them in ever-larger chunks to get the effect we want.
Real-life functions will usually be larger than the ones shown
here---typically half a dozen to a few dozen lines---but
they shouldn't ever be much longer than that,
or the next person who reads it won't be able to understand what's going on.

> ## Concatenating in a Function
>
> In MATLAB, we concatenate strings by putting them into an array or using the
> `strcat` function:
>
> ~~~
> disp(['abra', 'cad', 'abra'])
> ~~~
> {: .matlab}
>
> ~~~
> abracadabra
> ~~~
> {: .output}
>
> ~~~
> disp(strcat('a', 'b'))
> ~~~
> {: .matlab}
>
> ~~~
> ab
> ~~~
> {: .output}
>
> Write a function called `fence` that has two parameters, `original` and
> `wrapper` and adds `wrapper` before and after `original`:
>
> ~~~
> disp(fence('name', '*'))
> ~~~
> {: .matlab}
>
> ~~~
> *name*
> ~~~
> {: .output}
> > ## Solution
> > ```
> > % fence Return original string, with wrapper prepended and appended
> >
> > function wrapped = fence(original ,wrapper)
> >     wrapped = strcat(wrapper, original, wrapper);
> > end
> > ```
> > {: .matlab}
> {: .solution}
{: .challenge}

> ## Getting the Outside
>
> If the variable `s` refers to a string, then `s(1)` is the string's first
> character and `s(end)` is its last. Write a function called `outer` that returns
> a string made up of just the first and last characters of its input:
>
> ~~~
> disp(outer('helium'))
> ~~~
> {: .matlab}
>
> ~~~
> hm
> ~~~
> {: .output}
> > ## Solution
> > ```
> > % outer    Return first and last characters from a string
> > 
> > function ends = outer(s)
> >     ends = strcat(s(1), s(end));
> > end
> > ```
> > {: .matlab}
> {: .solution}
{: .challenge}

Let's take a closer look at what happens when we call
`fahr_to_celsius(32.0)`.
To make things clearer, we'll start by putting the initial value 32.0
in a variable and store the final result in one as well:

~~~
original = 32.0;
final = fahr_to_celsius(original);
~~~
{: .matlab}

Once we start putting things in functions so that we can
re-use them, we need to start testing that those functions are
working correctly.
To see how to do this, let's write a function to center a
dataset around a particular value:

~~~
function out = center(data, desired)
    out = (data - mean(data(:))) + desired;
end
~~~
{: .matlab}

We could test this on our actual data, but since we
don't know what the values ought to be,
it will be hard to tell if the result was correct,
Instead, let's create a matrix of 0's, and then center that
around 3:

~~~
z = zeros(2,2);
center(z, 3)
~~~
{: .matlab}

~~~
ans =

   3   3
   3   3
~~~
{: .output}

That looks right, so let's try out `center` function on our real data:

~~~
data = csvread('inflammation-01.csv');
centered = center(data(:), 0)
~~~
{: .matlab}

It's hard to tell from the default output whether the
result is correct--this is often the case when working with
fairly large arrays--but, there are a few simple tests that
will reassure us.

Let's calculate some simple statistics:

~~~
disp([min(data(:)), mean(data(:)), max(data(:))])
~~~
{: .matlab}

~~~
0.00000    6.14875   20.00000
~~~
{: .output}

And let's do the same after applying our `center` function
to the data:

~~~
disp([min(centered(:)), mean(centered(:)), max(centered(:))])
~~~
{: .matlab}

~~~
   -6.1487   -0.0000   13.8513
~~~
{: .output}

That seems almost right: the original mean
was about 6.1, so the lower bound from zero is now about -6.1.
The mean of the centered data isn't quite zero--we'll explore
why not in the challenges--but it's pretty close. We can even
go further and check that the standard
deviation hasn't changed:

~~~
std(data(:)) - std(centered(:))
~~~
{: .matlab}

~~~
5.3291e-15
~~~
{: .output}

The difference is very small. It's still possible that our function
is wrong, but it seems unlikely enough that we should probably
get back to doing our analysis. We have one more task first, though:
we should write some [documentation](../reference/index.html#documentation)
for our function to remind ourselves later what it's for and
how to use it.

~~~
function out = center(data, desired)
    %   Center data around a desired value.
    %
    %       center(DATA, DESIRED)
    %
    %   Returns a new array containing the values in
    %   DATA centered around the value.

    out = (data  - mean(data(:))) + desired;
end
~~~
{: .matlab}

Comment lines immediately below the function definition line
are called "help text". Typing `help function_name` brings
up the help text for that function:

~~~
help center
~~~
{: .matlab}

~~~
Center data around a desired value.

    center(DATA, DESIRED)

Returns a new array containing the values in
DATA centered around the value.
~~~
{: .output}

> ## Testing a Function
>
> 1. Write a function called `normalise` that takes an array as input and returns an
>    array of the same shape with its values scaled to lie in the range 0.0 to 1.0.
>    (If L and H are the lowest and highest values in the input array, respectively,
>    then the function should map a value v to (v - L)/(H - L).) Be sure to give the
>    function a comment block explaining its use.
>
> 1. Run `help linspace` to see how to use `linspace` to generate
>    regularly-spaced values. Use arrays like this to test your `normalise` function.
>
<<<<<<< 0c30490a538043327950a07887624f5f76cbb5b3
> > ## Solution
> >
> > 1. 
> >
> >     ```
> >     % Normalise    Return original array, normalised so that the
> >     %              new values lie in the range 0 to 1.
> >     function out = normalise(in)
> >         H = max(max(in));
> >         L = min(min(in));
> >         out = (in-L)/(H-L);
> >     end
> >     ```
> >     {: .matlab}
> >
> > 2. 
> >
> >     ```
> >     a = linspace(1, 10);   % Create evenly-spaced vector
> >     norm_a = normalise(a); % Normalise vector
> >     plot(a, norm_a)        % Visually check normalisation
> >     ```
> >     {: .matlab}
> {: .solution}
{: .challenge}

> ## Convert a script into a function
>
> Convert the script from the previous episode into a function called `analyze_dataset`.
> The function should operate on a single data file,
> and should have two parameters: `file_name` and `plot_switch`.
> When called, the function should create the three graphs produced in the
> previous lesson. Whether they are displayed or saved to the `results` directory
> should be controlled by the value of `plot_switch`
> i.e. `analyze_dataset('inflammation-01.csv', 0)`
> should display the corresponding graphs for the first data set;
> `analyze_dataset('inflammation-02.csv', 1)` should save the figures for the second
> dataset to the `results` directory.
>
> Be sure to give your function help text.
>
> > ## Solution
> > ```
> > function analyze_dataset(file_name, plot_switch)
> >     %ANALYZE_DATASET    Perform analysis for named data file.
> >     %   Create figures to show average, max and min inflammation.
> >     %   Display plots in GUI using plot_switch = 0,
> >     %   or save to disk using plot_switch = 1.
> >     %
> >     %   Example:
> >     %       analyze_dataset('data/inflammation-01.csv', 0)
> >     
> >     % Generate string for image name:
> >     img_name = replace(file_name, 'inflammation', 'patient_data');
> >     img_name = replace(img_name, '.csv', '.png');
> >     img_name = fullfile('results', img_name);
> >
> >     patient_data = csvread(file_name);
> >     ave_inflammation = mean(patient_data, 1);
> >     
> >     if plot_switch == 1
> >     	figure('visible', 'off')
> >     else
> >     	figure('visible', 'on')
> >     end
> >     
> >     subplot(2, 2, 1);
> >     plot(ave_inflammation);
> >     ylabel('average')
> >     
> >     subplot(2, 2, 2);
> >     plot(max(patient_data, [], 1));
> >     ylabel('max')
> >     
> >     subplot(2, 2, 3);
> >     plot(min(patient_data, [], 1));
> >     ylabel('min')
> >     
> >     if plot_switch == 1
> >         print('-dpng', img_name);
> >         close()
> >     end
> >  ```
> > {: .matlab}
> {: .solution}
=======
> 1. Write a function `run_analysis` that accepts a filename
>    as the input argument, and displays the three graphs produced in the
>    previous lesson, i.e., `run_analysis('inflammation-01.csv')`
>    should produce the corresponding graphs for the first
>    data set. Be sure to give your function help text.
>>>>>>> Avoid usage of parameters in place of arguments
{: .challenge}

> ## Automate the analysis for all files
>
> Write a script called `process_all` which loops over all of the
> data files, and calls the function `analyze_dataset` for each file
> in turn.
> Your script should save the image files to the 'results' directory
> rather than displaying the figures in the MATLAB GUI.
>
> > ## Solution
> >
> > ```
> > %PROCESS_ALL    Analyse all inflammation datasets
> > %   Create figures to show average, max and min inflammation.
> > %   Save figures to 'results' directory.
> >
> > files = dir('data/inflammation-*.csv');
> >
> > for i = 1:length(files)
> >     file_name = files(i).name;
> >
> >     % Process each data set, saving figures to disk.
> >     analyze_dataset(file_name, 1);
> > end
> > ```
> > {: .matlab}
> {: .solution}
{: .challenge}


We have now solved our original problem: we can analyze
any number of data files with a single command.
More importantly, we have met two of the most important
ideas in programming:

1. Use arrays to store related values, and loops to
   repeat operations on them.

2. Use functions to make code easier to re-use and
   easier to understand.
