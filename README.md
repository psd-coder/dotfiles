# Dotfiles

Personal dotfiles with cross-platform support (macOS, Linux, dev containers).

## Quick Start (fresh system)

```bash
curl -fsSL https://raw.githubusercontent.com/psd-coder/dotfiles/master/bootstrap.sh | bash
```

Minimal install (dev containers):
```bash
curl -fsSL https://raw.githubusercontent.com/psd-coder/dotfiles/master/bootstrap.sh | DOTFILES_MINIMAL=true bash
```

## Manual Installation

If you already have git and make:

```bash
git clone https://github.com/psd-coder/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
make install
```

## What Gets Installed

| Platform | Packages |
|----------|----------|
| macOS | Xcode CLI, Homebrew, Brewfile packages, shell configs, system preferences |
| Linux | apt packages, fnm, Node.js, shell configs |
| Minimal | git, zsh, fzf, ripgrep, jq only |

## Individual Targets

```bash
make install_apt          # Linux: apt packages
make install_brew_bundle  # macOS: Homebrew packages
make setup_env            # Link shell/editor configs
make setup_node           # fnm + Node.js + pnpm
make setup_os             # macOS: system preferences
```

## Manual settings:

* Install Logitech Options for correct mouse work, otherwise sometimes strange scroll bugs happen
* Copy SSH keys or create new ones
* Import Stats settings from `configs/Stats.ismp`
* Setup iterm2 to use configuration from the folder: Preferences > General > Preferences: `~/.dotfiles/configs`
* Setup local languagetool service (see below)
* Turn on disk encryption in the: System Preperences > Security & Privace > FileVault
* Login into google account at the system and Google Chrome to sync all profile data
* Setup calendary accounts & delegations
* Setup bartender

## Setup local language tool
It is based on [Sitnik's instruction](https://x.com/andrey_sitnik/status/1795420791426707783). Service itself is installed by brew. We just need to tune it:
1. Setup ngram ([more here](https://dev.languagetool.org/finding-errors-using-n-gram-data))
```
mkdir -p ~/.config/languagetool/ngram
cd ~/.config/languagetool/ngram
wget https://languagetool.org/download/ngram-data/ngrams-en-20150817.zip
wget https://languagetool.org/download/ngram-data/untested/ngram-ru-20150914.zip
unzip ngrams-en-20150817.zip
unzip ngram-ru-20150914.zip
rm ngram*.zip
```
2. Setup fasttext
```
mkdir -p ~/.config/languagetool/fasttext
cd ~/.config/languagetool/fasttext
wget https://dl.fbaipublicfiles.com/fasttext/supervised-models/lid.176.bin
```
3. Create config:
``` 
cat <<EOL > ~/.config/languagetool/languagetool.properties
languageModel=/Users/psdcoder/.config/languagetool/ngram
fasttextModel=/Users/psdcoder/.config/languagetool/fasttext/lid.176.bin
fasttextBinary=/usr/local/bin/fasttext
EOL
```
4. Specify this config in languagetool service config:
Add this option to the service config: `~/Library/LaunchAgents/homebrew.mxcl.languagetool.plist`:
```
<string>--config</string>
<string>/Users/psdcoder/.config/languagetool/languagetool.properties</string>
```
5. Restart service:
```
brew services restart languagetool
```
