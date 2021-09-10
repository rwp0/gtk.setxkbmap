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
$statusicon -> set_tooltip_text('xsetkbdmap');

my $menu = Gtk3::Menu -> new();

my $radiomenuitem = Gtk3::RadioMenuItem -> new_with_label(undef, 'dvorak');
my $group = $radiomenuitem -> get_group();

$radiomenuitem -> set_tooltip_text('english');
$radiomenuitem -> signal_connect(toggled => sub { system($setxkbmap{dvorak}); });
$menu -> append($radiomenuitem);

$radiomenuitem = Gtk3::RadioMenuItem -> new_with_label($group, 'az');
$radiomenuitem -> set_tooltip_text('azerbaijani');
$radiomenuitem -> signal_connect(toggled => sub { system($setxkbmap{az}); });
$menu -> append($radiomenuitem);

$radiomenuitem = Gtk3::RadioMenuItem -> new_with_label($group, 'ru');
$radiomenuitem -> set_tooltip_text('russian');
$radiomenuitem -> signal_connect(toggled => sub { system($setxkbmap{ru}); });
$menu -> append($radiomenuitem);

$menu -> show_all();

$statusicon -> signal_connect('popup-menu' => sub {
  my($show, $button, $time) = @_;
  $menu -> popup(undef, undef, \&Gtk3::StatusIcon::position_menu, $show, $button, $time);
});

Gtk3 -> main();
