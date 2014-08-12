;;; xani-common-late.el ---
;;


(require 'diminish)
(diminish 'protect-buffer-from-kill-mode "ᛞ")
(diminish 'yas-minor-mode "𐤊")
(diminish 'global-whitespace-newline-mode "")
(diminish 'global-whitespace-mode "")
(diminish 'whitespace-newline-mode "")
(diminish 'whitespace-mode "")
(diminish 'undo-tree-mode "")
(diminish 'server-buffer-clients "")
(diminish 'overwrite-mode "✗")
(diminish 'company-mode "ᴒ")


(diminish 'visual-line-mode "Ꮴ")

(eval-after-load "hideshow" '(diminish 'hs-minor-mode "ዛ"))

(add-hook 'emacs-lisp-mode-hook
  (lambda()
    (setq mode-name "ELisp")))


(add-hook 'lisp-interaction-mode-hook
  (lambda()
    (setq mode-name "LispInt")))

(eval-after-load "flycheck" '(diminish 'flycheck-mode "✈"))
(eval-after-load "develock" '(diminish 'font-lock-mode "Ꮅ"))

(provide 'xani-late)
