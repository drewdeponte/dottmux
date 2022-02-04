# Attach to the session name provided as the first argument
function attach_to_session {
	local __session_name=$1
  tmux attach-session -d -t "$__session_name"
}

# Create session given the following arguments
# - base directory
# - session name
# - initial window name
# - initial window shell (e.g. zsh)
# - initial window shell cmd
# - should attach to session (0 - no or 1 - yes)
function create_session {
	local __session_base_path=$1 # directory that new windows will start in
	local __session_name=$2 # name of the tmux session
	local __initial_window_name=$3 # name of the initial window
	local __initial_window_shell=$4 # shell the window should run, e.g. zsh
	local __initial_window_shell_cmd=$5 # shell command to run in the initial window
	local __should_attach=$6

	tmux list-sessions 2> /dev/null | grep $__session_name > /dev/null 2>&1
	if [ $? -eq 0 ]; then
 		echo "The \"${__session_name}\" tmux session already exists."
		if [ $__should_attach -eq 1 ]; then
			echo " Attaching to it..."
			attach_to_session $__session_name
		fi
	else
  	echo "The \"${__session_name}\" tmux session does NOT exist. Creating it..."
		cd  $__session_base_path
		tmux new-session -s "$__session_name" -n "$__initial_window_name" -d "$__initial_window_shell"

		tmux send-keys -t "${TMUX_SESSION_NAME}:0" "$__initial_window_shell_cmd" C-m

		# Select the first window in the session for good measure.
		tmux select-window -t "${TMUX_SESSION_NAME}:0"

		if [ $__should_attach -eq 1 ]; then
			echo " Attaching to it..."
			attach_to_session $__session_name
		fi
	fi
}

# Create session given the following arguments
# - base directory
# - session name
# - initial window name
# - initial window shell (e.g. zsh)
# - initial window shell cmd
# - should attach to session (0 - no or 1 - yes)
function create_empty_session {
	local __session_base_path=$1 # directory that new windows will start in
	local __session_name=$2 # name of the tmux session
	local __initial_window_name=$3 # name of the initial window
	local __initial_window_shell=$4 # shell the window should run, e.g. zsh
	local __should_attach=$5

	tmux list-sessions 2> /dev/null | grep $__session_name > /dev/null 2>&1
	if [ $? -eq 0 ]; then
 		echo "The \"${__session_name}\" tmux session already exists."
		if [ $__should_attach -eq 1 ]; then
			echo " Attaching to it..."
			attach_to_session $__session_name
		fi
	else
  	echo "The \"${__session_name}\" tmux session does NOT exist. Creating it..."
		cd  $__session_base_path
		tmux new-session -s "$__session_name" -n "$__initial_window_name" -d "$__initial_window_shell"

		# Select the first window in the session for good measure.
		tmux select-window -t "${TMUX_SESSION_NAME}:0"

		if [ $__should_attach -eq 1 ]; then
			echo " Attaching to it..."
			attach_to_session $__session_name
		fi
	fi
}
