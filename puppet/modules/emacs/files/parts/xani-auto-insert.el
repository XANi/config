;;; xani-auto-insert.el ---
;;
(auto-insert-mode)  ;;; Adds hook to find-files-hook
(setq auto-insert-directory (expand-file-name "~/emacs/autoinsert")) ;;; Or use custom, *NOTE* Trailing slash important
(setq auto-insert-query nil) ;;; If you don't want to be prompted before insertion
(define-auto-insert "puppet.*\.pm$" "perl_module")
(define-auto-insert "puppet.*\.pl\.erb" "perl")
(define-auto-insert "puppet.*\.sh\.erb" "sh")
(define-auto-insert "puppet.*\.pp$" "puppet")
(define-auto-insert "puppet.*\.erb" "erb")
(define-auto-insert "puppet.*\.init" "erb")
(define-auto-insert "puppet.*\.pl" "perl")
(define-auto-insert "puppet.*\.sh" "sh")

(provide 'xani-auto-insert)