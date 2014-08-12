;;; xani-testing.el ---
;;

;; random shit in testing

;; test clipboard fix
;; (setq
;;  x-select-enable-clipboard t
;;  yank-pop-change-selection t
;;  select-active-regions t
;;)



(defalias 'server-kill-buffer-query-function '(lambda () t))

;; or
;; (remove-hook 'kill-buffer-query-functions 'server-kill-buffer-query-function)*
;; somewhere after emacs server loaded

(provide 'xani-testing)
