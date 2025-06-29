
# ocomacs

  ...a post Doom Emacs config framework for Linux, Macos, WSL2/Linux

  Keep you in vanilla emacs, to help you know what's going on,
  
  Attempts to help limit excessive yak-shaving 
  
  Avoids the need to learn a huge secondary framework
  
  Requires enough interest in Emacslisp to 
  learn what you need to do next ...


### How to use

```sh
# Make a backup of your `~/.emacs.d`
mv ~/.emacs.d ~/.emacs.d.backup

# Clone this repo
git clone git@github.com:ocodo/ocomacs ~/.emacs.d

# Build
~/.emacs.d/bin/ocomacs rebuild

# Optionally add ocomacs to PATH 
# (append to .zshrc, .fishrc, .bashrc etc)

export PATH=~/.emacs.d/bin:$PATH

# Run Emacs GUI.. 
emacs & disown %

# or in the terminal 
emacs -nw

# If you like it fork it and enjoy your untetherd emacs journey.
```

### How to extend

Edit `packages.el` to add new packages, follow the pattern in the
file. Try packages with `M-x straight-use-package`

- - -

Additional config for packages in `use/*.el` - `use-package` is ready
to go, check the examples, I'll deliberately keep them basic.

- - -

Use Customize (saved to `~/.config/emacs-custom.el` avoid editing
this.) or add your own changes in `~/.config/emacs-local.el`.

- - -

You can also remove packages and rebuild via `~/.emacs.d/bin/ocomacs rebuild`

- - -

### List of important changes/primary packages used:

- Uses `straight.el` for package management

- Does _just enough_, with a few Quality of Life features
  - Theme: creamsody / creamsody-darker
  - **Switch OFF** 
    - splash-screen
	- menu bar
	- tool-bar
	- scroll bars
	- ring-bell
	- package.el
  - **Switch ON**
	- [OcodoMono Nerd Font - light](https://github.com/ocodo/ocodo-mono)
	- Site/Local config `~/.config/emacs-local.el`
	- Site/Local custom.el `~/.config/emacs-custom.el`
	- Terminal `xterm-mouse-mode`
    - Use short answers. 
	  - `(setopt use-short-answers t)` (like `(defalias 'yes-or-no-p 'y-or-n-p)`)
  - kill-current-buffer `C-x k`
  - _**instant ready for:**_ 
    - `EDITOR="emacs -nw" git commit`
  - which-key
  - vertico/orderless
  - magit
  - lsp-mode
  - company-mode
  - markdown
  - kurecolor
  - dashboard
  - lambda-line
  - all-the-icons
  - ellama
  - move-text
  - duplicate-line or region down/up
- Extra language support
  - anaconda-mode (python)
  - jtsx-mode (jsx/js, tsx/ts)
  - lua-mode
  
## Performance focus

- Immediate `git commit` response
- Package config with straight in `packages.el`
- Extra config via `use/*.el`
- Concat init and bytecompile for fastest possible startup

