(image-type-available-p 'png)

(let* ((assets (file-name-concat user-emacs-directory "assets"))
       (dashboard-banner (file-name-concat assets
					   (if initial-window-system
					       (cond
						((image-type-available-p 'svg) "ocomacs-logo.svg")
						((image-type-available-p 'png) "ocomacs-logo.png"))
					     "1.txt"))))
  (use-package dashboard
    :init
    (setq 
     dashboard-startup-banner dashboard-banner
     dashboard-banner-logo-title "a post Doom, configuration framework for Emacs 29+"
     dashboard-footer-messages '(
				 "if you can think of a better footer message, customize it."
				 "In the 70s the future was cool"
				 "OCOMACS ← TECO editor macros 1976"
				 "Emacs start in under a second the ocomacs goal"
				 "Emacs-lisp learn (maybe-p (like-it ,@you))"
				 "Life is a x[⍋x←6?40]"
				 "fork it, sail away"
				 "Lisp... weird but cool"
				 ))
    (dashboard-setup-startup-hook)))
