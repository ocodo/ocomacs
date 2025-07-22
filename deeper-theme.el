;;; deeper-theme.el --- Custom theme for faces  -*- lexical-binding:t -*-

;; Copyright (C) 2011-2025 Free Software Foundation, Inc.

;; Author: Jason Milkins <jasonm23@gmail.com>
;; Based on Deeper Blue - by Scott Frazer <frazer.scott@gmail.com>

;; This file is part of ocomacs
;; This file is NOT part of GNU Emacs

;;; Code:

;;;###theme-autoload
(deftheme deeper
  "Face colors using a deep blue background."
  :background-mode 'dark
  :kind 'color-scheme)

(let ((class '((class color) (min-colors 89))))
  (custom-theme-set-faces
   'deeper
   `(Info-title-1-face ((,class (:family "helv" :weight bold :height 1.728))))
   `(Info-title-2-face ((,class (:family "helv" :weight bold :height 1.44))))
   `(Info-title-3-face ((,class (:family "helv" :weight bold :height 1.2))))
   `(Info-title-4-face ((,class (:family "helv" :weight bold))))
   `(compilation-column-number ((,class (:foreground "LightGreen"))))
   `(compilation-error ((,class (:foreground "Red1"))))
   `(compilation-info ((,class (:weight normal :foreground "LightSkyBlue"))))
   `(compilation-line-number ((,class (:foreground "LightGreen"))))
   `(compilation-mode-line-exit ((,class (:foreground "blue4"))))
   `(cperl-array-face ((,class (:foreground "yellow2"))))
   `(cperl-hash-face ((,class (:foreground "coral1"))))
   `(cursor ((,class (:background "green"))))
   `(default ((,class (:background "#131718" :foreground "gray80"))))
   ;; `(diff-added ((,class (nil))))
   ;; `(diff-changed ((,class (nil))))
   `(diff-context ((,class (:foreground "seashell4"))))
   `(diff-file-header ((,class (:background "grey20"))))
   `(diff-function ((,class (:inherit diff-header))))
   `(diff-header ((,class (:background "grey10"))))
   `(diff-hunk-header ((,class (:inherit diff-header))))
   `(diff-index ((,class (:inherit diff-file-header))))
   `(diff-indicator-added ((,class (:foreground "white" :background "darkgreen"))))
   `(diff-indicator-changed ((,class (:foreground "white" :background "dodgerblue4"))))
   `(diff-indicator-removed ((,class (:foreground "white" :background "indianred4"))))
   `(diff-refine-added ((,class (:foreground "white" :background "darkgreen"))))   
   `(diff-refine-changed ((,class (:background "darkslateblue"))))
   `(diff-refine-removed ((,class (:foreground "white" :background "orangered4"))))
   `(dired-marked ((,class (:background "dodgerblue3" :foreground "white"))))
   `(ediff-current-diff-A ((,class (:background "green4" :foreground "white"))))
   `(ediff-current-diff-B ((,class (:background "darkorange3" :foreground "white"))))
   `(ediff-even-diff-B ((,class (:background "Grey50" :foreground "White"))))
   `(ediff-fine-diff-A ((,class (:background "skyblue4" :foreground "white"))))
   `(ediff-fine-diff-B ((,class (:background "cyan4" :foreground "white"))))
   `(ediff-odd-diff-A ((,class (:background "Grey50" :foreground "White"))))
   `(error ((,class (:foreground "red"))))
   `(flymake-errline ((,class (:background unspecified :underline "red"))))
   `(flymake-warnline ((,class (:background unspecified :underline "magenta3"))))
   `(font-lock-builtin-face ((,class (:foreground "lightstategray"))))
   `(font-lock-comment-delimiter-face ((,class (:foreground "gray35"))))
   `(font-lock-comment-face ((,class (:foreground "gray40"))))
   `(font-lock-constant-face ((,class (:foreground "mediumslateblue"))))
   `(font-lock-doc-face ((,class (:foreground "moccasin"))))
   `(font-lock-function-name-face ((,class (:foreground "papayawhip"))))
   `(font-lock-keyword-face ((,class (:foreground "lightstategray"))))
   `(font-lock-preprocessor-face ((,class (:foreground "gold"))))
   `(font-lock-reference-face ((,class (:foreground "LightCoral"))))
   `(font-lock-regexp-grouping-backslash ((,class (:weight bold))))
   `(font-lock-regexp-grouping-construct ((,class (:weight bold))))
   `(font-lock-string-face ((,class (:foreground "lightstategrey"))))
   `(font-lock-type-face ((,class (:foreground "CadetBlue1"))))
   `(font-lock-variable-name-face ((,class (:foreground "SeaGreen2"))))
   `(fringe ((,class (:background "black"))))
   `(highlight ((,class (:background "DodgerBlue4"))))
   `(ido-first-match ((,class (:weight normal :foreground "orange"))))
   `(ido-only-match ((,class (:foreground "green"))))
   `(ido-subdir ((,class (:foreground unspecified :inherit font-lock-keyword-face))))
   `(image-dired-thumb-flagged ((,class (:background "Red1"))))
   `(image-dired-thumb-mark ((,class (:background "dodgerblue3"))))
   `(info-header-node ((,class (:foreground "Lightslateblue1"))))
   `(info-header-xref ((,class (:foreground "SeaGreen2"))))
   `(info-menu-header ((,class (:family "helv" :weight bold))))
   `(info-node ((,class (:foreground "Lightslateblue1"))))
   `(info-xref ((,class (:foreground "SeaGreen2"))))
   `(isearch ((,class (:background "coral2" :foreground "white"))))
   `(isearch-lazy-highlight-face ((,class (:background "coral4" :foreground "white"))))
   `(lazy-highlight ((,class (:background "cadetblue" :foreground "white"))))
   `(match ((,class (:background "DeepPink4"))))
   `(minibuffer-prompt ((,class (:foreground "CadetBlue1"))))
   `(mode-line ((,class (:background "gray25" :foreground "gray90"))))
   `(mode-line-buffer-id ((,class (:weight bold :background unspecified :foreground "white"))))
   `(mode-line-inactive ((,class (:background "gray35" :foreground "gray70"))))
   `(outline-1 ((,class (:foreground "SkyBlue1"))))
   `(outline-2 ((,class (:foreground "CadetBlue1"))))
   `(outline-3 ((,class (:foreground "LightSteelBlue1"))))
   `(outline-4 ((,class (:foreground "turquoise2"))))
   `(outline-5 ((,class (:foreground "aquamarine1"))))
   `(primary-selection ((,class (:background "blue3"))))
   `(region ((,class (:background "#103050"))))
   `(show-paren-match-face ((,class (:background "dodgerblue1" :foreground "white"))))
   `(show-paren-mismatch-face ((,class (:background "red1" :foreground "white"))))
   `(success ((,class (:foreground "SeaGreen2"))))
   `(warning ((,class (:foreground "Yellow"))))))

(provide-theme 'deeper)

;;; deeper-theme.el ends here
