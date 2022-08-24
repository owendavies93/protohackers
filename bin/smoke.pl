#!/usr/bin/env perl

use Mojo::Base -strict;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Protohackers::SmokeTest;

Protohackers::SmokeTest->run(port => 8001);

