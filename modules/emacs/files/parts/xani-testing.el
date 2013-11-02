;;; xani-testing.el ---
;;

;; random shit in testing
(global-set-key "\M-`" 'hippie-expand)


;; test clipboard fix
(setq
 x-select-enable-clipboard t
 x-select-request-type (quote UTF8_STRING)
 yank-pop-change-selection t
)

(provide 'xani-testing)
