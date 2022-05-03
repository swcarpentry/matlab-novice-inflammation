---
title: Making Choices
teaching: 35
exercises: 5
questions:
- "How can programs do different things for different data values?"
objectives:
- "Construct a conditional statement using if, elseif, and else"
- "Test for equality within a conditional statement"
- "Combine conditional tests using AND and OR"
- "Build a nested loop"
keypoints:
- "Use `if` and `else` to make choices based on values in your program."
---

Our previous lessons have shown us how to manipulate
data and repeat things.
However, the programs we have written so far always do
the same things, regardless of what data they're given.
We want programs to make choices based on the values
they are manipulating.

The tool that MATLAB gives us for doing this is called
a [conditional statement]({{ page.root }}/reference.html#conditional-statement),
and it looks like this:

~~~
num = 37;

if num > 100
    disp('greater')
else
    disp('not greater')
end

disp('done')
~~~
{: .language-matlab}

~~~
not greater
done
~~~
{: .output}

The second line of this code uses the keyword `if` to tell MATLAB
that we want to make a choice. If the test that follows is true,
the body of the `if` (i.e., the lines between `if` and `else`) are
executed. If the test is false, the body of the `else` (i.e.,
the lines between `else` and `end`) are executed instead. Only one
or the other is ever executed.

Conditional statements don't have to have an `else` block. If there
isn't one, MATLAB simply doesn't do anything if the test is false:

~~~
num = 53;
disp('before conditional...')

if num > 100
    disp('53 is greater than 100')
end

disp('...after conditional')
~~~
{: .language-matlab}

~~~
before conditional...
...after conditional
~~~
{: .output}

We can also chain several tests together using `elseif`. This makes it
simple to write a script that gives the sign of a number:

~~~
%CONDITIONAL_DEMO   Demo script to illustrate use of conditionals

num = 53;

if num > 0
    disp('num is positive')
elseif num == 0
    disp('num is zero')
else
    disp('num is negative')
end
~~~
{: .language-matlab}

One important thing to notice in the code above is that we use
a double equals sign `==` to test for equality rather than a
single equals sign. This is because the latter is used to mean
assignment. In our test, we want to check for the equality of `num`
and `0`, not *assign* 0 to `num`. This convention was inherited
from C, and it does take a bit of getting used to...

During a conditional statement, if one of the conditions is true,
this marks the end of the test: no subsequent conditions will be tested
and execution jumps to the end of the conditional.

Let's demonstrate this by adding another condition which is true.

```
% Demo script to illustrate use of conditionals
num = 53;

if num > 0
    disp('num is positive')
elseif num == 0
    disp('num is zero')
elseif num > 50
    % This block will never be executed
    disp('num is greater than 50')
else
    disp('num is negative')
end
```
{: .language-matlab}

We can also combine tests, using `&&` (and) and `||` (or). `&&`
is true if both tests are true:

~~~
if ((1 > 0) && (-1 > 0))
    disp('both parts are true')
else
    disp('one part is not true')
end
~~~
{: .language-matlab}

~~~
one part is not true
~~~
{: .output}

`||` is true if either test is true:

~~~
if (1 < 0) || (3 < 4)
    disp('at least one part is true')
end
~~~
{: .language-matlab}

~~~
at least one part is true
~~~
{: .output}

In this case, "either" means "either or both", not
"either one or the other but not both".

> ## True and False Statements
>
> The conditions we have tested above evaluate to a logical value:
> `true` or `false`.
> However these numerical comparison tests aren't the only values
> which are `true` or `false` in MATLAB.
> For example, `1` is considered `true` and `0` is considered `false`.
> In fact, *any* value can be used in a conditional statement.
>
> Run the code below in order to discover
> which values are considered `true` and which are
> considered `false`.
>
> ~~~
> if ''
>     disp('empty string is true')
> else
>     disp('empty string is false')
> end
>
> if 'foo'
>     disp('non empty string is true')
> else
>     disp('non empty string is false')
> end
>
> if []
>     disp('empty array is true')
> else
>     disp('empty array is false')
> end
>
> if [22.5, 1.0]
>     disp('non empty array is true')
> else
>     disp('non empty array is false')
> end
>
> if [0, 0]
>     disp('array of zeros is true')
> else
>     disp('array of zeros is false')
> end
>
> if true
>     disp('true is true')
> else
>     disp('true is false')
> end
> ~~~
> {: .language-matlab}
{: .challenge}

> ## Close Enough
>
> Write a script called `near` that performs a test on two variables, and displays `1`
> when the first variable is within 10% of the other
> and `0` otherwise. Compare your implementation with
> your partner's: do you get the same answer for
> all possible pairs of numbers?
>
> > ## Solution
> > ```
> > %NEAR   Display 1 if variable a is within 10% of variable b
> > %       and display 0 otherwise
> > a = 1.1;
> > b = 1.2;
> >
> > if a/b >= 0.9 && a/b <= 1.1
> >     disp(1)
> > else
> >     disp(0)
> > end
> > ```
> > {: .language-matlab}
> {: .solution}
{: .challenge}

Another thing to realize is that `if` statements can
also be combined with loops. For example, if we want
to sum the positive numbers in a list, we can write
this:

~~~
numbers = [-5, 3, 2, -1, 9, 6];
total = 0;

for n = numbers
    if n >= 0
        total = total + n;
    end
end

disp(['sum of positive values: ', num2str(total)])
~~~
{: .language-matlab}

~~~
sum of positive values: 20
~~~
{: .output}

With a little extra effort, we can calculate the
positive and negative sums in a loop:

~~~
pos_total = 0;
neg_total = 0;

for n = numbers
    if n >= 0
        pos_total = pos_total + n;
    else
        neg_total = neg_total + n;
    end
end

disp(['sum of positive values: ', num2str(pos_total)])
disp(['sum of negative values: ', num2str(neg_total)])
~~~
{: .language-matlab}

~~~
sum of positive values: 26
sum of negative values: -6
~~~
{: .output}

We can even put one loop inside another:

~~~
for number = 1:3
    for letter = 'ab'
        disp([num2str(number), letter])
    end
end
~~~
{: .language-matlab}

~~~
1a
1b
2a
2b
3a
3b
~~~
{: .output}

> ## Nesting
>
> Will changing the order of nesting in the above loop change
> the output? Why? Write down the output you might expect from
> changing the order of the loops, then rewrite the code to test
> your hypothesis.
>
> > ## Solution
> > ~~~
> > for letter = 'ab'
> >     for number = 1:3
> >         disp([num2str(number), letter])
> >     end
> > end
> > ~~~
> > {: .language-matlab}
> >
> > Reordering the nested loops changes the output. In the new code,
> > the number loop happens within the letter loop, so while letter
> > = a, number takes the values 1, 2, and 3 in turn.
> {: .solution}
{: .challenge}

Currently, our script `plot_all.m` reads in data, analyzes it,
and saves plots of the results.
If we would rather display the plots interactively,
we would have to remove (or *comment out*) the following code:

~~~
print(img_name,'-dpng')
close()
~~~
{: .language-matlab}

And, we'd also have to change this line of code, from:

~~~
figure('visible', 'off')
~~~
{: .language-matlab}

to:

~~~
figure('visible', 'on')
% or equivalently: figure()
~~~
{: .language-matlab}

This is not a lot of code to change every time,
but it's still work that's easily avoided using conditionals.
Here's our script re-written to use *conditionals*
to switch between saving plots as images and plotting them interactively:

~~~
%PLOT_ALL  Save plots of statistics to disk.
%          Use variable plot_switch to control interactive plotting
%          vs saving images to disk.
%            plot_switch = 0: show plots interactively
%            plot_switch = 1: save plots to disk

plot_switch = 0;

files = dir('data/inflammation-*.csv');

% Process each file in turn
for i = 1:length(files)
    file_name = files(i).name;

    % Generate strings for image names:
    img_name = replace(file_name, '.csv', '.png');

    % Generate path to data file and image file
    file_name = fullfile('data', filename);
    img_name  = fullfile('results', img_name);

    patient_data = readmatrix(file_name);

    % Create figures
    if plot_switch == 1
        figure('visible', 'off')
    else
        figure('visible', 'on')
    end

    subplot(2, 2, 1)
    plot(mean(patient_data, 1))
    title('Average')
    ylabel('Inflammation')
    xlabel('Day')

    subplot(2, 2, 2)
    plot(max(patient_data, [], 1))
    title('Max')
    ylabel('Inflammation')
    xlabel('Day')

    subplot(2, 2, 3)
    plot(min(patient_data, [], 1))
    title('Min')
    ylabel('Inflammation')
    xlabel('Day')

    if plot_switch == 1
        print(img_name, '-dpng')
        close()
    end

end
~~~
{: .language-matlab}
