use strict;
use warnings;

use Test::More tests => 6;

BEGIN {
    use_ok('Module::Mask');
}

use lib qw( t/lib );

{
    my $mask = new Module::Mask::Inverted qw( Module::Mask );

    ok($mask->is_masked('Dummy'), 'Dummy is masked');

    my $line = __LINE__; eval { require Dummy };
    my $file = __FILE__;
    like($@, qr(^Couldn't locate Dummy.pm in \@INC), 'Dummy was masked');
    like($@, qr(line\s+\Q$line\E), 'line number correct');
    like($@, qr(at\s+\Q$file\E), 'file name correct');

    eval { require Dummy };
    ok($@, 'second time still dies');
}

__END__

vim: ft=perl
