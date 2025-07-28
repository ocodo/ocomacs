;; This file is part of ocomacs
;;
(deftheme soothe
  "sooth-theme
   Created : Tue Jul 17 18:21:38 2012 - Jason Milkins.
   Updated : Mon Jul 28 10:26:23 2025 - Jason Milkins.
   Contact : jasonm23@gmail.com
   licence : MIT

   An amalgam of muted color tones and highlighted backgrounds.")

(let  (
       ;; named colors
       (gray-1         "#828282")
       (gray-1bg       "#0a0a0a")
       (gray-2         "#333333")
       (gray-2bg       "#111111")
       (gray-3         "#aaaaaa")
       (gray-3bg       "#141414")
       (gray-4         "#252525")
       (gray-4bg       "#171717")
       (gray-5         "#2a2a2a")
       (gray-5bg       "#1a1a1a")
       (gray-6         "#202020")
       (gray-6bg       "#1e1e1e")

       (red-1          "#d13120")
       (red-1bg        "#1D1515")
       (red-2          "#b23f1e")
       (red-2bg        "#251c1e")
       (red-3          "#64210F")
       (red-3bg        "#492426")

       (brown-1        "#9f621d")
       (brown-1bg      "#2a1f1f")

       (orange-1       "#d97a35")
       (orange-1bg     "#1F1710")

       (orange-2       "#97633E")
       (orange-2bg     "#433222")

       (yellow-1       "#deae3e")
       (yellow-1bg     "#18140C")

       (green-1        "#81af34")
       (green-1bg      "#1a2321")
       (green-2        "#4e9f75")
       (green-2bg      "#1a2321")
       (green-3        "#1A5E39")
       (green-3bg      "#15473D")

       (turquoise-1    "#11535F")
       (turquoise-2    "#07272D")
       (turquoise-1bg  "#05181C")
       (turquoise-2bg  "#041316")

       (blue-1         "#7e9fc9")
       (blue-1bg       "#1e252f")
       (blue-2         "#417598")
       (blue-2bg       "#1b333e")
       (blue-3         "#00959e")
       (blue-3bg       "#132228")
       (blue-4         "#365e7a")
       (blue-4bg       "#172028")

       (purple-1       "#a878b5")
       (purple-1bg     "#1D1B25")
       (purple-2       "#54395A")
       (purple-2bg     "#383649")

       ;; special colors
       (background      "#110F13")
       (alt-background  "#111013")
       (foreground      "#dcdddd")
       (hl-line         "#11151a")
       (selection       "#180B22")
       (delimiter-1     "#3898A7")
       (delimiter-2     "#348B98")
       (delimiter-3     "#2F7E8A")
       (delimiter-4     "#2A717C")
       (delimiter-5     "#25646D")
       (delimiter-6     "#20575F")
       (delimiter-7     "#1F555D")
       (delimiter-8     "#1A4950")
       (delimiter-9     "#123D43")
       (delimiter-10    "#1B3D43")
       (delimiter-error "#eF3000"))

  (custom-theme-set-faces
   'soothe

   ;; Basics
   `(default                                   ((t (:foreground ,foreground  :background ,background                    ))))
   `(cursor                                    ((t (:foreground ,foreground  :background ,orange-2                      ))))
   `(region                                    ((t (                         :background ,selection                     ))))
   `(highlight                                 ((t (:foreground ,blue-3      :background ,blue-3bg                      ))))
   `(hl-line                                   ((t (                         :background ,hl-line                       ))))
   `(minibuffer-prompt                         ((t (:foreground ,orange-1    :background ,orange-1bg                    ))))
   `(escape-glyph                              ((t (:foreground ,red-1       :background ,purple-1bg                    ))))

   ;; Font-lock
   `(font-lock-builtin-face                    ((t (:foreground ,red-2       :background ,red-1bg                       ))))
   `(font-lock-constant-face                   ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))
   `(font-lock-comment-face                    ((t (:foreground ,turquoise-1 :background ,alt-background :italic t      ))))
   `(font-lock-comment-delimiter-face          ((t (:foreground ,turquoise-2 :background ,alt-background :italic t      ))))
   `(font-lock-doc-face                        ((t (:foreground ,blue-3      :background ,gray-1bg                      ))))
   `(font-lock-doc-string-face                 ((t (:foreground ,blue-3      :background ,gray-1bg                      ))))
   `(font-lock-function-name-face              ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   `(font-lock-keyword-face                    ((t (:foreground ,orange-1    :background ,orange-1bg                    ))))
   `(font-lock-negation-char-face              ((t (:foreground ,yellow-1    :background ,yellow-1bg                    ))))
   `(font-lock-preprocessor-face               ((t (:foreground ,orange-1    :background ,orange-1bg                    ))))
   `(font-lock-string-face                     ((t (:foreground ,turquoise-1 :background ,turquoise-2bg                 ))))
   `(font-lock-type-face                       ((t (:foreground ,red-2       :background ,red-2bg :bold nil             ))))
   `(font-lock-variable-name-face              ((t (:foreground ,blue-1      :background ,blue-1bg                      ))))
   `(font-lock-warning-face                    ((t (:foreground ,red-2       :background ,red-2bg                       ))))

   ;; Diff
   `(diff-context                              ((t (:foreground ,foreground                                             ))))
   `(diff-file-header                          ((t (:foreground ,foreground :background ,background                     ))))
   `(diff-function                             ((t (:foreground ,foreground :inherit diff-header                        ))))
   `(diff-header                               ((t (:foreground ,foreground :background ,alt-background                 ))))
   `(diff-hunk-header                          ((t (:foreground ,foreground :inherit diff-header                        ))))
   `(diff-index                                ((t (:foreground ,foreground :inherit diff-file-header                   ))))
   `(diff-added                                ((t (:foreground ,foreground :background ,green-3                        ))))
   `(diff-indicator-added                      ((t (:foreground ,foreground :background ,green-3bg                      ))))
   `(diff-refine-added                         ((t (:foreground ,foreground :background ,green-3bg                      ))))
   `(diff-context                              ((t (:foreground ,foreground :background ,gray-6bg                       ))))
   `(diff-changed                              ((t (:foreground ,foreground :background ,purple-2                       ))))
   `(diff-changed-unspecified                  ((t (:foreground ,foreground :background ,blue-2bg                       ))))
   `(diff-indicator-changed                    ((t (:foreground ,foreground :background ,purple-2bg                     ))))
   `(diff-refine-changed                       ((t (:foreground ,foreground :background ,purple-2bg                     ))))
   `(diff-removed                              ((t (:foreground ,foreground :background ,red-3                          ))))
   `(diff-indicator-removed                    ((t (:foreground ,foreground :background ,red-3bg                        ))))
   `(diff-refine-removed                       ((t (:foreground ,foreground :background ,red-3bg                        ))))
   `(diff-error                                ((t (:foreground ,orange-1   :background ,red-3bg                        ))))

   ;; UI related
   `(link                                      ((t (:foreground ,blue-1      :background ,blue-1bg                      ))))
   `(fringe                                    ((t (                         :background ,gray-3bg                      ))))
   `(mode-line                                 ((t (:foreground ,gray-1      :background ,gray-3bg  :box nil            ))))
   `(mode-line-inactive                        ((t (:foreground ,gray-6      :background ,gray-3bg  :box nil            ))))
   `(vertical-border                           ((t (:foreground ,gray-5      :background ,background                    ))))

   ;; Line numbers
   `(line-number                               ((t (:foreground ,red-3      :background ,alt-background :height 90     ))))

   ;; show-paren-mode
   `(show-paren-match                          ((t (:foreground ,orange-1    :background ,orange-1bg                    ))))
   `(show-paren-mismatch                       ((t (:foreground ,red-2bg     :background ,red-2                         ))))

   ;; ido
   `(ido-only-match                            ((t (:foreground ,green-1     :background ,green-1bg                     ))))
   `(ido-subdir                                ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))

   ;; whitespace-mode
   `(whitespace-empty                          ((t (:foreground ,yellow-1bg  :background ,yellow-1                      ))))
   `(whitespace-hspace                         ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-indentation                    ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-line                           ((t (                         :background ,gray-2                        ))))
   `(whitespace-newline                        ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-space                          ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-space-after-tab                ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-tab                            ((t (:foreground ,gray-2                                                 ))))
   `(whitespace-trailing                       ((t (:foreground ,red-1bg     :background ,red-1                         ))))

   ;; flyspell-mode
   `(flyspell-incorrect                        ((t (:underline ,red-2                                                   ))))
   `(flyspell-duplicate                        ((t (:underline ,red-2                                                   ))))

   ;; magit
   `(magit-diff-add                            ((t (:foreground ,green-1                                                ))))
   `(magit-diff-del                            ((t (:foreground ,red-2                                                  ))))
   `(magit-item-highlight                      ((t (                         :background ,purple-1bg                    ))))
   `(magit-branch-remote-head                  ((t (:foreground ,foreground  :background ,turquoise-2                   ))))
   `(magit-branch-current                      ((t (:foreground ,foreground  :background ,blue-2bg                      ))))

   `(magit-tag                                 ((t (:foreground ,purple-1    :background ,red-1bg                       ))))
   `(magit-hash                                ((t (:foreground ,red-2       :background ,red-1bg                       ))))

   `(magit-diff-revision-summary               ((t (:foreground ,foreground  :background ,purple-2bg                    ))))
   `(magit-diff-revision-summary-highlight     ((t (                         :background ,purple-1bg                    ))))
   `(magit-diff-conflict-heading               ((t (:foreground ,foreground  :background ,blue-2bg                      ))))
   `(magit-diff-context-highlight              ((t (                         :background ,blue-4bg                      ))))
   `(magit-diff-file-heading-highlight         ((t (                         :background ,turquoise-1bg                 ))))
   `(magit-header-line                         ((t (:foreground ,foreground  :background ,purple-1bg                    ))))
   `(magit-diff-file-heading-selection         ((t (:foreground ,foreground  :background ,purple-1bg                    ))))
   `(magit-diff-hunk-heading                   ((t (:foreground ,foreground  :background ,purple-2bg                    ))))
   `(magit-diff-hunk-heading-highlight         ((t (                         :background ,blue-2bg                      ))))
   `(magit-diff-hunk-heading-selection         ((t (:foreground ,foreground  :background ,turquoise-2bg                 ))))
   `(magit-section-heading                     ((t (:foreground ,foreground  :background ,turquoise-1bg                 ))))
   `(magit-section-highlight                   ((t (                         :background ,turquoise-1bg                 ))))

   `(isearch                                   ((t (:foreground ,foreground  :background ,turquoise-1bg ))))
   `(isearch-fail                              ((t (:foreground ,foreground  :background ,red-2bg ))))
   `(isearch-group-1                           ((t (:foreground ,foreground  :background ,turquoise-2bg ))))
   `(isearch-group-2                           ((t (:foreground ,foreground  :background ,purple-2bg ))))

   `(match                                     ((t (:foreground ,foreground  :background ,purple-2bg ))))
   `(cua-rectangle                             ((t (                         :background ,purple-1bg ))))

   ;; company-mode
   `(company-template-field                    ((t (                         :background ,gray-1bg                      ))))
   `(company-tooltip                           ((t (                         :background ,gray-4                        ))))
   `(company-preview                           ((t (                         :background ,gray-4                        ))))
   
   ;; highlight-indentation-mode
   `(highlight-indentation-face                ((t (                         :background ,gray-1bg                      ))))
   `(highlight-indentation-current-column-face ((t (                         :background ,gray-4                        ))))

   ;; ECB
   `(ecb-default-general-face                  ((t (:foreground ,gray-3      :background ,gray-1bg                      ))))
   `(ecb-default-highlight-face                ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   `(ecb-method-face                           ((t (:foreground ,red-1       :background ,red-1bg                       ))))
   `(ecb-tag-header-face                       ((t (                         :background ,blue-2bg                      ))))

   ;; org-mode
   `(org-date                                  ((t (:foreground ,purple-1    :background ,purple-1bg                    ))))
   `(org-done                                  ((t (:foreground ,green-1     :background ,green-1bg                     ))))
   `(org-hide                                  ((t (:foreground ,gray-2      :background ,gray-1bg                      ))))
   `(org-link                                  ((t (:foreground ,blue-1      :background ,blue-1bg                      ))))
   `(org-todo                                  ((t (:foreground ,red-1       :background ,red-1bg                       ))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face	       ((t (:foreground ,delimiter-1 ))))
   `(rainbow-delimiters-depth-2-face	       ((t (:foreground ,delimiter-2 ))))
   `(rainbow-delimiters-depth-3-face	       ((t (:foreground ,delimiter-3 ))))
   `(rainbow-delimiters-depth-4-face	       ((t (:foreground ,delimiter-4 ))))
   `(rainbow-delimiters-depth-5-face	       ((t (:foreground ,delimiter-5 ))))
   `(rainbow-delimiters-depth-6-face	       ((t (:foreground ,delimiter-6 ))))
   `(rainbow-delimiters-depth-7-face	       ((t (:foreground ,delimiter-7 ))))
   `(rainbow-delimiters-depth-8-face	       ((t (:foreground ,delimiter-8 ))))
   `(rainbow-delimiters-depth-9-face	       ((t (:foreground ,delimiter-9 ))))
   `(rainbow-delimiters-depth-10-face	       ((t (:foreground ,delimiter-10 )))))

  (custom-theme-set-variables
   'soothe

   `(ansi-color-names-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [,background ,red-1 ,green-1 ,yellow-1 ,blue-1 ,purple-1 ,blue-1 ,foreground])
   `(ansi-term-color-vector
     ;; black, red, green, yellow, blue, magenta, cyan, white
     [unspecified ,background ,red-1 ,green-1 ,yellow-1 ,blue-1 ,purple-1 ,blue-1 ,foreground])))

;;;###autoload
(when load-file-name
  (add-to-list 'custom-theme-load-path
	       (file-name-as-directory (file-name-directory load-file-name))))

(provide-theme 'soothe)
