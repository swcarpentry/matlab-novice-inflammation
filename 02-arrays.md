---
title: Arrays
teaching: 15
exercises: 5
---

::::::::::::::::::::::::::::::::::::::: objectives

- Select individual values and subsections from data.

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: questions

- How can I access subsets of data?

::::::::::::::::::::::::::::::::::::::::::::::::::

## Array indexing

Now that we understand what kind of data can be stored in an array,
we need to learn the proper syntax for working with arrays in MATLAB.
To do this we will begin by discussing array **indexing**, which is the
method by which we can select one or more different elements of an
array. A solid understanding of array indexing will greatly assist
our ability to organize our data.

Let's start by creating an 8-by-8 "magic" Matrix:

```matlab
>> M = magic(8)
```

```output
ans =

   64    2    3   61   60    6    7   57
    9   55   54   12   13   51   50   16
   17   47   46   20   21   43   42   24
   40   26   27   37   36   30   31   33
   32   34   35   29   28   38   39   25
   41   23   22   44   45   19   18   48
   49   15   14   52   53   11   10   56
    8   58   59    5    4   62   63    1
```

We want to access a single value from the matrix:

![](fig/matrix-single-element.svg){alt='Accessing a single value'}

To do that, we must provide
its [index](../learners/reference.md#index) in parentheses:

```matlab
>> M(5, 6)
```

```output
ans = 38
```

Indices are provided as (row, column). So the index `(5, 6)` selects the element
on the fifth row and sixth column.

An index like `(5, 6)` selects a single element of
an array, but we can also access sections of the matrix, or [slices](../learners/reference.md#slice).
To access a row of values:

![](fig/matrix-row.svg){alt='Accessing a single value'}

we can do:

```matlab
>> M(5, :)
```

```output
ans =

   32   34   35   29   28   38   39   25

```

Providing `:` as the index for a dimension selects *all* elements
along that dimension.
So, the index `(5, :)` selects
the elements on row `5`, and *all* columns---effectively, the entire row.
We can also
select multiple rows,

![](fig/matrix-multi-rows.svg){alt='Accessing multiple rows'}

```matlab
>> M(1:4, :)
```

```output
ans =

   64    2    3   61   60    6    7   57
    9   55   54   12   13   51   50   16
   17   47   46   20   21   43   42   24
   40   26   27   37   36   30   31   33
```

and columns:

![](fig/matrix-multi-cols.svg){alt='Accessing multiple columns'}

```matlab
>> M(:, 6:end)
```

```output
ans =

    6    7   57
   51   50   16
   43   42   24
   30   31   33
   38   39   25
   19   18   48
   11   10   56
   62   63    1
```

To select a submatrix,

![](fig/matrix-submatrix.svg){alt='Accessing a submatrix'}

we have to take slices in both dimensions:

```matlab
>> M(4:6, 5:7)
```

```output
ans =

   36   30   31
   28   38   39
   45   19   18

```

We don't have to take all the values in the slice---if we provide
a [stride](../learners/reference.md#stride). Let's say we want to start with row `2`,
and subsequently select every third row:

![](fig/matrix-strided-rows.svg){alt='Accessing strided columns'}

```matlab
>> M(2:3:end, :)
```

```output
ans =

    9   55   54   12   13   51   50   16
   32   34   35   29   28   38   39   25
    8   58   59    5    4   62   63    1
```

And we can also select values in a "checkerboard",

![](fig/matrix-strided-rowncols.svg){alt='Accessing strided rows and columns'}

by taking appropriate strides in both dimensions:

```matlab
>> M(1:3:end, 2:2:end)
```

```output
ans =

    2   61    6   57
   26   37   30   33
   15   52   11   56
```

:::::::::::::::::::::::::::::::::::::::  challenge

## Slicing

A subsection of an array is called a [slice](../learners/reference.md#slice). We can take slices of character strings as well:

```matlab
>> element = 'oxygen';
>> disp(['first three characters: ', element(1:3)])
>> disp(['last three characters: ', element(4:6)])
```

```output
first three characters: oxy
last three characters: gen
```

1. What is the value of `element(4:end)`? What about `element(1:2:end)`? Or `element(2:end - 1)`?

2. For any size array, MATLAB allows us to index with a single colon operator (`:`).
  This can have surprising effects.
  For instance, compare `element` with `element(:)`. What is `size(element)` versus `size(element(:))`?
  Finally,
  try using the single colon on the matrix `M` above: `M(:)`.
  What seems to be happening when we use the single colon operator for slicing?

:::::::::::::::  solution

## Solution

1. Exercises using slicing
  
  ```matlab
  element(4:end)   % Select all elements from 4th to last
  ans =
      'gen'
  element(1:2:end) % Select every other element starting at first
  ans =
      'oye'
  element(2:end-1) % Select elements starting with 2nd, until last-but-one
  ans =
      'xyge'
  ```

2. The colon operator 'flattens' a vector or matrix into a column vector.
  The order of the elements in the resulting vector comes from appending
  each column of the original array in turn.
  Have a look at the order of the values in `M(:)` vs `M`
  
  

:::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::: keypoints

- `M(row, column)` indices are used to select data points
- `:` is used to take slices of data

::::::::::::::::::::::::::::::::::::::::::::::::::


