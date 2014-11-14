package bar;

use Apache::Restart;
sub read_apache_conf {
    open(my $fh, "<", "httpd.conf") or die;
    my @lines = <$fh>;
    close $fh or die;
    return @lines;
}

sub write_apache_conf {
    my @lines = @_;
    
    open(my $fh, ">", "httpd.conf") or die;
    print {$fh} @lines;
    close $fh;
}

sub set_config_file_thingy {
    my ($thingy_to_set) = @_;

    my @lines = read_apache_conf();

    foreach my $line (@lines) {
        $line =~ s/the_thingy/$thingy_to_set/msg;
    }

    write_apache_conf(@lines);

    Apache::Restart::restart_the_long_way(); # Takes 2 minutes!!!

    return 1;
}

1;
