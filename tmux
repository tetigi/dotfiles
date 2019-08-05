#set-option -g default-command "reattach-to-user-namespace -l zsh"
set-option -g default-shell /bin/zsh
set -g default-terminal "gnome-terminal"
bind R source-file ~/.tmux.conf \; display-message "Config reloaded..."
set -sg escape-time 0

# Change keybinding for key stuff
set-option -g prefix C-q
unbind-key C-b
bind-key C-q send-prefix
# Sane scrolling
set -g terminal-overrides 'xterm*:smcup@:rmcup@'
setw -g mode-keys vi

#------------
# tabs
#------------
setw -g monitor-activity on
setw -g window-status-format "#[fg=white]#[bg=colour238] #I #[bg=colour238]#[fg=white] #W "
setw -g window-status-current-format "#[bg=colour202]#[fg=white] *#I #[fg=white,bold]#[bg=colour208] [#W] "
#setw -g window-status-content-attr bold,blink,reverse

#------------
# status bar
#------------
set-option -g status-position top
set -g status-fg white
set -g status-bg colour234
set -g status-left ''
set -g status-right-length 60
set -g status-right '#[fg=red]#(CUTE_BATTERY_INDICATOR=true ~/.battery/bin/battery Discharging)#[fg=blue]#(CUTE_BATTERY_INDICATOR=true ~/.battery/bin/battery Charging)#[fg=white] | %a %d-%m %H:%M'

#------
# vim
# ----
unbind-key j
bind-key j select-pane -D

unbind-key k
bind-key k select-pane -U

unbind-key h
bind-key h select-pane -L

unbind-key l
bind-key l select-pane -R
