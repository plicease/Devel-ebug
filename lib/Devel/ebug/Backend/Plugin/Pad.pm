package Devel::ebug::Backend::Plugin::Pad;

use strict;
use warnings;
use PadWalker;

# VERSION

sub register_commands {
  return ( pad => { sub => \&DB::pad } )
}

package DB;


use Scalar::Util qw(blessed reftype);
sub pad {
  my($req, $context) = @_;
  my $pad;
  my $h = eval { PadWalker::peek_my(2) };
  foreach my $k (sort keys %$h) {
    if ($k =~ /^@/) {
      my @v = eval "package $context->{package}; ($k)";
      $pad->{$k} = \@v;
    } else {
      my $v = eval "package $context->{package}; $k";
      $pad->{$k} = $v;

      # workaround for blessed globs
      $pad->{$k} = "".$v if blessed $v and reftype $v eq "GLOB";
    }
  }
  return { pad => $pad };
}


1;
