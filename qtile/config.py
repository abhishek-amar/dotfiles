from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.lazy import lazy
from libqtile import layout, bar, widget

from typing import List

mod = "mod4"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "k", lazy.layout.down()),
    Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
   #  Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    Key([mod, "shift"], "Return", lazy.spawn("pcmanfm")),
    Key([mod], "Return", lazy.spawn("xterm")),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, "shift"], "q", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),
]


group_names = ['WWW', 'DEV', 'SYS', 'DOC', 'VBOX', 'CHAT', 'MUS', 'VID', 'GFX']

groups = [Group(name, layout = 'monadtall') for name in group_names]
for index, each_group in enumerate(groups, 1):
	keys.extend([
		Key([mod], str(index), lazy.group[each_group.name].toscreen()),
		Key([mod, "shift"], str(index), lazy.window.togroup(each_group.name, switch_group = True)),
		# Make switch_group = False if you don't want to go to new workspace along with window
	])


colours = ['#292d3e', '#ff5555', '#5eb0db', '#668bd7', '#ffffff', '#434758', '#e1acff', '#1D2330']
# Panel background, Panel active workspace, Panel inactive workspace, Widget Colour, Panel Text, Group highlight color, Border focus, Border Normal(unfocused)

layout_theme = {
"border_width": 1,
"margin": 5,
"border_focus": colours[6],
"border_normal": colours[7]
}

layouts = [
    layout.Max(),
    layout.Stack(num_stacks=2),
    # Try more layouts by unleashing below layouts.
    # layout.Bsp(),
    # layout.Columns(),
    # layout.Matrix(),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    fontsize = 9,
                    margin_y = 3,
                    margin_x = 0,
                    padding_y = 5,
                    padding_x = 3,
                    borderwidth = 3,
                    active = colours[4],
                    inactive = colours[4],
                    rounded = False,
                    highlight_color = colours[5],
                    highlight_method = "line",
                    this_current_screen_border = colours[1],
                    this_screen_border = colours[2],
                    foreground = colours[4],
                    disable_drag = True,
                    background = colours[0]

                ),
                widget.Prompt(),
                widget.WindowName(),
        		widget.TextBox(text = '', padding = 0, fontsize = 45, foreground = colours[2]),
                widget.CurrentLayout(background = colours[2]),
        		widget.TextBox(text = '', padding = 0, fontsize = 45, foreground = colours[3], background = colours[2]),
        		# Use lshw to get the interface argument, which is the logical name, use a list for multiple entries
        		widget.Net(interface = 'enp0s3', format = '{down} ↓↑ {up}', background = colours[3]),
        		widget.TextBox(text = '', padding = 0, fontsize = 45, foreground = colours[2], background = colours[3]),
        		widget.CPU(background = colours[2]),
        		widget.TextBox(text = '', padding = 0, fontsize = 45, foreground = colours[3], background = colours[2]),
        		widget.Memory(background = colours[3]),
        		widget.TextBox(text = '', padding = 0, fontsize = 45, foreground = colours[2], background = colours[3]),
                widget.TextBox(text = 'Vol:', padding = 0, foreground = colours[4], background = colours[2]),
                widget.Volume(foreground = colours[4], background = colours[2], padding = 5),
                widget.TextBox(text = '', padding = 0, fontsize = 45, foreground = colours[3], background = colours[2]),
                widget.Clock(format='%d-%m-%Y %a %I:%M %p', background = colours[3]),
                widget.Systray()
                    ],
                    size = 24, background = colours[0]
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
])
auto_fullscreen = True
focus_on_window_activation = "smart"


wmname = "LG3D"
