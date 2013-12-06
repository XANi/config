;;; xani-puppet.el ---
;;

(require 'flymake-puppet)
(require 'puppet-mode)

(add-hook 'puppet-mode-hook         'hs-minor-mode)
(add-hook 'puppet-mode-hook (lambda () (flymake-puppet-load)))
(add-to-list 'auto-mode-alist '("\\.\\([pP][pP]\\)\\'" . puppet-mode))

(setq
 puppet-comment-column 64
 puppet-include-indent 4
 puppet-indent-level 4
 flymake-puppet-executable "puppet-lint-emacs"
)
(provide 'xani-puppet)
