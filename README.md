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

## Making Changes

https://www.chezmoi.io/user-guide/frequently-asked-questions/usage/#once-ive-made-a-change-to-the-source-directory-how-do-i-commit-it

