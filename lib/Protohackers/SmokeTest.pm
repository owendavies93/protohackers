package Protohackers::SmokeTest;

use Mojo::Base -strict;

use base 'Net::Server';

sub process_request {
    print while <STDIN>;
}

1;

