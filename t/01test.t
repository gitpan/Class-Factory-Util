use strict;

use Test;

plan tests => 4;

require Class::Factory::Util;

ok(1);

use lib 'lib', 't/lib';

use Factory;

my @s = sort Factory->subclasses;

ok( scalar @s, 2 );

ok( $s[0], 'Bar' );
ok( $s[1], 'Foo' );
