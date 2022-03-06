#!/bin/bash
# drbr, by draumaz (2022) | GPL v3
# tmux-based twibright links wrapper for st

export HOMEPAGE=""

## TODO: end tmux session when user exits links

st -e bash -c 'tmux new-session -d -s drbr; 
	tmux send-keys -t drbr "links '$HOMEPAGE'" enter; 
	tmux attach -t drbr'
