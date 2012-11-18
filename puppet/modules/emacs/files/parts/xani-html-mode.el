;;; xani-html.el ---
;;
(require 'zencoding-mode)
(add-hook 'sgml-mode-hook 'zencoding-mode)
(add-to-list 'auto-mode-alist '(".*html\\(\\|.ep\\)\\'" . sgml-mode))
;;(add-to-list 'auto-mode-alist '("\\.\\([pP][pP]\\)\\'" . puppet-mode))
(setq
 sgml-basic-offset 4
 )
(provide 'xani-html-mode)
