package foo;
use Apache::Restart;
sub set_config_file_thingy {
    my ($thingy_to_set) = @_;

    open(my $fh, "<", "httpd.conf") or die;
    my @lines = <$fh>;
    close $fh or die;

    foreach my $line (@lines) {
        $line =~ s/the_thingy/$thingy_to_set/msg;
    }

    open(my $fh2, ">", "httpd.conf") or die;
    print {$fh2} @lines;
    close $fh2;

    Apache::Restart::restart_the_long_way(); # Takes 2 minutes!!!
    
    return 1;
}

1;
