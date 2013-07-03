;;; xani-common-late.el ---
;;


(custom-set-variables
 '(diminished-minor-modes
   (
    quote (
           (flymake-mode . "✈")
           (global-whitespace-newline-mode . "")
           (global-whitespace-mode . "")
           (whitespace-newline-mode . "")
           (whitespace-mode . "")
           (undo-tree-mode . "")
           (server-buffer-clients . "")
           (yas/minor-mode . "𐤊")
           (overwrite-mode . "✗")
           )
          )
   )
)

(require 'diminish)
(eval-after-load "hideshow" '(diminish 'hs-minor-mode "ዛ"))

(provide 'xani-late)
