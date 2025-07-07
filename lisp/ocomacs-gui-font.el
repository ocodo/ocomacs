;;; Config your preferred font and font-size

;;; Install ocodo-mono at ~/.local/share/fonts with (ocomacs-install-ocodo-mono)
;;; View at https://github.com/ocodo/ocodo-mono
;;; Download complete font set zip
;;; https://github.com/ocodo/ocodo-mono/releases/latest/download/OcodoMono-NerdFont.zip

(defvar ocomacs-personal-mono-font
  (font-spec
   :family "OcodoMono Nerd Font"
   :weight 'thin)
  "Personal default monospaced - font spec - Nerd Fonts recommended")

(defvar ocomacs-preferred-font-height
  160 "size in 1/10pt")
