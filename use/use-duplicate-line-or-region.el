;;; replacement, mininal ocodo-handy-functions

(defun duplicate-current-line-or-region (arg &optional up)
  ;; Originally swiped from rejeep's emacs.d rejeep-defuns.el.
  "Duplicates the current line or region ARG times.

If UP is non-nil, duplicate and move point to the top."
  (interactive "p")
  (let (beg
        end
        (origin (point))
        (saved-region
         (when (use-region-p) (list (region-beginning) (region-end)))))
    (if (and (use-region-p) (> (point) (mark)))
        (exchange-point-and-mark))
    (setq beg (line-beginning-position))
    (if (use-region-p)
        (exchange-point-and-mark))
    (setq end (line-end-position))
    (let ((region (buffer-substring-no-properties beg end)))
      (dotimes (i arg)
        (goto-char end)
        (newline)
        (insert region)
        (setq end (point)))
      (if up
          (goto-char origin)
        (goto-char (+ origin (* (length region) arg) arg)))
      (when saved-region
        (if up
            (progn (message "setting region (up)")
                   (push-mark-command nil)
                   (goto-char (nth 1 saved-region))
                   (exchange-point-and-mark))
          (progn (message "setting region")
                 (push-mark-command nil)
                 (goto-char (- (point) (length region)))))
        (setq deactivate-mark nil)))))

(defun duplicate-current-line-or-region-up (arg)
  "Duplicates the current line or region up ARG times."
  (interactive "p")
  (duplicate-current-line-or-region arg t))

(bind-key "S-M-<down>" 'duplicate-current-line-or-region)
(bind-key "S-M-<up>" 'duplicate-current-line-or-region-up)
