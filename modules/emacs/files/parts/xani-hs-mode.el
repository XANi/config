;;; xani-hs-mode.el ---
;;

(global-set-key (kbd "<C-tab>") 'hs-toggle-hiding)

(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)

    (defun display-code-line-counts (ov)
      (when (eq 'code (overlay-get ov 'hs))
        (overlay-put ov 'help-echo
                     (buffer-substring (overlay-start ov)
                                       (overlay-end ov)))))
    (setq hs-set-up-overlay 'display-code-line-counts)
(custom-set-variables
  '(hs-isearch-open t)
)
(provide 'xani-hs-mode)