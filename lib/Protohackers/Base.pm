package Protohackers::Base;

use Mojo::Base 'Exporter';

our @EXPORT_OK = qw(debug log_and_send send_response);

sub debug {
    my $msg = shift;
    warn "$msg\n";
}

sub log_and_send {
    my ($status, $resp) = @_;
    debug($status);
    debug("Sending: $resp");
    send_response($resp);
}

sub send_response {
    my $resp = shift;
    print "$resp\n";
}

1;
