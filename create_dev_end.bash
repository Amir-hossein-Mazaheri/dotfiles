#!/bin/bash

# flags of the program
first_session_name_flag='-f'
second_session_name_flag='-s'
third_session_name_flag='-t'
fourth_session_name_flag='-temp'
create_fourth_session_flag='--four'
session_name_flag='-n'
project_name_flag='-p'

window_name='dev-env-created-by-script'
first_session_name='Code'
second_session_name='Terminal'
third_session_name='Vim'
fourth_session_name='Temp'
create_fourth_session=false
project_name=

# get the flags and set the vars based on the flags
arr=( "$@" )

for((i=0; i<${#arr[@]}; i++)); do
    arg=${arr[$i]}
    next_arg=${arr[$i+1]}

    case $arg in
        "$first_session_name_flag")
            first_session_name=$next_arg
            ;;
        "$second_session_name_flag")
            second_session_name=$next_arg
            ;;
        "$third_session_name_flag")
            third_session_name=$next_arg
            ;;
        "$fourth_session_name_flag")
            fourth_session_name=$next_arg
            create_fourth_session=true
            ;;
        "$session_name_flag")
            window_name=$next_arg
            ;;
        "$create_fourth_session_flag")
            create_fourth_session=true
            ;;
        "$project_name_flag")
            project_name=$next_arg
            ;;
    esac
done

if [ -z "$project_name" ]; then
    echo "Please provide a project name"
    exit 1
fi


# create the tmux session
tmux new-session -d -s "$window_name"


cd /Volumes/Programming/github/frontend/"$project_name" || exit


# first window
tmux new-window -t "$window_name:1"
tmux send-keys -t "$window_name:1" "cd /Volumes/Programming/github/frontend/$project_name && nvim ." Enter

# second window
tmux new-window -t "$window_name:2"
tmux split-window -h
tmux send-keys -t "$window_name:2.1" "pnpm dev" Enter
tmux select-pane -t "$window_name:2.1"

# fourth window
if [ $create_fourth_session = true ]; then
    tmux new-window -t "$window_name:4" "cd ~/.config/nvim && nvim ."
fi

# third window
tmux new-window -t "$window_name:3"

tmux rename-window -t "$window_name:1" "$first_session_name"
tmux rename-window -t "$window_name:2" "$second_session_name"
tmux rename-window -t "$window_name:3" "$third_session_name"

tmux move-window -s "$window_name:3" -t "$window_name:2"

if [ $create_fourth_session = true ]; then
    tmux rename-window -t "$window_name:4" "$fourth_session_name"
fi

tmux attach-session -t "$window_name"
