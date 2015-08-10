;;; xani-man.el ---
;;
(custom-set-faces
 '(Man-overstrike ((t (:inherit font-lock-variable-name-face :weight bold))))
 '(Man-underline ((t (:inherit font-lock-string-face :underline t))))
 )

(custom-set-variables
 '(Man-notify-method (quote pushy))
 )

(provide 'xani-man)
