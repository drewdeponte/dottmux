#!/bin/bash

cd /Users/adeponte/WebApps/realpractice/rpp_web_app

# Create a new session named rpp_web_app and a new window
# inside that session called vim that runs vim.
tmux new-session -s "rpp_web_app" -n vim -d 'vim'
tmux new-window -t "rpp_web_app" -n log -d 'tail -f log/development.log'
tmux new-window -t "rpp_web_app" -n foreman -d '/bin/zsh'
tmux send-keys -t "rpp_web_app:2" 'foreman start' C-m
tmux new-window -t "rpp_web_app" -n console -d '/bin/zsh'
tmux send-keys -t "rpp_web_app:3" 'rails c' C-m
tmux new-window -t "rpp_web_app" -n irb -d 'irb'
tmux select-window -t "rpp_web_app:0"
tmux attach-session -d -t "rpp_web_app"
