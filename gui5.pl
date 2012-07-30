
#!/usr/local/bin/perl
use Tk;
# Main Window
my $mw = new MainWindow;

my $cns = $mw -> Canvas(-relief=>"sunken", -background=>"blue");
$cns -> create('polygon',5,100,50,5,150,5,200,100,5,100,
	-joinstyle=>"bevel", -fill=>"red", -outline=>"white", -width=>5);
$cns -> create('oval',200,100,300,200, -fill=>"green");
$cns -> create('oval',100,150,300,100, -fill=>"white", -width=>0);
$cns -> create('rectangle',10,150,100,250, -dash=>[6,4,2,4,2,4]);
$cns -> pack;

MainLoop;
