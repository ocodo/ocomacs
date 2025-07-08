(let* ((ocomacs-footer-messages (list
				 "You can think of a better footer message, customize it."
				 "OCOMACS ← TECO editor macros 1976"
				 "Emacs start as $EDITOR, also the ocomacs goal"
				 (om-lines
				  "Emacs start in roughly one second, the ocomacs goal"
				  "(no promises though...)")
				 (om-lines
				  "In Emacs Ctrl + G is cancel..."
				  "(not intuitive, but very useful!)")
				 (om-lines
				  "In Emacs Ctrl + X, Ctrl + C is exit Emacs"
				  "(it's not super intuitive.)")
				 "Emacs-lisp learn (maybe-p (like-it ,@you))"
				 "Life is a x[⍋x←6?40]"
				 "Fork it, sail away"
				 "This footer message intentionally left blank"))
       (assets (file-name-concat user-emacs-directory "assets"))       
       (ocomacs-dashboard-banner (file-name-concat assets
						   (if initial-window-system
						       (cond
							((image-type-available-p 'svg)
							 "ocomacs-logo.svg")
							((image-type-available-p 'png)
							 "ocomacs-logo.png"))
						     "1.txt"))))
  (use-package dashboard
    :init
    (setq 
     dashboard-buffer-name "*ocomacs*"
     dashboard-banner-logo-title "a post Doom, configuration framework for Emacs 29+"
     dashboard-center-content t
     dashboard-display-icons-p t
     dashboard-items '((recents . 5) (projects . 5) (agenda . 5) (bookmarks . 5))
     dashboard-footer-messages ocomacs-footer-messages
     dashboard-startup-banner ocomacs-dashboard-banner)
    (dashboard-setup-startup-hook)))
