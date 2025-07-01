;;; minimal core for config management:

(defun ocomacs-default (pathname)
  "Generate ocomacs default path for PATHNAME."
  (file-name-concat user-emacs-directory "lisp" pathname))

(defun ocomacs-load-default (pathname)
  "Load lisp at ocomacs-default PATHNAME."
  (load (ocomacs-default pathname)))

(defun ocomacs-user (pathname)
  "Generate ocomacs user path for PATHNAME."
  (let ((ocomacs-user-path "~/.config/ocomacs/"))
    (file-name-concat ocomacs-user-path pathname)))

(defun ocomacs-load-user (pathname)
  "Load lisp at ocomacs-user PATHNAME."
  (load (ocomacs-user pathname)))

(defun ocomacs-create-config-ocomacs ()
  "Create `~/.config/ocomacs'."
  (make-directory "~/.config/ocomacs" t))

(defun ocomacs-when-exists-load (pathname &optional default-content)
  "Load lisp at PATHNAME when exists, or create with DEFAULT-CONTENT."
  (if (not (string-match "^.*[.]el$" pathname))
      (error "%s is not emacs-lisp")
    (if (file-exists-p pathname)
	(load pathname)
      (when default-content
	(let ((dirname (file-name-directory pathname))
	    (filename (format
		       (file-name-base pathname)
		       (file-name-extension pathname))))
	  (make-directory dirname t)
	  (with-temp-file pathname (insert default-content)))))))
