package Protohackers::SmokeTest;

use Mojo::Base 'Net::Server::Fork';

sub process_request {
    print while <STDIN>;
}

1;
