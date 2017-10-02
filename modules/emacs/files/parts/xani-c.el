;;; xani-c.el ---
;;
(custom-set-variables
 '(c-basic-offset 4)
 '(c-indent-comments-syntactically-p t)
 '(c-set-style "K&R")
)

(defun linux-c-mode ()
"C mode with adjusted defaults for use with the Linux kernel."
  (interactive)
  (c-mode)
  (c-set-style "K&R")
  (whitespace-mode)
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 8))

;(setq auto-mode-alist (append '(("\\.c$" . linux-c-mode))
;      auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.c$" . linux-c-mode))
(provide 'xani-c)
