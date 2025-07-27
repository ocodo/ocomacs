(use-package lambda-line
  :custom
  (lambda-line-vc-symbol "   ")
  (lambda-line-abbrev t) ;; abbreviate major modes
  (lambda-line-hspace "  ")  ;; add some cushion
  (lambda-line-prefix t) ;; use a prefix symbol
  (lambda-line-prefix-padding nil) ;; no extra space for prefix 
  (lambda-line-status-invert nil)  ;; no invert colors
  (lambda-line-gui-ro-symbol  " ⊖ ") ;; symbols
  (lambda-line-gui-mod-symbol " ◌ ") 
  (lambda-line-gui-rw-symbol  " ◯ ") 
  (lambda-line-space-top +.50)  ;; padding on top and bottom of line
  (lambda-line-space-bottom -.50)
  (lambda-line-symbol-position 0.1) ;; adjust the vertical placement of symbol
  :config
  (lambda-line-mode t))
