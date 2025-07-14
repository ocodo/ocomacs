(require 's)
(require 'llm-ollama)
(use-package ellama
    :init
    (setopt ellama-keymap-prefix "C-c =")

(defvar ocomacs-ollama-hosts '("localhost"))
;;;
;;; If you don't have ollama running on localhost
;;;
;;; Change the list above with your own Ollama/LLM host(s) in ~/.config/emacs-local.el
;;;
;;; (setq ocomacs-ollama-hosts '("servername" "192.168.0.10" "10.0.0.3")  ;; etc.
;;; 
;;; Select from hosts and their models with:
;;;
;;; Run M-x ocomacs-ellama-choose-server-and-model to setup ellama on the fly.
;;;
(defun ocomacs-ellama-choose-server-and-model ()
  "Select ellama host and model"
  (interactive)
  (let* ((host (completing-read "Select host: " (ocomacs-active-ollama-servers)))
         (model-list (seq-filter
                      (lambda (line)
                        (not (or
                              (s-blank-p line)
                              (s-starts-with-p "NAME" line))))
                      (s-lines (shell-command-to-string
				(format "OLLAMA_HOST=%s:11434 ollama ls" host)))))
         (model (nth 0
                  (string-split
                    (completing-read "Select chat model: " model-list)
                   " ")))
         (naming-model (nth 0
                  (string-split
                    (completing-read "Select session naming model: " model-list)
                   " ")))
         (embedding-model (nth 0
                  (string-split
                    (completing-read "Select embedding model: " model-list)
                   " "))))
    (message "Selected chat model: %s on %s" model host)
    (setopt ellama-provider
     (make-llm-ollama
      :host host
      :chat-model model
      :embedding-model embedding-model))
    (setopt ellama-naming-provider
            (make-llm-ollama
             :host host
             :chat-model naming-model
             :embedding-model embedding-model))
    (setopt ellama-naming-scheme 'ellama-generate-name-by-llm)))

(defun ocomacs-active-ollama-servers ()
  "Check for active Ollama LLM servers"
  (interactive)
  (seq-filter 'ocomacs-ollama-server-check
              ocomacs-ollama-hosts))

(defun ocomacs-ollama-server-check (host)
  (s-contains-p "Ollama is running"
    (shell-command-to-string (format "curl -m 0.05 %s:11434" host))))

(defun ocomacs-local-ollama-server-p ()
  "Check for local Ollama LLM server."
  (let ((ollama-result))
    (ocomacs-ollama-server-check "localhost"))))


