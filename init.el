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

(defvar ocomacs-user-themes (list 'creamsody 'creamsody-dark)
  "Emacs themes cascade, multiple can be applied.")

;; Bare bones UI
(progn
  (setq inhibit-splash-screen 1)
  (setq package-enable-at-startup nil)
  (setq ring-bell-function 'ignore)
  (tool-bar-mode 0)
  (menu-bar-mode 0)
  (scroll-bar-mode 0)
  (setopt use-short-answers t))

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
    (load-theme 'deeper-blue nil nil) ;; git commit early exit =>
  
  ;; ---8<---------------------------------------------------------
  
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

    ;; Load everything from /use
    (ocomacs-load-all-el-at (file-name-concat user-emacs-directory "use"))

    ;; User/Local packages - can override core
    ;; ~/.config/ocomacs/packages.el
    (ocomacs-when-exists-load (ocomacs-user-path "packages.el"))

    ;; Load user general config and set custom
    (let ((local-emacs-conf (ocomacs-user-path "local.el"))
	  (local-emacs-custom (ocomacs-user-path "custom.el")))
      (setq custom-file local-emacs-custom)
      (ocomacs-when-exists-load local-emacs-conf))

    ;; Get theme list and apply themes
    (if (bound-and-true-p ocomacs-user-themes)
	;; Load user theme(s)
	(dolist (theme ocomacs-user-themes)
	  (load-theme theme 1)))))
