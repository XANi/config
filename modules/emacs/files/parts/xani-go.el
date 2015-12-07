;;; xani-go.el ---
;;

(provide 'xani-go)
(add-hook 'go-mode-hook (lambda ()
  (set (make-local-variable 'company-backends) '(company-go company-etags company-gtags company-keywords))
  (company-mode)))
