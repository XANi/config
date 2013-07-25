;;; xani-mediawiki.el ---
;;

(provide 'xani-mediawiki)
(require 'mediawiki)
(add-to-list 'auto-mode-alist '("itsalltext.*txt\\'" . mediawiki-mode))

(add-hook 'mediawiki-mode-hook
          (lambda ()
            (if (string-match "itsalltext" buffer-file-name)
            (local-set-key (kbd "C-x C-s") 'save-buffer)
            nil
            )
          )
)
