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
  "ocodmacs/core: Join LINES a list of strings with newline separators."
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

(defun ocomacs-install-github-release-asset-to-dir
    (gh-repo release-asset to-dir
	     &optional do-unzip unzip-pattern do-remove completed-message)
  "Fetch a RELEASE-ASSET from a GH-REPO and place it in TO-DIR.

Optional params:

DO-UNZIP (when non-nil)
filtered by UNZIP-PATTERN (a glob),
DO-REMOVE (when non-nil) the zip asset
and/or show COMPLETED-MESSAGE, when done."
  (interactive)
;;; TODO ;;;
  
  )

(defun ocomacs-install-or-update-ocodo-mono-fonts ()
  "Install OcodoMono Nerd Font in ~/.local/share/fonts."
  (interactive)
  (async-shell-command (concat "cd ~/.local/share/fonts && "
			       "wget -N"
			       "https://github.com/"
			       "ocodo/ocodo-mono"
			       "/releases/latest/download/"
			       "OcodoMono-NerdFont.zip && "
			       "unzip -o OcodoMono-NerdFont.zip '*ttf' && "
			       "rm -v OcodoMono-NerdFont.zip && "
			       "echo 'OcodoMono Font install complete'")))

(defun ocomacs-install-or-update-ocodo-mono-dotzero-fonts ()
  "Install OcodoMonoDotZero Nerd Font in ~/.local/share/fonts."
  (interactive)
  (async-shell-command (concat "cd ~/.local/share/fonts && "
			       "wget -N "
			       "https://github.com/"
			       "ocodo/ocodo-mono-dotzero/"
			       "releases/latest/download/"
			       "OcodoMonoDotZero-NerdFont.zip && "
			       "unzip -o OcodoMonoDotZero-NerdFont.zip '*ttf' && "
			       "rm -v OcodoMonoDotZero-NerdFont.zip && "
			       "echo 'OcodoMonoDotZero Font install complete'")))

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

(defun ocomacs-load-theme (theme)
  "Load custom THEME.

Load THEME exclusively, disabling any other enabled theme.

When called with universal arg, it will append the theme to `custom-enabled-themes'."
  (interactive
   (list
    (intern (completing-read "Load custom theme: "
                             (mapcar #'symbol-name
				     (custom-available-themes))))
    ))
  (unless (custom-theme-name-valid-p theme)
    (error "Invalid theme name `%s'" theme))
  (unless current-prefix-arg
    (dolist (theme custom-enabled-themes) (disable-theme theme))
    (setq custom-enabled-themes nil))
  (load-theme theme t))

(defun ocomacs-delete-this-buffer-and-file (NO-CONFIRM)
  "Delete kill file and buffer, prefix arg non-zero NO-CONFIRM ."
  (interactive "P")
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "'%s' is not a file buffer" name)
      (when (or force (yes-or-no-p (format  "Delete '%s', Are you sure? " filename)))
        (delete-file filename)
        (kill-buffer buffer)
        (message "Deleted '%s'" filename)))))

(defun ocomacs-eval-and-replace ()
  "Replace the preceding sexp with its result."
  (interactive)
  (backward-kill-sexp)
  (condition-case nil
      (insert (format "%s" (eval (read (current-kill 0)))))
    (error (message "Invalid expression")
           (insert (current-kill 0)))))

(defun ocomacs-duplicate-sexp (arg)
  "Duplicate sexp, follows the ARG rules of `kill-sexp'."
  (interactive "p")
  (kill-sexp arg)
  (yank)
  (yank))

(defun ocomacs-replace-region-with (fn)
  "Replace current region using FN."
  (let* ((input (buffer-substring-no-properties (region-beginning) (region-end)))
         (output (funcall fn input)))
    (delete-region (region-beginning) (region-end))
    (insert (if (stringp output) output
              (format "%S" output)))))

(defun ocomacs-replace-thing-at-point-with (fn)
  "Get the current thing at point.
Replace with the return value of the function FN"
  (let* ((pos1 (car (bounds-of-thing-at-point 'symbol)))
         (pos2 (cdr (bounds-of-thing-at-point 'symbol)))
         replacement
         excerpt)
    (when (> pos1 0)
      (setq pos1 (- pos1 1)))
    (setq excerpt (buffer-substring-no-properties pos1 pos2))
    (setq replacement (funcall fn excerpt))
    (delete-region pos1 pos2)
    (insert replacement)))

(defmacro ocomacs-*-and-replace (name evaluator)
  "Create a command NAME which replace region with result of EVALUATOR.

For example:

Using `shell-command-to-string', we can make a replace-region
command with `ocomacs-*-and-replace'

```lisp
 (ocomacs-*-and-replace shell-command-eval-and-replace #\='shell-command-to-string)

;; =>
;; (shell-command-eval-and-replace)
```"
  `(defun ,name ()
     (interactive)
     (if (not (region-active-p))
         (ocomacs-replace-thing-at-point-with ,evaluator)

       (ocomacs-replace-region-with ,evaluator))))

(ocomacs-*-and-replace ocomacs-calc-eval-replace-at-region-or-point #'calc-eval)
(ocomacs-*-and-replace ocomacs-shell-command-eval-replace-at-point-or-region #'shell-command-to-string)

(defun ocomacs-toggle-window-split ()
  "Toggle the current window split

i.e. horizontal -> vertical -> horizontal."
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))

(defun ocomacs-shell-command-to-insert (command)
  "Execute shell COMMAND and insert the result."
  (interactive (list (read-shell-command "Shell Command (output insert at point): ")))
  (insert (shell-command-to-string command)))

(defun ocomacs-write-region ()
  "If a region is marked, write it to a new file.
If not, write the whole buffer to a new file"
  (interactive)
  (if (region-active-p)
      (call-interactively #'write-region)
    (save-mark-and-excursion
      (call-interactively #'mark-whole-buffer)
      (call-interactively #'write-region))))

(defun ocomacs-rename-this-buffer-and-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name))
        (read-file-name-function 'read-file-name-default))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (error "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file filename new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)
               (message
		"File '%s' successfully renamed to '%s'"
		name
		(file-name-nondirectory new-name))))))))
