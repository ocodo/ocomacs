# Emacs for 2025 / ocodo

Personal [post Doom] config for emacs, with emphasis on:

- Limit yak-shaving
- Does just enough, with some nice QOL features
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
