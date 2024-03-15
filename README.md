# Dotfiles

## First time setup

Install homebrew:
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install chezmoi:
```
brew install chezmoi
```

Copy chezmoi config:
```
cat > ~/.config/chezmoi/chezmoi.jsonc << EOF
{
  "data": {
    // Update this per machine
    "machine": "work-laptop"
  },
  "merge": {
    "command": "nvim",
    "args": [
      "-d",
      "{{ .Destination }}",
      "{{ .Source }}",
      "{{ .Target }}"
    ]
  }
}
EOF
```

Apply dotfiles:
```
chezmoi init --apply https://github.com/SamCHogg/dotfiles.git
```

## Update

```
chezmoi update
```

