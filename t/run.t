#!perl
use strict;
use warnings;
use lib 'lib';
use Test::More tests => 3;
use Devel::ebug;

my $ebug = Devel::ebug->new;
$ebug->program("corpus/calc.pl");
$ebug->load;
is($ebug->line, 3);
$ebug->step;
$ebug->step;
$ebug->step;
is($ebug->line, 12);
$ebug->run;
ok($ebug->finished);
my($stdout, $stderr) = $ebug->output;

