Word Chains Kata
=================

_AustinRB, June 2014_

For this Kata, your goal is to write a program that can solve a word chain puzzle.

Thanks go to Dave Thomas (@PragDave) for today's inspiration: [http://codekata.com/kata/kata19-word-chains/](http://codekata.com/kata/kata19-word-chains/)

The framework has already been built for you, so you can concentrate on the logic. Use the framework if you like, or throw it out and start from scratch!

## Getting the code

Checkout this repo, and switch to this branch:

    git clone git@github.com:atharrison/cli-template-ruby.git
    git checkout ah/word-chains

Alternately, simply fork the repo and branch into your own workspace.


## Using the supplied framework

Place your logic in `lib/solver.rb`. A new `WordChains::Solver` will be created, and `#solution` will be called to get the results.

Run the program with `./bin/word_chains`

## Example:

    >./bin/word_chains solve -s cat -e dog
    cat
    cot
    cog
    dog
