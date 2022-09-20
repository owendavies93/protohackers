#!/usr/bin/env perl

use Mojo::Base -strict;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Protohackers::MeansToAnEnd;

Protohackers::MeansToAnEnd->run(port => 8001);

