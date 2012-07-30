#!perl -w
use Wx;
#######################################
#
#
package MyApp;
#
#
#######################################
use strict;
use vars qw(@ISA);
@ISA = qw(Wx::App);
# the OnInit method is called
sub OnInit {
    my($this) = @_;
    #
    # the constructor for our frame.
    #
    # although I chose to use 3 parameters in this construction, there's a
    # total of 7 parameters that may be used.
    #
    #  wx::Frame->new (parent,
    #       id,
    #       title,
    #       position,
    #       size,
    #       window style,
    #       window name)
    #
    #   the parent is a reference to a wxFrame which will be the parent of the
    #   new frame. Setting this value to undef indicated this is a top-level
    #   frame in the application.
    #
    #   The ID is an integer that gives the application an identity to windows
    #
    #   The title is just that -- what appears in the title bar of the app.
    #
    #   The optional parameters :
    #
    #   The position is an anonymous array of 2 values indicating the point
    #   where the application till appear on screen. [0,0] is the upper left
    #   portion of the screen. To specify a default position, use [-1,-1].
    #   If position is not specified, [-1,-1] is used
    #
    #   Size determines the dimensions that the window will occupy in . Again,
    #   this is an array of 2 values, with [-1, -1] specifying a default size.
    #   If size is not specified, [-1,-1] is used
    #
    #   The window style lets the designer choose from a variety of options
    #   that will determine what options the frame will possess.
    #   These can be used to keep users from minimizing or maximizing an
    #   application
    #   The default is wxDEFAULT_FRAME_STYLE. The table below is from wxWindows'
    #   documentation.
    #
    #     wxDEFAULT_FRAME_STYLE  Defined as wxMINIMIZE_BOX | wxMAXIMIZE_BOX | wxRESIZE_BOX | wxSYSTEM_MENU | wxCAPTION.
    #     wxICONIZE  Display the frame iconized (minimized). Windows only.
    #     wxCAPTION  Puts a caption on the frame.
    #     wxMINIMIZE  Identical to wxICONIZE. Windows only.
    #     wxMINIMIZE_BOX  Displays a minimize box on the frame.
    #     wxMAXIMIZE  Displays the frame maximized. Windows only.
    #     wxMAXIMIZE_BOX  Displays a maximize box on the frame.
    #     wxSTAY_ON_TOP  Stay on top of other windows. Windows only.
    #     wxSYSTEM_MENU  Displays a system menu.
    #     wxSIMPLE_BORDER  Displays no border or decorations. GTK and Windows only.
    #     wxRESIZE_BORDER  Displays a resizeable border around the window (Unix only).
    #     wxFRAME_FLOAT_ON_PARENT  Causes the frame to be above the parent window in the z-order and not shown in the taskbar. Without this style, frames are created as top-level windows that may be obscured by the parent window, and frame titles are shown in the taskbar. Windows and GTK.
    #     wxFRAME_TOOL_WINDOW  Causes a frame with a small titlebar to be created; the frame title does not appear in the taskbar. Windows only.
    my($frame) = MyFrame->new( undef, -1, "Hello World");

    #
    #   this property determines if the frame will be visible..
    #   Setting to 0 hides the frame.
    #
    $frame->Show(1);

    #
    #   An optional method to let a wxApp distinguish the topmost window.
    #   Apparently useful if there may be more than one top level window in
    #   an application at a time for determining the behavior of modal dialog
    #   boxes
    #
    $this->SetTopWindow($frame);

    # if OnInit doesn't return true, the application exits immediately.
    return 1;
}

#######################################
#
#
package MyFrame;
#
#
#######################################
#
#   This package overrides Wx::Frame, and allows us to put controls
#   in the frame.
#
use strict;
use vars qw(@ISA);
@ISA = qw(Wx::Frame);
#
#   most of these appear to be for constant declarations.
#
use Wx qw(:id
          :toolbar
          wxNullBitmap
          wxDefaultPosition
          wxDefaultSize
          wxDefaultPosition
          wxDefaultSize
          wxNullBitmap
          wxTB_VERTICAL
          wxSIZE
          wxTE_MULTILINE
          wxBITMAP_TYPE_BMP
);

