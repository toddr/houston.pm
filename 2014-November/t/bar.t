#!perl -w

use strict;
use warnings;

use Test::More;
use Test::MockModule;

use bar;


my $apache_restarted = 0;
my $module = new Test::MockModule('Apache::Restart');
$module->mock('restart_the_long_way', sub { $apache_restarted++ });

my $module2 = new Test::MockModule('bar');

my $test_file = "this the_thingy is\n" . "foo\n" . "bar\n";
$module2->mock('read_apache_conf', sub { return $test_file });
$module2->mock('write_apache_conf', sub { $test_file = shift; });

bar::set_config_file_thingy("dog");
is(bar::read_apache_conf(), "this dog is\nfoo\nbar\n", "Wrote the right thing to the file");
is($apache_restarted, 1, "Apache woulda restarted");

bar::write_apache_conf("the_thingy");
bar::set_config_file_thingy("cat");
is(bar::read_apache_conf(), "cat", "Wrote the right thing to the file the second time.");
is($apache_restarted, 2, "Apache woulda restarted");


done_testing();
