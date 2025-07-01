(let* ((assets (file-name-concat user-emacs-directory "assets"))
       (image-banner (file-name-concat assets "ocomacs-logo.svg"))
       (text-banner (file-name-concat assets "1.txt")))

  (use-package dashboard
    :init
    (setq 
     dashboard-startup-banner (cons image-banner text-banner)
     dashboard-banner-logo-title "a post Doom, configuration framework for Emacs 29+"
     dashboard-footer-messages '(
				 "if you can think of a better footer message, customize it."
				 "In the 70s the future was cool"
				 "mnml editor macros framework goals"
				 "Emacs in a second, that's the ocomacs goal (~2sec is ok)"
				 "Emacs-lisp learn (maybe-p (like-it ,@you))"
				 "learn you a Haskell to annoy APL heads (monads were simple in '66)"
				 "Renegade...x[⍋x←6?40]"
				 ))  
    (dashboard-setup-startup-hook)))
