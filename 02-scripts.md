---
layout: page
title: Writing MATLAB Scripts
---

> ## Learning Objectives
> * Learn how to write and save MATLAB scripts.
> * Learn how to save MATLBA plots to disk.

So far, we've typed in commands one-by-one on the command line
to get MATLAB to do things for us. But what if we want to repeat
our analysis? Sure, it's only a handful of commands,
and typing them in shouldn't take
us more than a few minutes. But if we forget a step or make a mistake,
we'll waste time rewriting commands. Also, we'll quickly find ourselves
doing more complex analyses, and we'll need our results to
be more easily reproducible.

In addition to running MATLAB commands one-by-one on the
command line, we can
also write several commands in a _script_. A MATLAB script
is just a text file with a `.m` extension. We've written
commands to load data from a `.csv` file and
displays some statistics about that data. Let's
put those commands in a script called `analyze.m`:

~~~{.matlab}
% script analyze.m

patient_data = csvread('inflammation-01.csv');

disp(['Analyzing "inflammation-01.csv": '])
disp(['Maximum inflammation: ', num2str(max(patient_data(:)))]);
disp(['Minimum inflammation: ', num2str(min(patient_data(:)))]);
disp(['Standard deviation: ', num2str(std(patient_data(:)))]);
~~~

Before we can use it, we need to make sure that this file is
visible to MATLAB. MATLAB doesn't know about all the files on your
computer, but it keeps an eye on several directories.
The most convenient of these directories is generally the
"working directory", or "current directory". To find out the
working directory, use the `pwd` command:

~~~{.matlab}
pwd
~~~

As you might have guessed, `pwd` stands for "print working directory".

Once you have a script saved in a location that MATLAB knows about,
you can get MATLAB to run those commands by typing in the name
of the script (without the `.m`) in the MATLAB command line:

~~~{.matlab}
analyze
~~~

~~~{.matlab}
Maximum inflammation: 20
Minimum inflammation: 0
Standard deviation: 4.7219
~~~

We've also written commands to create plots:

~~~{.matlab}
ave_inflammation = mean(patient_data, 1);

plot(ave_inflammation);
ylabel('average')
~~~

MATLAB let's us save those as
images on disk:

~~~{.matlab}
% save plot to disk as png image:
print -dpng 'average.png'
~~~

You might have noticed that we described what we want 
our code to do using the `%`-sign.
This is another plus of writing scripts: you can comment
your code to make it easier to understand when you come
back to it after a while. 

Let's extend our `analyze` script with commands to
create and save plots:

~~~{.matlab}
% script analyze.m

patient_data = csvread('inflammation-01.csv');

disp(['Maximum inflammation: ', num2str(max(patient_data(:)))]);
disp(['Minimum inflammation: ', num2str(min(patient_data(:)))]);
disp(['Standard deviation: ', num2str(std(patient_data(:)))]);

ave_inflammation = mean(patient_data, 1);

subplot(1, 3, 1);
plot(ave_inflammation);
ylabel('average')

subplot(1, 3, 2);
plot(max(patient_data, [], 1));
ylabel('max')

subplot(1, 3, 3);
plot(min(patient_data, [], 1));
ylabel('min')

% save plot to disk as png image:
print -dpng 'patient_data-01.png'
~~~