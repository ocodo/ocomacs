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
(setq inhibit-splash-screen 1)
(setopt use-short-answers t)
(setq package-enable-at-startup nil)
(setq ring-bell-function 'ignore)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

;;; Edit font preference in ~/.config/ocomacs/emacs-font.el
;;; load font config...
(let ((emacs-font-cfg "gui-font.el"))
  (if (file-exists-p (ocomacs-user emacs-font-cfg))
      (load emacs-default-font-cfg)
    (load (ocomacs-default emacs-font-cfg))))

;; GUI Specific...
(when initial-window-system
  (when (and
	 (bound-and-true-p personal-mono-font)
	 (fontp personal-mono-font))
      (set-face-attribute
       'default nil
       :height preferred-font-size
       :font personal-mono-font)))
  
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
	     (concat "https://raw.githubusercontent.com/"
		     "radian-software/straight.el/"
		     "develop/install.el")
             'silent 'inhibit-cookies)
	  (goto-char (point-max))
	  (eval-print-last-sexp)))
      (load bootstrap-file nil 'nomessage))

    ;; Require use-package
    (straight-use-package 'use-package)
    (setq straight-use-package-by-default t)

    ;; Straight enabled package config - core packages
    (load (file-name-concat user-emacs-directory "packages.el"))
    ;; User/Local packages
    (ocomacs-when-exists-load (ocomacs-user "packages.el"))

    ;; Load everything from /use
    (mapc
     'load
     ;; everything except revovery files
     (seq-filter (lambda (file) (not (string-match "#" file))) 
      (file-expand-wildcards
       (file-name-concat user-emacs-directory "use/*.el"))))    

    (let ((local-emacs-conf (ocomacs-user "local.el"))
	  (local-emacs-custom (ocomacs-user "custom.el")))
      (setq custom-file local-emacs-custom)
      (ocomacs-when-exists-load local-emacs-conf))

    ;; Get theme list
    (if (bound-and-true-p ocomacs-user-themes)
      ;; Load user theme(s)
      (dolist (theme ocomacs-user-themes)
	(load-theme theme 1)))))
