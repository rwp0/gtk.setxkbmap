# classes: StatusIcon, Menu, MenuItem
# methods: append, signal_connect, set_tooltip_text

use v5.32;
use warnings;

use Gtk3 qw(-init);

my %setxkbmap = (
  dvorak => 'setxkbmap -option ctrl:swapcaps dvorak',
  az => 'setxkbmap -option ctrl:swapcaps az',
  ru => 'setxkbmap -option ctrl:swapcaps ru',
);

my $statusicon = Gtk3::StatusIcon -> new_from_stock('gtk-edit');
$statusicon -> set_tooltip_text('xsetkbd');

my $menu = Gtk3::Menu -> new();

my $menuitem = Gtk3::MenuItem -> new('dvorak');
$menuitem -> set_tooltip_text('english');
$menuitem -> signal_connect(activate => sub { system($setxkbmap{dvorak}); });
$menu -> append($menuitem);

$menuitem = Gtk3::MenuItem -> new('az');
$menuitem -> set_tooltip_text('azerbaijani');
$menuitem -> signal_connect(activate => sub { system($setxkbmap{az}); });
$menu -> append($menuitem);

$menuitem = Gtk3::MenuItem -> new('ru');
$menuitem -> set_tooltip_text('russian');
$menuitem -> signal_connect(activate => sub { system($setxkbmap{ru}); });
$menu -> append($menuitem);

$menu -> show_all();

$statusicon -> signal_connect('popup-menu' => sub {
  my($show, $button, $event_time) = @_;
  $menu -> popup(undef, undef, \&Gtk3::StatusIcon::position_menu, $show, $button, $event_time);
});

Gtk3 -> main();
