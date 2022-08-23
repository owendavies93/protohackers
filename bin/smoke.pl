#!/usr/bin/env perl

use Mojo::Base -strict;

use IO::Socket;

my $s = IO::Socket::INET->new(
    LocalPort => 8001,
    Listen    => 1,
    Proto     => 'tcp',
    Reuse     => 1,
) or die "start: $!";

say "starting";

while (1) {
    my $c = $s->accept() or die "accept: $!";
    my $pid = fork and next;

    # child
    die "fork: $!" if !defined $pid;

    say "incoming";
    print $c $_ while (<$c>);
    say "eof";

    last;
}

say "done"
