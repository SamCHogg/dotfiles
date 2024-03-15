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

Apply dotfiles:
```
chezmoi init --apply https://github.com/SamCHogg/dotfiles.git
```

