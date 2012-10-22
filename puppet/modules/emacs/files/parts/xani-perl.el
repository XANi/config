;;; xani-perl.el ---
;;

(defalias 'perl-mode 'sepia-mode)
(require 'sepia)

(custom-set-variables
 '(cperl-auto-newline nil)
 '(cperl-autoindent-on-semi t)
 '(cperl-electric-backspace-untabify t)
 '(cperl-indent-level 4)
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t)
 '(cperl-merge-trailing-else nil) ;; this makes newline after }, so else not '} else {'
 '(cperl-mode-hook (quote (flymake-mode)))

)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . sepia-mode))
(add-to-list 'interpreter-mode-alist '("perl" . sepia-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . sepia-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . sepia-mode))



(provide 'xani-perl)