# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

# For autostart
import os
import subprocess

import random

from libqtile import hook

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.run([home])

# change backend on picom to glx
# End for autostart


mod = "mod4"            # mod1 == alt
terminal = "alacritty"

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(["mod1"], "Tab", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h",
    lazy.layout.grow_left(),
    lazy.layout.shrink_main().when(layout="monadtall"),
    desc="Grow window to the left"),
    Key([mod, "control"], "l",
    lazy.layout.grow_right(),
    lazy.layout.grow_main().when(layout="monadtall"),
    desc="Grow window to the right"),
    Key([mod, "control"], "j",
    lazy.layout.grow_down(),
    lazy.layout.grow_main().when(layout="monadwide"),
    desc="Grow window down"),
    Key([mod, "control"], "k",
    lazy.layout.grow_up(),
    lazy.layout.shrink_main().when(layout="monadwide"),
    desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([], "F12", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "Tab", lazy.prev_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "d", lazy.spawn("dmenu_run"), desc="Spawn dmenu_run"),
    Key(["control", "mod1"], "space", lazy.spawn("slock"), desc="Locks the screen"),
    
    # Function key binds
    Key([], "XF86Search", lazy.spawn("dmenu_run"), desc="Spawn dmenu_run"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl s 5%-"), desc="Brightness down 5%"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl s 5%+"), desc="Brightness up 5%"),
    Key([], "XF86AudioLowerVolume", lazy.widget["pulsevolume"].decrease_vol(), desc="Lower volume"),
    Key([], "XF86AudioRaiseVolume", lazy.widget["pulsevolume"].increase_vol(), desc="Raise volume"),
    Key([], "XF86AudioMute", lazy.widget["pulsevolume"].mute(), desc="Mute audio"),
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause player"),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Next track"),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Previous track"),

    # Switch between screens
    Key([mod], "q", lazy.next_screen(), desc=""),

    # Custom application key binds
    Key([mod], "c", lazy.spawn("chromium"), desc="Launch Chromium browser"),
    Key([mod, "shift"], "c", lazy.spawn("chromium --incognito"), desc="Launch incognito Chromium"),
    Key(["control", "mod1"], "p", lazy.spawn("flameshot gui"), desc="Takes a screenshot"),
    Key([mod], "f", lazy.spawn("librewolf"), desc="Launch LibreWolf"),
    Key([mod, "shift"], "f", lazy.spawn("librewolf --private-window"), desc="Launch LibreWolf private"),
    Key([mod], "b", lazy.spawn("brave"), desc="Launch Brave browser"),
    Key([mod, "shift"], "b", lazy.spawn("brave --incognito"), desc="Launch incognito Brave browser"),
    Key([mod], "a", lazy.spawn("alacritty -e ranger"), desc="Launch ranger"),
]

groups = [Group(i) for i in "123456789"]

#groups[1].layout = "monadwide"
groups[8].layout = "matrix"

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )


layouts = [
    layout.MonadWide(ratio=0.7, border_focus="#aaaa00", border_width=2, margin=7, insert_position=1),
    layout.MonadTall(ratio=0.6, border_focus="#aaaa00", border_width=2, margin=7, insert_position=1),
    #layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=2,
    layout.Columns(border_focus="#aaaa00", border_width=2, margin=7, insert_position=1),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    #layout.Stack(num_stacks=2),
    #layout.Bsp(),
    layout.Matrix(border_focus="#aaaa00", border_width=2, margin=7, insert_position=1),
    #layout.RatioTile(),
    #layout.Tile(),
    #layout.TreeTab(),
    #layout.VerticalTile(),
    #layout.Zoomy(),
]

widget_defaults = dict(
    font="sans",
    fontsize=16,
    padding=3,
)
extension_defaults = widget_defaults.copy()

# Random wallpaper from ~/Pictures/wallpaper
home_dir = os.path.expanduser('~')
wallpapers = os.listdir(f"{home_dir}/Pictures/wallpaper/")
for file in wallpapers:
    if file[-4:] == '.jpg' or file[-4:] == '.png' or file[-5:] == '.jpeg':
        continue
    else:
        wallpapers.remove(file)
random_wallpaper = random.choice(wallpapers)
wallpapers.remove(random_wallpaper)
random_wallpaper_2 = random.choice(wallpapers)

screens = [
    Screen(
        wallpaper=f"~/Pictures/wallpaper/{random_wallpaper}",
        wallpaper_mode="fill",
        top=bar.Bar(
            [
                widget.CurrentLayoutIcon(),
                widget.GroupBox(),
                widget.Prompt(),
                widget.WindowName(),
                widget.Chord(
                    chords_colors={
                        "launch": ("#ff0000", "#ffffff"),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                #widget.TextBox("bard config", name="default"),
                #widget.TextBox("Press &lt;M-r&gt; to spawn", foreground="#d75f5f"),
                widget.Systray(),
                widget.Sep(),
                widget.Battery(foreground="bbbb00", update_interval=30),
                widget.Sep(),
                widget.TextBox("Vol:"),
                widget.PulseVolume(update_interval=0.2, limit_max_volume=True),
                widget.Sep(),
                widget.Clock(format="%H:%M.%S %a %D", foreground="#bbbb00"),
                widget.Sep(),
                widget.QuickExit(foreground="#aa11aa"),
            ],
            24,
            margin=3,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
    Screen(
        wallpaper=f"~/Pictures/wallpaper/{random_wallpaper_2}",
        wallpaper_mode="fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
