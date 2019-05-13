---
title: Arrays
teaching: 15
exercises: 5
questions:
- "How can I access subsets of data?"
objectives:
- "Select individual values and subsections from data."
keypoints:
- "`M(row, column)` indices are used to select data points"
- "`:` is used to take slices of data"
---

## Array indexing
Let's create an 8-by-8 "magic" Matrix:

~~~
>> M = magic(8)
~~~
{: .language-matlab}

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

We want to access a single value from the matrix:

![Accessing a single value](../fig/matrix-single-element.svg)

To do that, we must provide
its [index]({{ page.root }}/reference.html#index) in parentheses:

~~~
>> M(5, 6)
~~~
{: .language-matlab}

~~~
ans = 38
~~~
{: .output}

Indices are provided as (row, column). So the index `(5, 6)` selects the element
on the fifth row and sixth column.

An index like `(5, 6)` selects a single element of
an array, but we can also access sections of the matrix, or [slices]({{ page.root }}/reference.html#slice).
To access a row of values:

![Accessing a single value](../fig/matrix-row.svg)

we can do:

~~~
>> M(5, :)
~~~
{: .language-matlab}

~~~
ans =

   32   34   35   29   28   38   39   25

~~~
{: .output}

Providing `:` as the index for a dimension selects *all* elements
along that dimension.
So, the index `(5, :)` selects
the elements on row `5`, and *all* columns---effectively, the entire row.
We can also
select multiple rows,

![Accessing multiple rows](../fig/matrix-multi-rows.svg)

~~~
>> M(1:4, :)
~~~
{: .language-matlab}

~~~
ans =

   64    2    3   61   60    6    7   57
    9   55   54   12   13   51   50   16
   17   47   46   20   21   43   42   24
   40   26   27   37   36   30   31   33
~~~
{: .output}

and columns:

![Accessing multiple columns](../fig/matrix-multi-cols.svg)

~~~
>> M(:, 6:end)
~~~
{: .language-matlab}

~~~
ans =

    6    7   57
   51   50   16
   43   42   24
   30   31   33
   38   39   25
   19   18   48
   11   10   56
   62   63    1
~~~
{: .output}

To select a submatrix,

![Accessing a submatrix](../fig/matrix-submatrix.svg)

we have to take slices in both dimensions:

~~~
>> M(4:6, 5:7)
~~~
{: .language-matlab}

~~~
ans =

   36   30   31
   28   38   39
   45   19   18

~~~
{: .output}

We don't have to take all the values in the slice---if we provide
a [stride]({{ page.root }}/reference.html#stride). Let's say we want to start with row `2`,
and subsequently select every third row:

![Accessing strided columns](../fig/matrix-strided-rows.svg)

~~~
>> M(2:3:end, :)
~~~
{: .language-matlab}

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
>> M(1:3:end, 2:2:end)
~~~
{: .language-matlab}

~~~
ans =

    2   61    6   57
   26   37   30   33
   15   52   11   56
~~~
{: .output}

> ## Slicing
>
> A subsection of an array is called a [slice]({{ page.root }}/reference.html#slice). We can take slices of character strings as well:
>
> ~~~
> >> element = 'oxygen';
> >> disp(['first three characters: ', element(1:3)])
> >> disp(['last three characters: ', element(4:6)])
> ~~~
> {: .language-matlab}
>
> ~~~
> first three characters: oxy
> last three characters: gen
> ~~~
> {: .output}
>
> 1. What is the value of `element(4:end)`? What about `element(1:2:end)`? Or `element(2:end - 1)`?
>
> 2. For any size array, MATLAB allows us to index with a single colon operator (`:`).
>    This can have surprising effects.
>    For instance, compare `element` with `element(:)`. What is `size(element)` versus `size(element(:))`?
>    Finally,
>    try using the single colon on the matrix `M` above: `M(:)`.
>    What seems to be happening when we use the single colon operator for slicing?
>
> > ## Solution
> >
> > 1. Exercises using slicing
> >
> > 	```
> > 	element(4:end)   % Select all elements from 4th to last
> > 	ans =
> > 	    'gen'
> > 	element(1:2:end) % Select every other element starting at first
> > 	ans =
> > 	    'oye
> > 	element(2:end-1) % Select elements starting with 2nd, until last-but-one
> > 	ans =
> > 	    'xyge'
> > 	```
> > 	{: .language-matlab}
> >
> > 2. The colon operator 'flattens' a vector or matrix into a column vector.
> > The order of the elements in the resulting vector comes from appending 
> > each column of the original array in turn.
> > Have a look at the order of the values in `M(:)` vs `M`
> {: .solution}
{: .challenge}

