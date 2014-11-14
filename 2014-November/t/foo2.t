#!perl -w

use strict;
use warnings;

use Test::More;
use Test::MockModule;

use foo;

open(my $fh, ">", "httpd.conf");
print $fh "this the_thingy is\n";
print $fh "foo\n";
print $fh "bar\n";
close $fh;

my $module = new Test::MockModule('Apache::Restart');
$module->mock('restart_the_long_way', sub { 1; });
foo::set_config_file_thingy("dog");

open(my $fh2, "<", "httpd.conf");
is(<$fh2>, "this dog is\n", "Test the replacement worked!");

done_testing();
