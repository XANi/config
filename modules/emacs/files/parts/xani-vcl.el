
;;; xani-vcl.el ---
;;

(require 'vcl-mode)
(setq
 vcl-indent-level 4
)
; \\' end of file
(add-to-list 'auto-mode-alist '(".*vcl\\(\\|.erb\\)\\'" . vcl-mode))
(provide 'xani-vcl)

