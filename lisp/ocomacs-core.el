;;; external dependencies rule : minimal from emacs lisp, no external packages.
(defun ocomacs-reload ()
  "Reload config."
  (interactive)
  (load (file-name-concat user-emacs-directory "init.el")))

;;; minimal core for config management:
(defun ocomacs-lisp-path (&rest path-components)
  "Generate full path for PATH-COMPONENTS in ocomacs lisp."
  (apply 'file-name-concat (append (list user-emacs-directory "lisp") path-components)))

(defun ocomacs-load-core-lisp (script)
  "Load lisp at ocomacs-lisp-path SCRIPT."
  (load (ocomacs-lisp-path script)))

(defun ocomacs-load-all-el-at (pathname)
  "Load all lisp from a given PATHNAME." 
  (mapcar
   'load
   (seq-filter
    ;; filter lock/recovery files
    (lambda (file) (not (string-match "#" file)))
    ;; Generate wildcard .el list for PATHNAME
    (file-expand-wildcards (format "%s/*.el" pathname)))))

;; user config
(defvar ocomacs-default-user-dir "~/.config/ocomacs/"
  "Default directory for ocomacs user config.")

(defun ocomacs-env ()
  "OCOMACSDIR env."
  (getenv "OCOMACSDIR"))

(defun ocomacs-user-dir ()
  "Current ocomacs user dir."
  (or (ocomacs-env) ocomacs-default-user-dir))

(defun ocomacs-user-path (&rest pathname)
  "Generate ocomacs user path for PATHNAME."
  (apply 'file-name-concat (append (list (ocomacs-user-dir)) pathname)))

(defun ocomacs-load-user (path-elements)
  "Load lisp at ocomacs-user PATH-ELEMENTS."
  (load (ocomacs-user-path path-elements)))

(defun ocomacs-create-user-dir (&optional subpath)
  "Create ocomacs-user-dir.

If the optional parameter SUBPATH is non-nil then it should be
the subpath string."
  (make-directory (ocomacs-user-path subpath) t))

(defun ocomacs--load-lisp-after-body (el-pathname &rest body)
  "Run BODY and Load lisp from EL-PATHNAME if it has the file
extension .el."
  (if (not (string-match-p "[.]el$" el-pathname))
      (error "%s is not an emacs-lisp filename")
    body
    (when (file-exists-p el-pathname)
      (load el-pathname))))

;;; Test
;; (ocomacs--load-lisp-after-body
;;  (ocomacs-lisp-path "test.el")
;;  (message "testing123 -- does this first"))

(defun ocomacs-file-write-text (string pathname)
  "Write STRING to PATHNAME."
  (with-temp-file pathname (insert string)))

(defun ocomacs-create-or-load (pathname &optional default-content)
  "Load lisp at PATHNAME in `(ocomacs-dir)' when exists.

If the optional parameter DEFAULT-CONTENT is non-nil, the
PATHNAME will be created with the DEFAULT-CONTENT and then
loaded."
  (ocomacs--load-lisp-after-body
   pathname
   (unless (file-exists-p pathname)
     (when default-content
       (let ((new-dirname (file-name-directory pathname)))
	 (when (and
		new-dirname
		(not (file-directory-p new-dirname)))
	   (make-directory new-dirname))
	 (ocomacs-file-write-text default-content pathname))))))


(defun ocomacs-when-exists-load (pathname)
  "Load the file at PATHNAME"
  (when (file-exists-p pathname)
    (load pathname)))
  

;;; Test 
;;; (ocomacs-create-or-load
;;;  (ocomacs-lisp-path "test.el")
;;;  "(message \"Does not overwrite...\")")
;;
;; note reading a file from a string is available in
;; cvs-file-to-string


