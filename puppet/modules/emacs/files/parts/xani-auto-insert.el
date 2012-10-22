;;; xani-auto-insert.el ---
;;
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory (expand-file-name "~/emacs/autoinsert")) ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(define-auto-insert "puppet.*\.pp$" "init.pp")
(define-auto-insert "puppet.*\.erb" "puppet.erb")
(define-auto-insert "puppet.*\.init" "puppet.erb")
(define-auto-insert "puppet.*\.pl" "perl.erb")
(define-auto-insert "puppet.*\.sh" "sh.erb")

(provide 'xani-auto-insert)