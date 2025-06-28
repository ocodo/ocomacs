;; Bare bones - config 2025
(setq inhibit-splash-screen 1)
(setopt use-short-answers t)
(setq package-enable-at-startup nil)
(setq ring-bell-function 'ignore)
(when (not initial-window-system) (xterm-mouse-mode 1))
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
(straight-use-package 'lsp-mode)
(straight-use-package 'vertico)
(straight-use-package 'orderless)
(straight-use-package 'ellama)
(straight-use-package 'magit)
(straight-use-package 'kurecolor)
(straight-use-package 'markdown-mode)
(straight-use-package 'jtsx)
(straight-use-package 'tide)
(straight-use-package 'company)
(straight-use-package 'anaconda-mode)
(straight-use-package 'lua-mode)
(straight-use-package 'lsp-javascript-typescript)
(straight-use-package 'lsp-pyright)

(straight-use-package 'all-the-icons)
(straight-use-package
 '(lambda-line
   :type git
   :host github
   :repo "Lambda-Emacs/lambda-line"))

;; Load creamsody, make it darker
(load-theme 'creamsody 1)
(load-theme 'creamsody-darker 1)

;; Straight enabled package config
;; Load everything from /use
(mapc
 'load
 (file-expand-wildcards
  (file-name-concat user-emacs-directory "use/*.el")))
