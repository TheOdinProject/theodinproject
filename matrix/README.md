# Matrix

Given a string representing a matrix of numbers, return the rows and columns of
that matrix.

So given a string with embedded newlines like:

```text
9 8 7
5 3 2
6 6 7
```

representing this matrix:

```text
    0  1  2
  |---------
0 | 9  8  7
1 | 5  3  2
2 | 6  6  7
```

your code should be able to spit out:

- A list of the rows, reading each row left-to-right while moving
  top-to-bottom across the rows,
- A list of the columns, reading each column top-to-bottom while moving
  from left-to-right.

The rows for our example matrix:

- 9, 8, 7
- 5, 3, 2
- 6, 6, 7

And its columns:

- 9, 5, 6
- 8, 3, 6
- 7, 2, 7

* * * *

For installation and learning resources, refer to the
[Ruby resources page](http://exercism.io/languages/ruby/resources).

For running the tests provided, you will need the Minitest gem. Open a
terminal window and run the following command to install minitest:

    gem install minitest

If you would like color output, you can `require 'minitest/pride'` in
the test file, or note the alternative instruction, below, for running
the test file.

Run the tests from the exercise directory using the following command:

    ruby matrix_test.rb

To include color from the command line:

    ruby -r minitest/pride matrix_test.rb


## Source

Warmup to the `saddle-points` warmup. [http://jumpstartlab.com](http://jumpstartlab.com)

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
