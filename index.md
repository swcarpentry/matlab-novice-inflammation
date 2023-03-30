---
layout: lesson
root: .
permalink: index.html
---

The best way to learn how to program is to do something useful, so this
introduction to [MATLAB](https://en.wikipedia.org/wiki/MATLAB) is built around a common scientific task: data analysis.
Our real goal isn't to teach you MATLAB, but to teach you the basic concepts
that all programming depends on. We use MATLAB in our lessons because:

1. we have to use *something* for examples;
2. it's well-documented;
3. it has a large (and growing) user base among scientists in academia and industry; and
4. it has a large library of packages available for performing diverse tasks.

But the two most important things are to use whatever language your colleagues
are using, so that you can share your work with them easily, and to use that
language *well*.

### Introductory slides

Some slides to introduce the training can be found [here]({{ page.root }} /files/intro_slides.pdf).

> ## GNU Octave
>
> [GNU Octave](http://www.gnu.org/software/octave/) is a free and open-source alternative
> to MATLAB which shares its syntax ([see more about compatibility](http://en.wikipedia.org/wiki/GNU_Octave#MATLAB_compatibility)).
> Thus, if you don't have access to MATLAB, you can easily set up Octave
> on your computer and still work through the lesson.
{: .callout}

> ## Prerequisites
>
> To begin tackling this lesson, you will need to:
>
> * Understand the concepts of files and directories, and the concept of a "working directory".
> * Know how to start up MATLAB, and access the *command window* (which generally has a `>>` prompt).
> * Know how to create, edit and save text files.
{: .prereq}

## Overview of the data
We are studying inflammation in patients who have been given a new treatment for arthritis,
and need to analyze the first dozen data sets.
The data sets are stored in
[Comma Separated Values (CSV)]({{ page.root }}/reference.html#comma-separated-values) format:
each row holds information for a single patient,
and the columns represent successive days.
The first few rows of our first file,
[`inflammation-01.csv`]({{ page.root }}/data/matlab-novice-inflammation/data/inflammation-01.csv), look like this:

```
0,0,1,3,1,2,4,7,8,3,3,3,10,5,7,4,7,7,12,18,6,13,11,11,7,7,4,6,8,8,4,4,5,7,3,4,2,3,0,0
0,1,2,1,2,1,3,2,2,6,10,11,5,9,4,4,7,16,8,6,18,4,12,5,12,7,11,5,11,3,3,5,4,4,5,5,1,1,0,1
0,1,1,3,3,2,6,2,5,9,5,7,4,5,4,15,5,11,9,10,19,14,12,17,7,12,11,7,4,2,10,5,4,2,2,3,2,2,1,1
0,0,2,0,4,2,2,1,6,7,10,7,9,13,8,8,15,10,10,7,17,4,4,7,6,15,6,4,9,11,3,5,6,3,3,4,2,3,2,1
0,1,1,3,3,1,3,5,2,4,4,7,6,5,3,10,8,10,6,17,9,14,9,7,13,9,12,6,7,7,9,6,3,2,2,4,2,0,1,1
```

We want to:

* load that data into memory,
* calculate the average inflammation per day across all patients, and
* plot the result.

To do all that, we'll have to learn a little bit about programming.
