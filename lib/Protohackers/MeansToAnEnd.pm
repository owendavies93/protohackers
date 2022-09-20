package Protohackers::MeansToAnEnd;

use Mojo::Base 'Net::Server::Fork';

use Protohackers::Base qw(debug log_and_send);

use Const::Fast;
use List::Util qw(sum);

const my $LENGTH => 9;
const my $INSERT => 'I';
const my $QUERY  => 'Q';

sub process_request {
    my $assets = {};
    my $buffer;
    while (my $num_bytes = read(STDIN, $buffer, $LENGTH)) {
        if ($num_bytes < $LENGTH) {
            debug("Not enough data");
            last;
        }

        my ($type, $f, $s) = unpack 'a N! N!', $buffer;

        if ($type eq $INSERT) {
            $assets->{$f} = $s;
        } elsif ($type eq $QUERY) {
            my @within_timespan;

            foreach my $ts (keys %$assets) {
                if ($ts >= $f && $ts <= $s) {
                    push @within_timespan, $assets->{$ts};
                }
            }

            my $mean = 0;
            if (scalar @within_timespan == 0) {
                debug('No valid prices');
            } else {
                $mean = int(sum(@within_timespan) / @within_timespan);
                debug("Found mean $mean");
            }
            print pack 'N!', $mean;
        } else {
            debug("Unknown type: $type");
            last;
        }
    }
}

1;
