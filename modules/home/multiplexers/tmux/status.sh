#!/usr/bin/env sh
# based on nicknisi's base16

# colors
textColor=colour251 # greyish white
defaultStatus=colour235
separator=colour12  # grey
secondaryBack=colour237  # #86C1B9
thirdBack=colour241  # #86C1B9
lightgreen=colour10  # #7CAFC2
firstBack=colour240  # #BA8BAF
lightblue=colour12 # #A16946

set -g status-left-length 32
set -g status-right-length 150
set -g status-interval 5

# default statusbar colors
set-option -g status-fg $textColor
set-option -g status-bg $defaultStatus
set-option -g status-style default

# non-active window colors
setw -g window-status-style bg=$secondaryBack,fg=$textColor
set -g window-status-format " #I #W "

# active window title colors
setw -g window-status-current-style bg=$thirdBack,fg=$lightblue
setw -g  window-status-current-format "    #I #[bold]#W    "

# pane border colors
setw -g pane-border-style fg=$secondaryBack
setw -g pane-active-border-style fg=$separator

# message text
set -g message-style bg=$textColor,fg=$secondaryBack

# pane number display
set-option -g display-panes-active-colour $secondaryBack
set-option -g display-panes-colour $defaultStatus

# clock
set-window-option -g clock-mode-colour $secondaryBack

tm_session_name="#[default,bg=$firstBack,fg=$textColor] Session: #S "
set -g status-left "$tm_session_name"

tm_date="#[default,bg=$firstBack,fg=$textColor] %R %a %b %d"
set -g status-right "$tm_date"
