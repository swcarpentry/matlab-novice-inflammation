---
title: Writing MATLAB Scripts
teaching: 35
exercises: 0
questions:
- "How can I save and re-use my programs?"
objectives:
- "Write and save MATLAB scripts."
- "Save MATLAB plots to disk."
keypoints:
- "Save MATLAB code in files with a `.m` suffix."
---

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
display some plots of statistics about that data. Let's
put those commands in a script called `plot_patient1.m`,
which we'll save in our current directory,`matlab-novice-inflammation`.

To create a new script in the current directory, we use
```
edit plot_patient1.m
```
{: .language-matlab}

then we type the contents of the script:

~~~
patient_data = readmatrix('data/inflammation-01.csv');

% Plot average inflammation per day
figure
plot(mean(patient_data, 1))
title('Daily average inflammation')
xlabel('Day of trial')
ylabel('Inflammation')
~~~
{: .language-matlab}

Note that we are explicitly creating a new figure window using the `figure` command.

Try this on the command line:

~~~
figure
~~~
{: .language-matlab}

MATLAB's plotting commands only create a new figure window if one doesn't already exist:
the default behaviour is to reuse the current figure window as we saw in the previous episode.
Explicitly creating a new figure window in the script avoids any unexpected results from
plotting on top of existing figures.

You can get MATLAB to run the commands in the script by typing in the name
of the script (without the `.m`) in the MATLAB command line:

~~~
plot_patient1
~~~
{: .language-matlab}


> ## The MATLAB path
> MATLAB knows about files in the current directory, but if we want to
> run a script saved in a different location, we need to make sure that
> this file is visible to MATLAB.
> We do this by adding directories to the MATLAB **path**.
> The *path* is a list of directories MATLAB will search through to locate
> files.
>
> To add a directory to the MATLAB path,
> we go to the `Home` tab,
> click on `Set Path`,
> and then on `Add with Subfolders...`.
> We navigate to the directory and
> add it to the path to tell MATLAB where to look for our files. When you refer
> to a file (either code or data), MATLAB will search all the directories in the path
> to find it. Alternatively, for data files, we can provide the relative or
> absolute file path.
{: .callout}

> ## GNU Octave
>
> Octave has only recently gained a MATLAB-like user interface. To change the
> path in any version of Octave, including command-line-only installations, use
> `addpath('path/to/directory')`
{: .callout}

In this script,
let's save the figures to disk as image files using the `print` command.
In order to maintain an organised project we'll save the images
in the `results` directory:

~~~
% Plot average inflammation per day
figure
plot(mean(patient_data, 1))
title('Daily average inflammation')
xlabel('Day of trial')
ylabel('Inflammation')

% Save plot in 'results' folder as png image:
print('results/average','-dpng')
~~~
{: .language-matlab}

> ## Help text
> You might have noticed that we described what we want
> our code to do using the percent sign: `%`.
> This is another plus of writing scripts: you can comment
> your code to make it easier to understand when you come
> back to it after a while.
>
> A comment can appear on any line, but be aware that the first line
> or block of comments in a script or function is used by MATLAB as the
> **help text**.
> When we use the `help` command, MATLAB returns the *help text*.
> The first help text line (known as the **H1 line**)
> typically includes the name of the program, and a brief description.
> The `help` command works in just the same way for our own programs as for
> built-in MATLAB functions.
> You should write help text for all of your own scripts and functions.
{: .callout}

Let's write an H1 line at the top of our script:

```
%PLOT_PATIENT1   Save plots of inflammation statistics to disk.
```
{: .language-matlab}

We can then get help for our script by running

```
help plot_patient1
```
{: .language-matlab}

Let's modify our `plot_patient1` script so that it creates and saves sub-plots,
rather than individual plots.
As before we'll save the images in the `results` directory.

~~~
%PLOT_PATIENT1   Save plots of inflammation statistics to disk.

patient_data = readmatrix('data/inflammation-01.csv');

% Plot inflammation stats for first patient
figure
subplot(1, 3, 1)
plot(mean(patient_data, 1))
title('Average')
ylabel('Inflammation')
xlabel('Day')

subplot(1, 3, 2)
plot(max(patient_data, [], 1))
title('Max')
ylabel('Inflammation')
xlabel('Day')

subplot(1, 3, 3)
plot(min(patient_data, [], 1))
title('Min')
ylabel('Inflammation')
xlabel('Day')

% Save plot in 'results' directory as png image.
print('results/inflammation-01','-dpng')
~~~
{: .language-matlab}

When saving plots to disk,
it's sometimes useful to turn off their visibility as MATLAB plots them.
For example, we might not want to view (or spend time closing) the figures in MATLAB, and
not displaying the figures could make the script run faster.

Let's add a couple of lines of code to do this:

~~~
%PLOT_PATIENT1   Save plots of inflammation statistics to disk.

patient_data = readmatrix('data/inflammation-01.csv');

% Plot inflammation stats for first patient
figure('visible', 'off')

subplot(1, 3, 1)
plot(mean(patient_data, 1))
title('Average')
ylabel('inflammation')
xlabel('Day')

subplot(1, 3, 2)
plot(max(patient_data, [], 1))
title('Max')
ylabel('Inflammation')
xlabel('Day')

subplot(1, 3, 3)
plot(min(patient_data, [], 1))
title('Min')
ylabel('Inflammation')
xlabel('Day')

% Save plot in 'results' directory as png image.
print('results/inflammation-01','-dpng')

close()
~~~
{: .language-matlab}

We can ask MATLAB to create an empty figure window without
displaying it by setting its `'visible'` property to `'off'`, like so:

~~~
figure('visible', 'off')
~~~
{: .language-matlab}

When we do this, we have to be careful to manually "close" the figure
after we are doing plotting on it - the same as we would "close"
an actual figure window if it were open:

~~~
close()
~~~
{: .language-matlab}
