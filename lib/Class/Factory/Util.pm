package Class::Factory::Util;

use strict;
use vars qw($VERSION);

use Carp qw(confess);

$VERSION = '1.3';

1;

sub import
{
    my $caller = caller(0);

    {
        no strict 'refs';
        *{"${caller}::subclasses"} = \&_subclasses;
    }
}

sub _subclasses
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

Class::Factory::Util - Provide utility methods for factory classes

=head1 SYNOPSIS

  package My::Class;

  use Class::Util;

  My::Class->subclasses;

=head1 DESCRIPTION

This module contains methods that are useful for factory classes.

=head1 USAGE

When this module is loaded, it creates a method in its caller named
C<subclasses()>.  This method returns a list of the available
subclasses for the package.  It does this by looking in the library
directory containing the caller, and finding any modules in its
immediate subdirectories.

So if you have the modules "Foo::Base", "Foo::Base::Bar", and
"Foo::Base::Baz", then the return value of C<< Foo::Base->subclasses()
>> would be "Bar" and "Baz".

=head1 AUTHOR

Dave Rolsky, <autarch@urth.org>.

Removed from Alzabo and packaged by Terrence Brannon,
<tbone@cpan.org>.

=cut
