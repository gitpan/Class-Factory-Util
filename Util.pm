package Class::Factory::Util;
use strict;
use vars qw($VERSION);

use Carp qw(confess);

$VERSION = sprintf '%s', q$Revision: 1.2 $ =~ /Revision:\s+(.*)/;

1;

sub subclasses
{
    my $base = shift;

    $base =~ s,::,/,g;
    $base .= '.pm';

    # remove '.pm'
    my $dir = substr( $INC{$base}, 0, (length $INC{$base}) - 3 );

    opendir DIR, $dir
	or confess ("Cannot open directory $dir: $!");

    my @packages = map { substr($_, 0, length($_) - 3) } grep { substr($_, -3) eq '.pm' && -f "$dir/$_" } readdir DIR;

    closedir DIR
	or confess("Cannot close directory $dir: $!" );

    return @packages;
}

__END__

=head1 NAME

Class::Factory::Util - Utility functions for (factory) classes

=head1 SYNOPSIS

  use Class::Util;

  My::Class->subclasses; 

=head1 DESCRIPTION

This module is part of an effort to take functionality within Alzabo which
has general utility and make it available outside of the Alzabo framework.

=head1 FUNCTIONS

=head2 subclasses ($package_name)

Given a package name, finds the available subclasses for that package. 
It does this by looking for all files which are in directories below the
directory of C<$package_name>.

You should know that direct object syntax:

  My::Package->subclasses;

actually sends in the package name and is thus the same as:

  Class::Util::subclasses('My::Package');

=head1 AUTHOR

Dave Rolsky, <autarch@urth.org>. 

Salvaged from the dumping grounds by
Terrence Brannon, <tbone@cpan.org>.

=cut
