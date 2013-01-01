;;; xani-perl.el ---
;;

(defalias 'perl-mode 'cperl-mode)
;;(require 'sepia)
(require 'perltidy)

(custom-set-variables
 '(cperl-auto-newline nil)
 '(cperl-autoindent-on-semi nil)
 '(cperl-electric-backspace-untabify t)
 '(cperl-indent-level 4)
 '(cperl-close-paren-offset -4)
 '(cperl-continued-statement-offset 4)
 '(cperl-indent-parens-as-block t)
 '(cperl-tab-always-indent t)
 '(cperl-merge-trailing-else nil) ;; this makes newline after }, so else not '} else {'
 '(cperl-mode-hook (quote (flymake-mode)))

)
(add-to-list 'auto-mode-alist '("\\.\\([pP][Llm]\\|al\\)\\'" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("perl5" . cperl-mode))
(add-to-list 'interpreter-mode-alist '("miniperl" . cperl-mode))

(define-key cperl-mode-map [backtab] 'perltidy-dwim)

(provide 'xani-perl)