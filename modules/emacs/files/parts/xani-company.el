;;; xani-company.el ---
;;
(global-company-mode)

(global-set-key "\M-`" 'company-complete-common)

(custom-set-faces
'(company-preview ((t (:inherit font-lock-type-face))))
 '(company-preview-search ((t (:inherit company-preview :background "blue1"))))
 '(company-scrollbar-bg ((t (:inherit company-tooltip))))
 '(company-tooltip ((t (:inherit font-lock-builtin-face))))
 '(company-tooltip-common-selection ((t (:inherit company-tooltip-selection))))
 '(company-tooltip-selection ((t (:inherit company-tooltip :background "dark red"))))
)
(setq company-idle-delay 0.3)
(setq company-abort-manual-when-too-short t)
(setq company-go-show-annotation t)
;;(setq company-tooltip-align-annotations t)

(provide 'xani-company)
