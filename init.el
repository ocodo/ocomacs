;; Bare bones - config 2025
(setq inhibit-splash-screen 1)
(setopt use-short-answers t)
(setq package-enable-at-startup nil)
(setq ring-bell-function 'ignore)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(let ((ocodo-mono-light (font-spec
			 :foundry "ocdo"
			 :family "OcodoMono Nerd Font"
			 :weight 'light)))
  (if initial-window-system
      ;; On Gui Use OcodoMono Nerd Font Light when available
      (when (fontp ocodo-mono-light)
	(set-face-attribute 'default nil :height 160 :font ocodo-mono-light))
    ;; xterm-mouse-mode in terminal
    (xterm-mouse-mode 1)))

;;; Exit early if in commit mode
(add-to-list 'auto-mode-alist '("/COMMIT_EDITMSG\\'" . diff-mode))

(unless (seq-find
	 #'(lambda (a) (string-match-p "COMMIT_EDITMSG" a 0))
	 command-line-args)

  ;; Straight
  (defvar bootstrap-version)

  (let ((bootstrap-file
	 (expand-file-name
          "straight/repos/straight.el/bootstrap.el"
          (or (bound-and-true-p straight-base-dir)
              user-emacs-directory)))
	(bootstrap-version 7))
    (unless (file-exists-p bootstrap-file)
      (with-current-buffer
          (url-retrieve-synchronously
           "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
           'silent 'inhibit-cookies)
	(goto-char (point-max))
	(eval-print-last-sexp)))
    (load bootstrap-file nil 'nomessage))

  ;; Require use-package
  (straight-use-package 'use-package)
  (setq straight-use-package-by-default t)

  ;; TODO - byte compile compatible via load-path
  ;; Straight enabled package config
  (load (file-name-concat user-emacs-directory "packages.el"))

  ;; Load everything from /use
  (mapc
   'load
   (file-expand-wildcards
    (file-name-concat user-emacs-directory "use/*.el")))

  ;; Load creamsody, make it darker
  (load-theme 'creamsody 1)
  (load-theme 'creamsody-darker 1)

  (let ((local-emacs-conf "~/.config/emacs-local.el")
	(local-emacs-custom "~/.config/emacs-custom.el"))
    (setq custom-file local-emacs-custom)
    (when (file-exists-p custom-file)
      (load custom-file))
    (when (file-exists-p local-emacs-conf)
      (load local-emacs-conf))))
