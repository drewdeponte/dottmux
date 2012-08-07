#!/bin/bash

TMUX_SESSION_NAME="rpp_web_app"

tmux list-sessions | grep ${TMUX_SESSION_NAME}
if [ $? -eq 0 ]; then
  echo "The \"${TMUX_SESSION_NAME}\" tmux session already exists. Attaching to it..."

  # Attach the terminal to the session.
  tmux attach-session -d -t "${TMUX_SESSION_NAME}"
else
  echo "The \"${TMUX_SESSION_NAME}\" tmux session does NOT exist. Creating it..."

  # Prime the CWD so that it is used as the CWD for the session and its windows
  cd /Users/adeponte/WebApps/realpractice/rpp_web_app

  # Create a new session.
  tmux new-session -s "${TMUX_SESSION_NAME}" -n vim -d '/bin/zsh'

  # Create a new window inside the session called 'vim' containing an instance of vim.
  tmux send-keys -t "${TMUX_SESSION_NAME}:0" 'vim' C-m

  # Create a new window inside the session called 'log' containing the apps dev logs.
  tmux new-window -t "${TMUX_SESSION_NAME}" -n log -d 'tail -f log/development.log'

  # Create a new window inside the session called 'foreman' running 'foreman start'.
  tmux new-window -t "${TMUX_SESSION_NAME}" -n foreman -d '/bin/zsh'
  tmux send-keys -t "${TMUX_SESSION_NAME}:2" 'foreman start' C-m

  # Create a new window inside the session called 'console' running 'rails c'.
  tmux new-window -t "${TMUX_SESSION_NAME}" -n console -d '/bin/zsh'

  # Create a new window inside the session called 'irb' running 'irb'.
  tmux new-window -t "${TMUX_SESSION_NAME}" -n irb -d 'irb'

  # Select the first window in the session for good measure.
  tmux select-window -t "${TMUX_SESSION_NAME}:0"

  # Attach the terminal to the session.
  tmux attach-session -d -t "${TMUX_SESSION_NAME}"
fi

