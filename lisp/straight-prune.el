(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (if (file-exists-p bootstrap-file)
      (progn
	(load bootstrap-file)
	(message "ocomacs: checking for unused packages...")
	(straight-prune-build)
	(message "ocomacs: done pruning."))
    (message "ocomacs: no build cannot prune.")))
