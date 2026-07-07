package Tokens;

sub new {
    my ($class, $tokens) = @_;
    return bless{name => $tokens}, $class
}
# check existence of vars
# argue the variable you want to check
sub checkVars {
    my $self = shift;
    my $varToCheck = shift;
    # map all variable tokens to foundVars; then check for emptiness
    my @foundVars = grep {$_->{type} eq 'variable'} @{$self->{name}};
    if (@foundVars == 0) {
        return 0;
    }
    # match every var in @foundVars to $patterns, then grab $1 (var name) and compare against $varToCheck
    return 0 unless grep {$_ =~ $patterns->{variable} && $+{var_name} eq $varToCheck} @foundVars;
}

1;