;;; external dependencies rule : minimal from emacs lisp, no external packages.
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

(defun om-lines (&rest lines)
  "Join LINES a list of strings with newline separators."
  (string-join lines "\n"))

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

(defun ocomacs-reload ()
  "Reload config."
  (interactive)
  (load (file-name-concat user-emacs-directory "init.el")))

(defun ocomacs-sync ()
  "Sync from ocomacs mainline."
  (interactive)
  (async-shell-command
   (format
    "TERM=dumb git -C %s pull --rebase --autostash"
    user-emacs-directory))
  (straight-rebuild-all)
  (ocomacs-reload))

(defun ocomacs-get-font-name-weight-string (font)
  (apply 'format (list
  (format
   "%s-%s"
   (font-get font :family)
   (font-get font :weight)))))

(defun ocomacs-system-fonts ()
  "List of system fonts."
  (x-list-fonts "*"))

(defun ocomacs-set-default-face ()
  "Set the default font and height interactively."
  (interactive)
  (let* ((selected-font
	  (completing-read "Select default font: "
			   (ocomacs-system-fonts)))

	 (selected-size
	  (read-number "Select default font size: " 12)))

    (set-face-attribute 'default nil :font selected-font )
    (set-face-attribute 'default nil :height (* 10 selected-size))))

(defun ocomacs-install-or-update-ocodo-mono-fonts ()
  "Install OcodoMono Nerd Font in ~/.local/share/fonts."
  (interactive)
  (async-shell-command (concat "cd ~/.local/share/fonts && "
			       "wget -N https://github.com/ocodo/ocodo-mono/releases/latest/download/"
			       "OcodoMono-NerdFont.zip && "
			       "unzip -o OcodoMono-NerdFont.zip '*ttf' && "
			       "rm -v OcodoMono-NerdFont.zip && "
			       "echo 'OcodoMono Font install complete'")))

(defun ocomacs-user-font-config-from-default-face ()
  "Save/replace the ocomacs user font config from the current
default face."
  (interactive)
  (let ((user-font-default-lisp (file-name-concat ocomacs-default-user-dir "ocomacs-gui-font.el"))
	(font-family (face-attribute 'default :family))
	(font-height (face-attribute 'default :height))
	(font-weight (face-attribute 'default :weight)))	
    (message
     "Writing user font default: %s" user-font-default-lisp)
    (with-temp-file
	user-font-default-lisp
      (insert
       (format ";;; Config your preferred font and font-size

;;; Install ocodo-mono at ~/.local/share/fonts with (ocomacs-install-or-update-ocodo-mono-fonts)
;;; View at https://github.com/ocodo/ocodo-mono
;;; Download complete font set zip
;;; https://github.com/ocodo/ocodo-mono/releases/latest/download/OcodoMono-NerdFont.zip

(defvar ocomacs-personal-mono-font
  (font-spec
   :family \"%s\"
   :weight '%s)
  \"Personal default monospaced - font spec - Nerd Fonts recommended\")

(defvar ocomacs-preferred-font-height
  %s \"height in 1/10pt\")"
	       font-family
	       font-weight
	       font-height)))))

(defun ocomacs-default-font-config ()
  "Get `ocomacs-personal-mono-font' and `ocomacs-preferred-font-height'
from core or ocomacs user config.

Then set default face font and height.

If the ocomacs-default (OcodoMono Nerd Font) and the user preferred font
is not configured.  Ask for the user to select the preffered font and h"
  (interactive)
  (let ((ocomacs-gui-font-config
	 (if (file-exists-p (ocomacs-user-path "ocomacs-gui-font.el"))
	     (ocomacs-user-path "ocomacs-gui-font.el")
	    (ocomacs-lisp-path "ocomacs-gui-font.el"))))

    (load ocomacs-gui-font-config)

    (if (and
	 (bound-and-true-p ocomacs-personal-mono-font)
	 ;; find font in OS
	 (x-list-fonts (format "*-%s-*"
	  (ocomacs-get-font-name-weight-string
	   ocomacs-personal-mono-font))))

	(set-face-attribute
	 'default nil
	 :height ocomacs-preferred-font-height
	 :font ocomacs-personal-mono-font)
      (ocomacs-set-default-face)
      (ocomacs-user-font-config-from-default-face))))
