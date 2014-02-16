;;; xani-ido.el ---
;;

(require 'ido)
(ido-mode t)
;;(ido-vertical-mode t)
;;(ido-ubiquitous-mode t)
(setq ido-everywhere t)
(ido-better-flex/enable)

(provide 'xani-ido)
