;;; console-basic-theme.el --- console-basic
;;; Version: 1.0
;;; Commentary:
;;; A theme called console-basic
;;; Code:

(deftheme console-basic "DOCSTRING for console-basic")
  (custom-theme-set-faces 'console-basic
   '(default ((t (:foreground "#ffffff" :background "#282828" ))))
   '(cursor ((t (:background "#ffffff" ))))
   '(fringe ((t (:background "#ffffff" ))))
   '(mode-line ((t (:foreground "#000000" :background "#ffffff" ))))
   '(region ((t (:background "#ffffff" ))))
   '(secondary-selection ((t (:background "#383838" ))))
   '(font-lock-builtin-face ((t (:foreground "#ffffff" ))))
   '(font-lock-comment-face ((t (:foreground "#ffffff" ))))
   '(font-lock-function-name-face ((t (:foreground "#ffffff" ))))
   '(font-lock-keyword-face ((t (:foreground "#ffffff" ))))
   '(font-lock-string-face ((t (:foreground "#ffffff" ))))
   '(font-lock-type-face ((t (:foreground "#ffffff" ))))
   '(font-lock-constant-face ((t (:foreground "#ffffff" ))))
   '(font-lock-variable-name-face ((t (:foreground "#ffffff" ))))
   '(minibuffer-prompt ((t (:foreground "#959595" :bold t ))))
   '(font-lock-warning-face ((t (:foreground "red" :bold t ))))
   )

;;;###autoload
(and load-file-name
    (boundp 'custom-theme-load-path)
    (add-to-list 'custom-theme-load-path
                 (file-name-as-directory
                  (file-name-directory load-file-name))))
;; Automatically add this theme to the load path

(provide-theme 'console-basic)

;;; console-basic-theme.el ends here
