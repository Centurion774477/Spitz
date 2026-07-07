#!/usr/bin/perl

use strict; use warnings;
use feature 'say';

sub parse {
    do("spitz_tokenizer.pl");
    say 'successfully lexed. now parsing . . .';
    # execute the other files once finished
    say 'Unable to finish parsing: Spitz is a work in progress.'
}

sub documentation {
    open(my $file, '<', "spitzDocs.txt") or die 'failed to provide documentation' . "\n";
    while (my $line = <$file>) {
        say $line;
    }
    close($file);
}

sub exit {
    say 'Goodbye!';
    exit;
}

while {
    say "
    Welcome to Spitz!
    Actions:
    1 -> Parse a file
    2 -> View Documentation
    3 -> Exit
    What would you like to do?
    "
    chomp(my $input = <STDIN>);

    if ($input eq '1') {
        parse();
    } elsif ($input eq '2') {
        documentation();
    } elsif ($input eq '3') {
       exit();
    }
} while (1)