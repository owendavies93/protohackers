package Protohackers::PrimeTime;

use Mojo::Base -strict;
use base 'Net::Server::Fork';

use Const::Fast;
use JSON::XS;
use Math::Primality qw(is_prime);
use Scalar::Util qw(looks_like_number);
use Try::Tiny;

const my $ISPRIME   => 'isPrime';
const my $MALFORMED => 'malformed';

sub process_request {
    my $self = shift;

    while(my $line = <STDIN>) {
        $line =~ s/\r?\n$//;
        warn "received $line\n";
        my $malformed = 0;

        try {
            my $j = decode_json($line);

            if (!defined $j->{method} || !defined $j->{number}) {
                log_and_send('missing fields', $MALFORMED);
                $malformed = 1;
            } elsif ($j->{method} ne $ISPRIME) {
                log_and_send('wrong method', $MALFORMED);
                $malformed = 1;
            } elsif (!looks_like_number($j->{number})) {
                log_and_send('not a number', $MALFORMED);
                $malformed = 1;
            } elsif (!defined $j->{bignumber} && !isNumber($j->{number})) {
                log_and_send('number not encoded as a number', $MALFORMED);
                $malformed = 1;
            } elsif ($j->{number} =~ /\./ || !is_prime($j->{number})) {
                log_and_send('not prime', encode_json {
                    'method' => $ISPRIME,
                    'prime' => \0,
                });
            } else {
                log_and_send('prime', encode_json {
                    'method' => $ISPRIME,
                    'prime' => \1,
                });
            }
        } catch {
            log_and_send($!, $MALFORMED);
            $malformed = 1;
        };

        last if $malformed == 1;
    }
}

sub isNumber {
    no warnings "numeric";
    return length($_[0] & "");
}

sub log_and_send {
    my ($status, $response) = @_;
    warn "$status\n";
    warn "sending repsonse: $response\n";
    print "$response\n";
}

1;

