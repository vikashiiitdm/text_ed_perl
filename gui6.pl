use Tk;
use Tk::Adjuster;
my $mw = new MainWindow;

my $adj = $mw -> Adjuster();
my $lst = $mw -> Listbox();
$lst -> insert('end', "Item 1");
$lst -> insert('end', "Item 2");
$lst -> insert('end', "Item 3");
$lst -> insert('end', "Item 4");
$lst -> insert('end', "Item 5");

my $txt = $mw -> Scrolled("Text",-scrollbars=>'e');
$txt -> insert('end',"To Hack With It

     To Compute...
     Or Not To Compute...
     That Is The Question...
     Whether 'Tis Nobler In The Memory Bank..
     To Suffer The Slings And Circuits Of Outrageous Functions...
     ...Or To Take Up Arms Against A Sea Of..Transistors,
     Or Rather Transponders...
     Transcondu--
     Trans...
     Er...           Oh, To Hack With It.");


my $side = "left";
$lst -> pack(-side => $side, -fill => 'both', -expand => 1);
$adj -> packAfter($lst, -side => $side);
$txt -> pack(-side => $side, -fill => 'both', -expand => 1);

MainLoop;
