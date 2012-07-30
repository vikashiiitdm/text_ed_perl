#!/usr/local/bin/perl
use Tk; 

#global variables
my $age=10;
my $gender="Male";
my $occupied=1;

#main window
my $mw= new MainWindow;

#gui building area
my $frm_name=$mw->Frame();
my $lab=$frm_name->Label(-text=>"Name: ");
my $ent=$frm_name->Entry();

#age
my $scl=$mw->Scale(-label=>"Age : ",
			-orient=>'v',	-digit=>1,
			-from=>10,	-to=>50,
			-variable=>\$age,	-tickinterval=>10);

my $but=$mw->Button(-text=>"push me",-command=>\&push_button);
#my $qbutton=$mw->Button(-text=>"quit",-command=>sub{exit});

#jobs
my $frm_job=$mw->Frame();
my $chk=$frm_job->Checkbutton(-text=>"Occupied",
			-variable=>\$occupied);
$chk->deselect();
my $lst=$frm_job->Listbox(-selectmode=>'single');

#adding jobs
$lst->insert('end',"student","teacher","clerk","business man","militry personal","computer expert","others");


#gender
my $frm_gender=$mw->Frame();
my $lbl_gender=$frm_gender->Label(-text=>"Sex ");
my $rdb_m=$frm_gender->Radiobutton(-text=>"Male ",
			-value=>"Male", -variable=>\$gender);
my $rdb_f=$frm_gender->Radiobutton(-text=>"Female",
			-value=>"Female",-variable=>\$gender);

#text area
my $textarea=$mw->Frame();
my $txt=$textarea->Text(-width=>40,-height=>10);
my $srl_y=$textarea->Scrollbar(-orient=>'v',-command=>[yview=>$txt]);
my $srl_x=$textarea->Scrollbar(-orient=>'h',-command=>[xview=>$txt]);
$txt->configure(-yscrollcommand=>['set',$srl_y],
		-xscrollcommand=>['set',$srl_x]);
		
#geometry management		
$lab->grid(-row=>1,-column=>1);
$ent->grid(-row=>1,-column=>2);
$frm_name->grid(-row=>1,-column=>1,-columnspan=>2);
$scl->grid(-row=>2,-column=>1);
$chk->grid(-row=>2,-column=>2,-sticky=>'w');
$lst->grid(-row=>2,-column=>1);
$frm_job->grid(-row=>2,-column=>2);

$lbl_gender->grid(-row=>1,-column=>1);
$rdb_m->grid(-row=>1,-column=>2);
$rdb_f->grid(-row=>1,-column=>3);
$frm_gender->grid(-row=>3,-column=>1,-columnspan=>2);

$but->grid(-row=>4,-column=>1,-columnspan=>2);

$txt->grid(-row=>1,-column=>1);
$srl_y->grid(-row=>1,-column=>2,-sticky=>"ns");
$srl_x->grid(-row=>2,-column=>1,-sticky=>"ew");
$textarea->grid(-row=>5,-column=>1,-columnspan=>2);

MainLoop;

##functions
sub push_button{	
	my $name=$ent->get();
	$txt->insert('end',"hello, $name\($gender\), you are $age years old");}
	my $job="";
	if(occupied==1)
	{
		my $job_id=$lst->curselection();
		if($job_id eq ""){
			$job="a non worker.";
		}
		else{
			$job=$lst->get($job_id);
			$txt->insert('end', " a $job.");
		}
		
	}
	else{
		$txt->insert('end',"unemployed.");
	}
