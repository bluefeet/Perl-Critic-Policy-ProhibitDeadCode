#!/usr/bin/env perl
use 5.008001;
use strict;
use warnings;
use Test2::V0;

use Perl::Critic;

my @tests = (
    [GoodExits      => 1],
    [BadExitRuntime => 0],
);

foreach my $test (@tests) {
    my ($package, $expected_ok) = @$test;

    my $file = "t/$package.pm";
    my $critic = Perl::Critic->new(
        '-single-policy' => 'ProhibitDeadCode',
    );
    my @violations = $critic->critique($file);

    if ($expected_ok) {
        ok(
            (@violations == 0),
            "$package should NOT violate",
        );
    }
    else {
        ok(
            (@violations > 0),
            "$package should violate",
        );
    }
}

done_testing;
