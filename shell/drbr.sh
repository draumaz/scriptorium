#!/bin/bash
# drbr, by draumaz (2022) | GPL v3
# tmux-based twibright links wrapper for st

export HOMEPAGE=""

st -e bash -c 'tmux new-session -d -s drbr; 
	tmux send-keys -t drbr "links '$HOMEPAGE'; tmux kill-session" enter; 
	tmux attach -t drbr'
