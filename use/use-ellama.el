(require 's)
(require 'llm-ollama)
(use-package ellama
    :init
    (setopt ellama-keymap-prefix "C-c =")

(defvar ocodo/ollama-hosts '("localhost"))
;;;
;;; If you don't have ollama running on localhost
;;;
;;; Change the list above with your own Ollama/LLM host(s) in ~/.config/emacs-local.el
;;;
;;; (setq ocodo/ollama-hosts '("servername" "192.168.0.10" "10.0.0.3")  ;; etc.
;;; 
;;; Select from hosts and their models with:
;;;
;;; Run M-x ocodo/ellama-choose-server-and-model to setup ellama on the fly.
;;;
(defun ocodo/ellama-choose-server-and-model ()
  "Select ellama host and model"
  (interactive)
  (let* ((host (completing-read "Select host: " (ocodo/active-ollama-servers)))
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

(defun ocodo/active-ollama-servers ()
  "Check for active Ollama LLM servers"
  (interactive)
  (seq-filter 'ocodo/ollama-server-check
              ocodo/ollama-hosts))

(defun ocodo/ollama-server-check (host)
  (s-contains-p "Ollama is running"
    (shell-command-to-string (format "curl -m 0.05 %s:11434" host))))

(defun ocodo/local-ollama-server-p ()
  "Check for local Ollama LLM server."
  (let ((ollama-result))
    (ocodo/ollama-server-check "localhost"))))
