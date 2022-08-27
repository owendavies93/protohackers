#!/usr/bin/env perl

use Mojo::Base -strict;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Protohackers::PrimeTime;

Protohackers::PrimeTime->run(port => 8001);

