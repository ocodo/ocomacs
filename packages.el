;; Pacakages to install
;; Core
(straight-use-package 's)
(straight-use-package 'emacs-dashboard)
(straight-use-package 'which-key)
(straight-use-package 'editorconfig)
(straight-use-package 'move-text)
(straight-use-package 'iedit)
(straight-use-package 'company)
(straight-use-package 'lsp-mode)
(straight-use-package 'vertico)
(straight-use-package 'orderless)
(straight-use-package 'marginalia)

;; Git
(straight-use-package 'magit)
(straight-use-package 'git-timemachine)
(straight-use-package 'diff-hl)

;; Additional Languages
(straight-use-package 'markdown-mode)
(straight-use-package 'anaconda-mode)
(straight-use-package 'lua-mode)
;; Add more langs via ~/.config/ocomacs/

;; See ./use/use-treesit-auto.el for config
(straight-use-package 'treesit-auto)

;; Snippets
(straight-use-package 'yasnippet)
(straight-use-package 'yasnippet-snippets)
;; Ollama LLM access
(straight-use-package 'ellama)
;; Potentiall dropped - Move to ~/.config/ocomacs/

;; Presentation Core
(straight-use-package 'all-the-icons)
;; (straight-use-package 'simple-modeline)
(straight-use-package
 '(lambda-line
   :type git
   :host github
   :repo "Lambda-Emacs/lambda-line"))

;; Default Theme (creamsody, creamsody-darker)
(straight-use-package 'creamsody-theme)
