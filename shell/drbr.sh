#!/bin/bash
# drbr, by draumaz (2022) | GPL v3
# tmux-based twibright links wrapper for st

export HOMEPAGE=""

st -e bash -c 'tmux new-session -d; 
	tmux send-keys "links '$HOMEPAGE'; tmux kill-session" enter; 
	tmux attach'
