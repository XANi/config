;;; xani-yasnippet.el ---
;;
(require 'yasnippet)

;; new snippets go to first dir on list
(setq yas/root-directory
      '(
        "/home/xani/emacs/yasnippet/custom"
        "/home/xani/emacs/yasnippet/vendor"
        "/home/xani/emacs/yasnippet/xani"
        ))

(yas/initialize)
(mapc 'yas/load-directory yas/root-directory)
(provide 'xani-yasnippet)
