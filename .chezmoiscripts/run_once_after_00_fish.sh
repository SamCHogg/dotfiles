#!/bin/bash

if which fish &>/dev/null; then
  if ! grep -q "$(which fish)" /etc/shells; then
    sudo sh -c "echo $(which fish) >> /etc/shells"
  fi
  chsh -s "$(which fish)"
fi
