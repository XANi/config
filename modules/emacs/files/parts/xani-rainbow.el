;;; xani-rainbow.el ---
;;

(defun shoot-rainbow-set-face ()
  (set-face-attribute 'rainbow-delimiters-depth-1-face   nil :foreground "#4444aa" )
  (set-face-attribute 'rainbow-delimiters-depth-2-face   nil :foreground "#00ff00" )
  (set-face-attribute 'rainbow-delimiters-depth-3-face   nil :foreground "#00cccc" )
  (set-face-attribute 'rainbow-delimiters-depth-4-face   nil :foreground "#884444" )
  (set-face-attribute 'rainbow-delimiters-depth-5-face   nil :foreground "#73f" )
  (set-face-attribute 'rainbow-delimiters-depth-6-face   nil :foreground "#e35" )
  (set-face-attribute 'rainbow-delimiters-depth-7-face   nil :foreground "#f54" )
  (set-face-attribute 'rainbow-delimiters-depth-8-face   nil :foreground "#ff6" )
  (set-face-attribute 'rainbow-delimiters-depth-9-face   nil :foreground "#fff00" )
  (set-face-attribute 'rainbow-delimiters-unmatched-face nil :foreground "#600" )
)
(eval-after-load "rainbow-delimiters" '(shoot-rainbow-set-face))

(provide 'xani-rainbow)
