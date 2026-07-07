#!/usr/bin/perl

use strict; use warnings;
use feature 'say';
use List::Util qw(first);



our $patterns = {
    throw => qr/throw\s+(?<event_name>[a-zA-Z_]+)(\{?)(\}?)/, # throw eventName {} -- should handle what goes between the curly brackets
    catch => qr/catch\s+(?<event_catching>[a-zA-Z_]+)(\{?)(\}?)/, # catch eventName {} -- same problem as throw
    pocket => qr/pocket\s+(?<event_catching>[a-zA-Z_]+)(\{?)/, #
    variable => qr/my\s+(?<var_name>[a-zA-Z0-9_]+)->("|')(?<var_value>[a-zA-Z0-9_]|(true|false))("|')/, # my variable -> "variable" || my variable -> 'variable' (only string/integer/bool assignment allowed)
    spitball => qr/spitball([a-zA-Z_]+)/,
    conditional => qr/if(?<given>[a-zA-Z0-9_]+)is(?<when>[a-zA-Z0-9_]|(true|false))("|')/,
    delegate => qr/hire([a-zA-Z_]+)/
};

my @all_tokens;

# CLI for now, terminal version will come out later.
say 'File to parse:';
chomp(my $gotFile = <STDIN>);

open(my $fileh, '<', $gotFile) or die $!;

while (my $line = <$fileh>) {
    chomp($line);
    my $matchedPattern = first {{$line =~ $patterns->{$_}} keys %{$patterns}};
        
    if ($matchedPattern) {
        push @all_tokens, {
            type => $matchedPattern, contents => $line
        };
    }
}

close($fileh);

die 'No valid spitz was detected in the given file ' . $gotFile . "\n" unless @all_tokens;

use lib '.';
use Tokens;

our $mega_tokens = Tokens->new(\@all_tokens);
$mega_tokens->checkVars('someVariable');