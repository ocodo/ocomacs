<center><img src="assets/ocomacs-logo.png" /></center>

# ocomacs

  ...a post Doom Emacs config framework for Linux, Macos, WSL2/Linux

  Starts in ~0.7 in Terminal, ~2sec in GUI over X11Fowarding, it's fast...

  Dedicated `$EDITOR git commit` mode starts in less than 0.1s on average.

  Keep you in vanilla emacs, to help you know what's going on,
  Attempts to help limit excessive yak-shaving. 
  Avoids the need to learn a huge secondary framework
  
  Requires enough interest in Emacslisp to 
  learn what you need to do next ...

  There's enough here for a modern editing environment, and the frameword is small enough for you to fork and choose your own adventure, or just add a few packages to `~/.config/ocomacs/packages.el` and rely on the core framework being fast and stable.

  Stick with tag releases to sync, open an issue for bugs, PRs are welcome, but the main goal is for ocomacs to be a starter kit, and foster an ecosystem of forks.

  Ideally, this helps people really get what Emacs is about, cusomization and self sufficient mastery.

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

If you're looking to ocomacs as a very fast config base, and want to keep your own config separate:

Edit `~/.config/ocomacs/packages.el` to add new packages, follow the pattern below. 

```lisp
(straight-use-package 'git-timemachine)
```

To try packages without commiting them to your config use:

```lisp
M-x straight-use-package
```
- - -

Additional config for packages in `~/.config/ocomacs/use/*.el` - `use-package` is ready
to go and totally optional, check the examples, in `~/.emacs.d/use/` I keep them fairly simple.

- - -

if you want to use use `M-x customize` changes are saved to `~/.config/ocomacs/custom.el` (avoid editing
this file.)

If you want general config use `~/.config/ocomacs/config.el`.


- - -

If you want to use ocomacs as a starting point, and are looking for a framework you can fully understand in a few hours, you're who I made this for.

Fork it and keep on making an environment 100% for you.

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
  - iedit
  - lsp-mode
  - company-mode
  - yasnippet + yasnippet-snippets 
  - markdown
  - kurecolor
  - dashboard
  - lambda-line
  - all-the-icons
  - ellama
  - move-text
  - duplicate-line or region down/up
  - s.el
- Extra language support
  - anaconda-mode (python)
  - jtsx-mode (jsx/js, tsx/ts)
  - lua-mode
  

