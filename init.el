;;;
;;;      _ \   __|  _ \  __ `__ \   _` |  __|  __|
;;;     (   | (    (   | |   |   | (   | (   \__ \
;;;    \___/ \___|\___/ _|  _|  _|\__,_|\___|____/
;;;
;;; a post Doom, configuration framework for Emacs 29+
;;; https://github.com/ocodo/ocomacs

;; load ocomacs-core
(load
 (file-name-concat
  user-emacs-directory
  "lisp"
  "ocomacs-core.el"))

(defvar ocomacs-local-emacs-conf (ocomacs-user-path "init.el")
  "User / machine local emacs init.el")

(setq custom-file (ocomacs-user-path "custom.el"))

;; Bare bones UI
(progn
  (setq inhibit-splash-screen 1)
  (setq package-enable-at-startup nil)
  (setq ring-bell-function 'ignore)
  (setq make-backup-files nil)
  (electric-pair-mode 1)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (setopt use-short-answers t)
  (delete-selection-mode 1))

;; GUI Specific...
(when initial-window-system
    ;;; load font config...
    (ocomacs-default-font-config))
    ;;; Note: Edit font preference in
    ;;; ~/.config/ocomacs/ocomacs-gui-font.el

;; Terminal Specific...
(unless initial-window-system
  ;; xterm-mouse-mode in terminal
  (xterm-mouse-mode 1))

;; if emacs is opening COMMIT_EDITMESSAGE for git commit
(add-to-list 'auto-mode-alist '("/COMMIT_EDITMSG\\'" . diff-mode))
(if (seq-find
     #'(lambda (a)
	 (string-match-p "COMMIT_EDITMSG" a 0))
     command-line-args)
    ;;; If we're just doing a commit
    ;;; set the theme to deeper-blue
    ;;; return control to the user ASAP
    (ocomacs-load-theme 'deeper) ;; git commit early exit =>

  ;; - Normal Use :: load full config --8<---------------------------------------------------------

  ;; else
  (progn
    ;; Regular init continues...
    ;; Bootstrap Straight
    (defvar bootstrap-version)
    (setq straight-repository-branch "develop")

    (let ((bootstrap-file
	   (expand-file-name
            "straight/repos/straight.el/bootstrap.el"
            (or (bound-and-true-p straight-base-dir)
		user-emacs-directory)))
	  (bootstrap-version 7))
      (unless (file-exists-p bootstrap-file)
	(with-current-buffer
            (url-retrieve-synchronously
	     (concat "https://raw.githubusercontent.com/"
		     "radian-software/straight.el/"
		     "develop/install.el")
             'silent 'inhibit-cookies)
	  (goto-char (point-max))
	  (eval-print-last-sexp)))
      (load bootstrap-file nil 'nomessage))

    ;; Integrate use-package and straight
    (straight-use-package 'use-package)
    (setq straight-use-package-by-default t)

    ;; Straight enabled package config - core packages
    (load (file-name-concat user-emacs-directory "packages.el"))

    ;; Load everything from /use (core)
    (ocomacs-load-all-el-at (file-name-concat user-emacs-directory "use"))
    ;; creamsody-darker default theme
    (ocomacs-load-theme 'creamsody-darker)
    (creamsody-modeline)

    ;; Load user config ------------------------------
    ;; (**note: user custom.el is set at top**)
    
    ;; User/Local packages
    ;; ~/.config/ocomacs/packages.el
    (ocomacs-when-exists-load (ocomacs-user-path "packages.el"))
    
    ;; User/local emacs init.el -
    (ocomacs-when-exists-load ocomacs-local-emacs-conf)
    
    ;; User/local emacs ~/.config/ocomacs/use - I will add my personal package config here
    (ocomacs-load-all-el-at (ocomacs-user-path "use"))))
