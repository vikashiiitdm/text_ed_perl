#!/usr/local/bin/perl
use Tk;
# Main Window
$mw = new MainWindow;

my $lab = $mw -> Label(-text=>"This is the root window.",
		-font=>"ansi 12 bold") -> pack;
my $but = $mw -> Button(-text=>"Click to Create Toplevel", 
		-command=>\&makeTop)  -> pack;

MainLoop;

#A function to make a toplevel window
sub makeTop {
	my $top = $mw -> Toplevel(); #Make the window
	#Put things in it
	my $top_lab = $top -> Label(-text=>"This is the Toplevel window.",
			-font=>"ansi 12 bold") -> pack;
	my $txt = $top -> Text() -> pack;
	$txt -> insert('end', "Widgets can be packed in this window.");
	
	#An option to close the window.
	my $but_close = $top -> Button(-text=>"Close", 
		-command => sub { destroy $top; } ) -> pack;
}
