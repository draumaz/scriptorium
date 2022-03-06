#!/bin/bash
# drbr, by draumaz (2022) | GPL v3
# tmux-based twibright links wrapper for st

## TODO: 
## close tmux session when links is exited

st -e bash -c 'tmux new-session -d -s drbr; 
	tmux send-keys -t drbr "links duckduckgo.com" enter; 
	tmux attach -t drbr'
