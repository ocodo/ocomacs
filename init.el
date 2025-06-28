;; Bare bones - config 2025
(setq inhibit-splash-screen 1)
(setopt use-short-answers t)
(setq package-enable-at-startup nil)
(setq ring-bell-function 'ignore)
(menu-bar-mode 0)

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
(setq straight-use-package-by-default 1)

;; Pacakages to install
(straight-use-package 'creamsody-theme)
(straight-use-package 's)
(straight-use-package 'move-text)
(straight-use-package 'which-key)
(straight-use-package 'vertico)
(straight-use-package 'orderless)
(straight-use-package 'ellama)
(straight-use-package 'magit)
(straight-use-package 'kurecolor)
(straight-use-package 'markdown-mode)

;; Straight enabled package config
(load-theme 'creamsody 1)
(load-theme 'creamsody-darker 1)

;; Load everything from /use
(mapc
 'load
 (file-expand-wildcards
  (file-name-concat user-emacs-directory "use/*.el")))
