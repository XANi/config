;;; xani-yasnippet.el ---
;;
(require 'yasnippet)

;; new snippets go to first dir on list
(setq yas/root-directory
      '(
        "/home/xani/emacs/yasnippet/custom"
        "/home/xani/emacs/yasnippet/import"
        "/home/xani/emacs/yasnippet/xani"
        "/home/xani/emacs/yasnippet/vendor"
        )

      hippie-expand-try-functions-list (quote (
                                               yas/hippie-try-expand
                                               try-complete-file-name-partially
                                               try-complete-file-name
                                               try-expand-all-abbrevs
                                               try-expand-list
                                               try-expand-line
                                               try-expand-dabbrev
                                               try-expand-dabbrev-all-buffers
                                               try-expand-dabbrev-from-kill
                                               try-complete-lisp-symbol-partially
                                               try-complete-lisp-symbol
                                               )
                                              )
)
(yas/initialize)
(mapc 'yas/load-directory yas/root-directory)
(provide 'xani-yasnippet)
