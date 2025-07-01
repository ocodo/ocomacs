;;; Config your preferred font and font-size

;;; Install ocodo-mono with (ocodo/install-ocodo-mono)
;;; View at https://github.com/ocodo/ocodo-mono

(defvar personal-mono-font  
  (font-spec
   :foundry "ocod"
   :family "OcodoMono Nerd Font"
   :weight 'thin)
  
  "Personal default monospaced - font spec - Nerd Fonts recommended")

(defvar preferred-font-size
  160
  "size in 1/10pt")
