;;; xani-ruby.el ---
;;
(setq
 ruby-indent-level 2
 ruby-insert-encoding-magic-comment nil
)
(defun efi-ruby-mode ()
  "Ruby mode with adjusted indent"
  (interactive)
  (ruby-mode)
  (setq-local
   ruby-indent-level 4 ;; 2 indent is ugly
   )
 )
(add-to-list 'auto-mode-alist '(".*/src/puppet.*\\.\\(rb\\)\\'" . efi-ruby-mode))


(provide 'xani-ruby)
