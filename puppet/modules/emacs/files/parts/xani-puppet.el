;;; xani-puppet.el ---
;;

(require 'flymake-puppet)
(require 'puppet-mode)

(add-hook 'puppet-mode-hook         'hs-minor-mode)
(add-hook 'puppet-mode-hook (lambda () (flymake-puppet-load)))
(add-to-list 'auto-mode-alist '("\\.\\([pP][pP]\\)\\'" . puppet-mode))

(custom-set-variables
 '(puppet-comment-column 64)
 '(puppet-include-indent 4)
 '(puppet-indent-level 4)
)

(provide 'xani-puppet)