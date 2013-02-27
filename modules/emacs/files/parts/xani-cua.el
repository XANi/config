;;; xani-cua.el ---
;;

(provide 'xani-cua)
(cua-mode t)
(setq cua-enable-cua-keys nil) ;; we dont want windows C-v C-c C-p copy paste
(setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
(transient-mark-mode 1) ;; No region when it is not highlighted
(setq cua-keep-region-after-copy t)
