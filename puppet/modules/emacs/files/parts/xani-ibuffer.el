;;; xani-ibuffer.el ---
;;

;; use ibuffer by default
(global-set-key (kbd "C-x C-b") 'ibuffer)
(autoload 'ibuffer "ibuffer" "List buffers." t)

(provide 'xani-ibuffer)