#
#   Wx::Events allows us to attach events to user's actions.
#   EVT_SIZE for resizing a window
#   EVT_MENU for selecting a menu item
#   EVT_COMBOBOX for selecting a combo box item
#   EVT_TOOL_ENTER for selecting toolbar items
#
use Wx::Event qw(EVT_SIZE
                 EVT_MENU
                 EVT_COMBOBOX
                 EVT_UPDATE_UI
                 EVT_TOOL_ENTER
);


sub new {

    my( $class ) = shift;
    my( $this ) = $class->SUPER::new( @_ );

    # allocate id numbers for controls.
    # This method appears a little strange, but it's a way to quickly allocate
    # all IDs in one place.

    my( $ID_TOOLBAR, $ID_COMBO ) = ( 1 .. 100 );

    # use the same method to allocate id numbers for menu items with events.
    my(
      $IDM_FILE_OPEN,
      $IDM_FILE_CLOSE,
     ) = ( 10_000 .. 10_100 );

    # create a new menu item.
    # a menu is attached to a menu bar, it is not the menu bar itself.
    # e.g. : A menu bar may have "File", "Edit" and "Tools" as options,
    #        each of which will display a menu.
    #
    # there is another way to display menus, but we'll get there later.
    my $file_menu = Wx::Menu->new();


    #
    # the next few lines create the entries that will be attached to $file_menu.
    # This process is called through Wx::Menu->Append ().
    # I have chosen to put the data that will create these items into
    # an array of array to automate the process of creation.
    # details of the structure mirror the parameters to Append and are explained
    # below
    #
    # wxID_EXIT is a predefined id that is used for items which can trigger
    # an application's exit. Otherwise, it's appropriate to use ids that are
    # created in the application, like $IDM_FILE_OPEN is, below.

    my @file_menu_entries = ([$IDM_FILE_OPEN,"&Open\tCtrl-O","Open" ],
                             ['-'],
                             [wxID_EXIT, "E&xit\tCtrl-X", "Exit $0"]
    );


    #
    #   run through @file_menu_entries and add them.
    #   Note that inside the loop we look to see if the first element is
    #   a single minus sign.
    #   I chose to use this as a way to signal separators, which have a
    #   different method of being added to a menu.
    #
    foreach (@file_menu_entries) {
        if ($$_[0] eq '-') {
            #
            # Append a separator to the menu --
            # A separator is a visual demarcation between groups of menu items
            #
            $file_menu->AppendSeparator();
        } else {
            #
            #  Append (as shown below, there are other ways to call it) has 4
            #  possible parameters :
            #   The unique id of the menu item being created
            #   The text that will appear in the menu
            #   The text that will appear in the status bar on mouse hover
            #       (optional)
            #   Checkable -- if true, a checkmark will be toggled next to the
            #   menu item when selected (optional)
            #
            #   Since I have no checkmarkable items, I chose to remove it
            #   entirely. This is probably not-so-hot in the long run.
            #
            $file_menu->Append ($$_[0],$$_[1],$$_[2])
        }
    }

    # create the menubar that will contain the menu above.
    # the new method can take a style parameter, but it's only valid in GTK, so,
    # meh.
    # If it worked, the style parameter would allow menus to be dockable.
    #
    my $menubar = Wx::MenuBar->new();
    #
    #attach a menu to the menubar.
    #
    $menubar->Append ($file_menu, '&File');
    #
    #   attach the menubar to the window.
    #
    $this->SetMenuBar ($menubar);

    #
    # this is the only event right now.
    # The EVT_MENU sets events called from clicking on menu items.
    # the parameters are
    #   a reference to the frame;
    #   the menu
    #
    EVT_MENU( $this, wxID_EXIT, sub {$_[0]->Close( 1 )} );

    #
    # menu done, create tree control
    #

    return $this;
}



package main;
my($app) = MyApp->new();
$app->MainLoop();

