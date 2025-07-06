(use-package treesit-auto
  :custom
  (treesit-auto-install t)

  :config
  (setq
   treesit-auto-langs
   '(json markdown python tsx typescript javascript go yaml))

  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; The full treesit-auto-langs for ref
;; '(awk bibtex blueprint c c-sharp clojure cmake commonlisp cpp css dart dockerfile elixir glsl go gomod heex html janet java javascript json julia kotlin latex lua magik make markdown nix nu org perl proto python r ruby rust scala sql surface toml tsx typescript typst verilog vhdl vue wast wat wgsl yaml))
