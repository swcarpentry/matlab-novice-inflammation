---
layout: page
title: Programming with MATLAB
subtitle: Making Choices
minutes: 30
---

> ## Learning Objectives {.objectives}
> * Learn about if, elseif, and else
> * Learn to test equality, AND, and OR conditions
> * Learn to nest loops


Our previous lessons have shown us how to manipulate
data, define our own functions, and repeat things.
However, the programs we have written so far always do
the same things, regardless of what data they're given.
We want programs to make choices based on the values
they are manipulating.

The tool that MATLAB gives us for doing this is called
a [conditional statement](reference.html#conditional-statement),
and it looks like this:

~~~ {.matlab}
num = 37;

if num > 100
    disp('greater');
else
    disp('not greater');
end

disp('done');
~~~

~~~ {.output}
not greater
done
~~~

The second line of this code uses the keyword `if` to tell MATLAB
that we want to make a choice. If the test that follows is true,
the body of the `if` (i.e., the lines between `if` and `else`) are
executed. If the test is false, the body of the `else` (i.e.,
the lines between `else` and `end`) are executed instead. Only one
or the other is ever executed.

Conditional statements don't have to have an `else` block. If there
isn't one, MATLAB simply doesn't do anything if the test is false:

~~~ {.matlab}
num = 53
disp('before conditional...')

if num > 100:
    print '53 is greater than 100'
end

disp('...after conditional')
~~~

~~~ {.output}
before conditional...
...after conditional
~~~


We can also chain several tests together using `elseif`. This makes it
simple to write a function that returns the sign of a number:

~~~
% function sign_of.m

function out = sign_of(num)

    if num > 0
        out = 1;

    elseif num == 0
        out = 0;

    else
        out = -1;
end
~~~

One important thing to notice in the code above is that we use
a double equals sign `==` to test for equality rather than a
single equals sign. This is because the latter is used to mean
assignment. In our test, we want to check for the equality of `num`
and `0`, not *assign* 0 to `num`. This convention was inherited
from C, and it does take a bit of getting used to...

We can also combine tests, using `&&` (and) and `||` (or). `&&`
is true if both tests are true:

~~~ {.matlab}
if ((1 > 0) && (-1 > 0))
    disp('both parts are true');
else
    disp('one part is not true');
end
~~~

~~~ {.output}
one part is not true
~~~


`||` is true if either test is true:

~~~ {.matlab}
if (1 < 0) || (3 < 4)
    disp('at least one part is true');
end
~~~

~~~ {.output}
at least one part is true
~~~

In this case, "either" means "either or both", not
"either one or the other but not both".

> ## True and false statements {.challenge}
>
> 1. `1` and `0` aren't the only values
> in MATLAB that are true or false. In fact, *any* value
> can be used in an `if` or `elseif`. After reading and
> running the code below, explain what the rule is for
> which values that are considered true and which are
> considered false.
>
> a.
>
> ~~~
> if
>     disp('empty string is true')
> end
> ~~~
>
> b.
>
> ~~~
> if 'foo'
>     disp('non empty string is true')
> end
> ~~~
>
> c.
>
> ~~~
> if []
>     disp ('empty array is true')
> end
> ~~~
>
> d.
>
> ~~~
> if [22.5, 1.0]
>     disp ('non empty array is true')
> end
> ~~~
>
> e.
>
> ~~~
> if [0, 0]
>     disp ('array of zeros is true')
> end
> ~~~
>
> f.
>
> ~~~
> if true
>     disp('true is true')
> end
> ~~~
>
> 2. Write a function called `near` that returns `1`
>  when its first parameter is within 10% of its second
>  and `0` otherwise. Compare your implementation with
>  your partner's: do you return the same answer for
>  all possible pairs of numbers?


Another thing to realize is that `if` statements can
be combined with loops just as easily as they can be
combined with functions. For example, if we want
to sum the positive numbers in a list, we can write
this:

~~~ {.matlab}
numbers = [-5, 3, 2, -1, 9, 6];
total = 0;

for n = numbers
    if n >= 0
        total = total + n;
    end
end

disp(['sum of positive values: ', num2str(total)])
~~~


~~~ {.output}
sum of positive values: 20
~~~

With a little extra effort, we can calculate the
positive and negative sums in a loop:

~~~ {.matlab}
pos_total = 0;
neg_total = 0;

for n = numbers
    if n >= 0
        pos_total = total + n;
    else
        neg_total = neg_total + n;
    end
end

disp(['sum of positive values: ', num2str(pos_total)]);
disp(['sum of negative values: ', num2str(neg_total)]);
~~~

~~~ {.output}
sum of positive values: 26
sum of negative values: -6
~~~

We can even put one loop inside another:

~~~ {.matlab}
for consonant = 'bcd'
    for vowel = 'ae'
        disp (strcat(consonant, vowel));
    end
end
~~~

~~~ {.output}
ba
be
ca
ce
da
de
~~~

> ## Nesting {.challenge}
>
> 1. Will changing the order of nesting in the above loop change
> the output? Why? Write down the output you might expect from
> changing the order of the loops, then rewrite the code to test
> your hypothesis.
>
> 2. MATLAB (and most other languges in the C family) provides
> [in-place operators](reference.html#in-place-operator) that
> work like this:
>

~~~{.matlab}
x = 1;
x += 1;
x *= 3;
~~~

> Rewrite the code that sums the positive and negative values
> in an array using these in-place operators. Do you think that
> the result is more or less readable than the original?

Currently, our script `analyze.m` reads in data, analyzes it,
and saves plots of the results.
If we would rather display the plots interactively,
we would have to remove (or *comment out*) the following code:

~~~{.matlab}
print('-dpng', img_name);
close();
~~~

And, we'd also have to change this line of code, from:

~~~{.matlab}
figure('visible', 'off')
~~~

to:

~~~{.matlab}
figure('visible', 'on')
% or equivalently: figure()
~~~

This is not a lot of code to change every time,
but it's still work that's easily avoided using conditionals.
Here's our script re-written to use *conditionals*
to switch between saving plots as images and plotting them interactively:

~~~{.matlab}

% plot_switch:
%   0 - show plots interactively
%   1 - save plots to disk

plot_switch = 0;

for idx = 1:3

    % Generate strings for file and image names:
    file_name = sprintf('data/inflammation-%02d.csv', idx);
    img_name = sprintf ('patient_data-%02d.png', idx);

    patient_data = csvread(file_name);
    ave_inflammation = mean(patient_data, 1);

    if plot_switch == 1
        figure('visible', 'off')
    else
        figure('visible', 'on')
    end

    subplot(2, 2, 1);
    plot(ave_inflammation);
    ylabel('average')

    subplot(2, 2, 2);
    plot(max(patient_data, [], 1));
    ylabel('max')

    subplot(2, 2, 3);
    plot(min(patient_data, [], 1));
    ylabel('min')

    if plot_switch == 1
        print('-dpng', img_name);
        close()
    end

end
~~~
