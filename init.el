;; Bare bones - config 2025
(setq inhibit-splash-screen 1)
(setopt use-short-answers t)
(setq package-enable-at-startup nil)
(setq ring-bell-function 'ignore)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(defvar preferred-font-size
  160
  "size in 1/10pt")

(defvar personal-mono-font
  (font-spec
   :foundry "ocdo"
   :family "OcodoMono Nerd Font"
   :weight 'light)
  "Personal font spec - Nerd Fonts recommended")

;; GUI or Terminal Specific...
(if initial-window-system
    
    ;; On GUI Use personal-mono-font
    (when (fontp personal-mono-font)
      (set-face-attribute
       'default nil
       :height preferred-font-size
       :font personal-mono-font))
  
  ;; xterm-mouse-mode in terminal
  (xterm-mouse-mode 1))

;;; Exit early if in commit mode
(add-to-list 'auto-mode-alist '("/COMMIT_EDITMSG\\'" . diff-mode))


(if (seq-find #'(lambda (a) (string-match-p "COMMIT_EDITMSG" a 0)) command-line-args)
    ;;; If we're just doing a commit
    ;;; set the theme to Wombat
    ;;; and return control to the user
    (load-theme 'wombat nil nil)

  (progn
    ;; Regular init continues...
    
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
	(load local-emacs-conf)))))
