---
title: Repeating With Loops
teaching: 30
exercises: 0
questions:
- "How can I repeat the same operations on multiple values?"
objectives:
- "Explain what a for loop does."
- "Correctly write for loops that repeat simple commands."
- "Trace changes to a loop variable as the loops runs."
- "Use a for loop to process multiple files"
keypoints:
- "Use `for` to create a loop that repeats one or more operations."
---

Recall that we have to do this analysis for every one of our dozen datasets, and we need a better way than
typing out commands for each one,
because we'll find ourselves writing a lot of duplicate code.
Remember, code that is repeated in two or more places
will eventually be wrong in at least one.
Also, if we  make changes in the way we analyze our datasets,
we have to introduce that change in every copy of our code.
To avoid all of this repetition, we have to teach MATLAB to
repeat our commands,
and to do *that*,
we have to learn how to write *loops*.

Suppose we want to print each character in the word "lead" on
a line of its own. One way is to use four `disp` statements:

~~~
word = 'lead';

disp(word(1));
disp(word(2));
disp(word(3));
disp(word(4));
~~~
{: .matlab}

~~~
l
e
a
d
~~~
{: .output}

But this is a bad approach for two reasons:

1. It doesn't scale: if we want to print the characters
in a string that's hundreds of letters long, we'd be better
off typing them in.

2. It's fragile: if we change `word` to a longer string,
it only
prints part of the data, and if we change it to
a shorter one,
it produces an error, because we're asking for characters
that don't exist.

~~~
word = 'tin';

disp(word(1));
disp(word(2));
disp(word(3));
disp(word(4));
~~~
{: .matlab}

~~~
error: A(I): index out of bounds; value 4 out of bound 3
~~~
{: .error}

There's a better approach:

~~~
word = 'lead';

for letter = 1:4
    disp(word(letter))
end
~~~
{: .matlab}

~~~
l
e
a
d
~~~
{: .output}

