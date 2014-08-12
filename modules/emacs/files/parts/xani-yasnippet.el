;;; xani-yasnippet.el ---
;;
;; new snippets go to first dir on list
(custom-set-variables
 '(yas-global-mode t nil (yasnippet))
 '(yas-snippet-dirs
   (quote
    (
     "/home/xani/emacs/yasnippet/custom"
     "/home/xani/emacs/yasnippet/import"
     "/home/xani/emacs/yasnippet/xani"
     "/home/xani/emacs/yasnippet/vendor"
    ) ))
 )
(require 'yasnippet)
(mapc 'yas/load-directory yas/root-directory)
(provide 'xani-yasnippet)
