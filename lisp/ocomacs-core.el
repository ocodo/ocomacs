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

(defun ocomacs-when-exists-load (pathname &optional default-content)
  "Load lisp at PATHNAME when exists, or create with DEFAULT-CONTENT."
  (if (file-exists-p pathname)
      (load pathname)))





