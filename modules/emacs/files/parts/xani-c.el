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
  (setq tab-width 4)
  (setq indent-tabs-mode t)
  (setq c-basic-offset 4)
)

(setq auto-mode-alist (cons '("*.c" . linux-c-mode)
                            auto-mode-alist))

(provide 'xani-c)