This improved version uses a [for loop](../reference/index.html#for-loop) to
repeat an operation---in this case, printing to the screen---once for
each element in an array.

The general form of a for loop is:

~~~
for variable = collection
    do things with variable
end
~~~
{: .source}

The for loop executes the commands in the
[loop body](../reference/index.html#loop-body)
for every value in the array `collection`.
This value is called the [loop variable](../reference/index.html#loop-variable),
and we can call it whatever we like.
In our example, we gave it the name `letter`.

We have to terminate the loop body with the `end` keyword,
and we can have as many commands as we like in the loop body.
But, we have to remember
that they will all be repeated as many times as
there are values in `collection`.

Our for loop has made our code more scalable,
and less fragile.
There's still one little thing about it that should bother us.
For our loop to deal appropriately with shorter or longer words,
we have to change the first line of our loop by hand:

~~~
word = 'tin';

for letter = 1:3
    disp(word(letter));
end
~~~
{: .matlab}

~~~
t
i
n
~~~
{: .output}

Although this works,
it's not the best way to write our loop:

* We might update `word` and forget to modify the loop to reflect that
  change.

* We might make a mistake while counting the number of letters in
  `word`.

Fortunately,
MATLAB provides us with a convenient function to
write a better loop:

~~~
word = 'aluminum';

for letter = 1:length(word)
    disp(word(letter));
end
~~~
{: .matlab}

~~~
a
l
u
m
i
n
u
m
~~~
{: .output}

This is much more robust code,
as it can deal identically with
words of arbitrary length.
Here's another loop that
repeatedly updates the variable `len`:

~~~
len = 0
for vowel = 'aeiou'
    len = len + 1;
end

disp(['Number of vowels: ', num2str(len)])
~~~
{: .matlab}

It's worth tracing the execution of this little program step by step.
Since there are five characters in "aeiou",
the loop body will be executed five times.
When we enter the loop, `len` is zero -
the value assigned to it beforehand.
The first time through,
the loop body adds 1 to the old value of `len`,
producing 1,
and updates `len` to refer to that new value.
The next time around,
`vowel` is `e`,
and `len` is 1,
so `len` is updated to 2.
After three more updates,
`len` is 5;
since there's nothing left in `aeiou` for MATLAB to process,
the loop finishes and the `disp` statement tells us our final answer.

Note that a loop variable is just a variable
that's being used to record progress in a loop.
It still exists after the loop is over,
and we can re-use variables previously defined as loop variables as well:

~~~
disp(vowel)
~~~
{: .matlab}

~~~
u
~~~
{: .output}

> ## Performing Exponentiation
>
> MATLAB uses the caret (`^`) to perform exponentiation:
>
> ~~~
> disp(5^3)
> ~~~
> {: .matlab}
>
> ~~~
> 125
> ~~~
> {: .output}
>
> You can also use a loop to perform exponentiation.
> Remember that `b^x` is just
> `b*b*b*`... `x` times.
>
> Let a variable `b` be the base of the number and `x` the exponent.
> Write a loop to compute `b^x`.
> Check your result for `b = 4` and `x = 5`.
>
> > ## Solution
> > ```
> > % Loop to perform exponentiation
> > b = 4;    % base
> > x = 5;    % exponent
> > 
> > result=1;
> > for i = 1:x
> >     result = result * b;
> > end
> > 
> > disp([num2str(b), '^', num2str(x), ' = ', num2str(result)])
> > ```
> > {: .matlab}
> {: .solution}
{: .challenge}

> ## Incrementing with Loops
>
> Write a loop that spells the word "aluminum," adding one letter at a time:
>
> ~~~
> a
> al
> alu
> alum
> alumi
> alumin
> aluminu
> aluminum
> ~~~
> {: .output}
> > ## Solution
> > ```
> > % spell a string adding one letter at a time using a loop
> >
> > word = 'aluminium';
> > 
> > for letter = 1:length(word)
> >     disp(word(1:letter))
> > end
> > ```
> > {: .matlab}
> {: .solution}
 {: .challenge}
 
> ## Looping in Reverse
>
> In MATLAB, the colon operator (`:`) accepts a
> [stride](../reference/index.html#stride)
> or skip argument between the start and stop:
>
> ~~~
> disp(1:3:11)
> ~~~
> {: .matlab}
>
> ~~~
> 1 4 7 10
> ~~~
> {: .output}
>
> ~~~
> disp(11:-3:1)
> ~~~
> {: .matlab}
>
> ~~~
> 11 8 5 2
> ~~~
> {: .output}
>
> Using this,
> write a loop to print the letters of "aluminum"
> in reverse order, one letter per line.
>
> ~~~
> m
> u
> n
> i
> m
> u
> l
> a
> ~~~
> {: .output}
> > ## Solution
> > ```
> > % Spell a string in reverse using a loop
> > 
> > word = 'aluminium';
> > 
> > for letter = length(word):-1:1
> >     disp(word(letter))
> > end
> > ```
> > {: .matlab}
> {: .solution}
{: .challenge}

We now have almost everything we need to process
multiple data files with our `analyze` script.

We need to generate a list of data files to process,
and then we can use a loop to repeat the analysis for each file.

We can use the `dir` command to return a **structure array** containing
the names of the files in the `data` directory.
Each element in this *structure array* is a **structure**, containing
information about a single file in the form of named **fields**.

```
files = dir('data/inflammation-*.csv')
```
{: .matlab}

```
files = 
  12×1 struct array with fields:
    name
    folder
    date
    bytes
    isdir
    datenum
```
{: .output}

To access the *name* field of the first file, we can use the following syntax:

```
filename = files(1).name;
disp(filename)
```
{: .matlab}

```
inflammation-01.csv
```
{: .output}

To get the modification date of the third file, we can do:

~~~
mod_date = files(3).date;
disp(mod_date)
~~~
{: .matlab}

~~~
26-Jul-2015 22:24:31
~~~
{: .output}

A good first step towards processing multiple files is to write a loop which prints
the name of each of our files:

```
files = dir('data/*.csv');

for i = 1:length(files)
	data_file = files(i).name;
	disp(data_file)
end
```
{: .matlab}

~~~
inflammation-01.csv
inflammation-02.csv
inflammation-03.csv
inflammation-04.csv
inflammation-05.csv
inflammation-06.csv
inflammation-07.csv
inflammation-08.csv
inflammation-09.csv
inflammation-10.csv
inflammation-11.csv
inflammation-12.csv
~~~
{: .output}

The final task is to generate the file names for the figures we're going to save.
Let's name the output file after the data file used to generate the figure.
So for the data set `inflammation-01.csv` we will call the figure `inflammation-01.png`.
We can use the `replace` command for this purpose.

The syntax for the `replace` command is like this:

```
NEWSTR = replace(STR, OLD, NEW)
```
{: .matlab}

So for example if we have the string `big_shark` and want to get the string
`terror_shark`, we can execute the following command:

```
new_string = replace('big_shark', 'big', 'terror');
disp(new_string)
```
{: .matlab}

```
terror_shark
```
{: .output}

Recall that we're saving our figures to the `results` directory.
The best way to generate a path to a file in MATLAB is by using the `fullfile` command.
This generates a file path with the correct separators for the platform you're using
(i.e. forward slash for Linux and macOS, and backslash for Windows).
This makes your code more portable which is great for collaboration.

We're now ready to modify `analyze.m` to process multiple data files:

~~~
%ANALYSE Process first three inflammation data sets

files = dir('data/*.csv');

% Process first three files only
for idx = 1:3
    file_name = files(idx).name;
	
    % Generate strings for image names:
    img_name  = replace(file_name, '.csv', '.png');

    % Generate path to data file and image file
    file_name = fullfile('data', file_name);
    img_name  = fullfile('results', img_name);
	
    patient_data = csvread(file_name);

    disp(['Maximum inflammation: ', num2str(max(patient_data(:)))]);
    disp(['Minimum inflammation: ', num2str(min(patient_data(:)))]);
    disp(['Standard deviation: ', num2str(std(patient_data(:)))]);

    ave_inflammation = mean(patient_data, 1);

    % Create figures
    figure('visible', 'off')

    subplot(2, 2, 1);
    plot(ave_inflammation);
    ylabel('average')

    subplot(2, 2, 2);
    plot(max(patient_data, [], 1));
    ylabel('max')

    subplot(2, 2, 3);
    plot(min(patient_data, [], 1));
    ylabel('min')

    print('-dpng', img_name);
    close();
end
~~~
{: .matlab}

We run the modified script using its name in the Command Window:

~~~
analyze
~~~
{: .matlab}

The figures output to the `results` directory are as shown below:

<img src="../img/02-loop_1.png" style="width:500px; height:400px">

<img src="../img/02-loop_2.png" style="width:500px; height:400px">

<img src="../img/02-loop_3.png" style="width:500px; height:400px">

Sure enough, the maxima of these data sets show exactly
the same ramp as the first,
and their minima show the same staircase structure.

We've now automated the analysis and have confirmed that all the data
files show the same artifact. This is what we set out to test, and now
we can just call one script to do it. With minor modifications, this
script could be re-used to check all our future data files.


> ## GNU Octave
>
> Lastly, in the above trick using `ls` with the wildcard `*`,
> another small Octave/MATLAB
> difference shows up. In Octave, the value returned by
> `filestr = ls('path/to/data/*.csv')` is an array of strings, so we can loop
> over `filestr` directly without the need to split it with `strsplit`.
{: .callout}
