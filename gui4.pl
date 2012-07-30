#!/usr/local/bin/perl
use Tk;
# Main Window
$mw = new MainWindow;

my $var;
my $opt = $mw -> Optionmenu(-options => [qw(January February March April)],
        -command => sub { print "got: ", shift, "\n" },
        -variable => \$var,
        )->pack;
$opt->addOptions([May=>5],[June=>6],[July=>7],[Augest=>8]);

$mw->Label(-textvariable=>\$var, -relief=>'groove')->pack;
$mw->Button(-text=>'Exit', -command=>sub{$mw->destroy})->pack;

MainLoop;
