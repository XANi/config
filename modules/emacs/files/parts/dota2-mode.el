;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.
(define-generic-mode 'dota2-mode
'("//")
'(;; keywords
  ;; generated via con_logfile /tmp/asd.log ; cvarlist
  ;; cat /tmp/asd.log |perl -pe 's/^(.*?)\ .*/\"\1\"/'  >/tmp/vars
  ;; "say_student"
)
 '(
   ("\\(bind\\)" . 'font-lock-builtin-face)
   ("\\(alias\\)" . font-lock-variable-name-face)
   ("\\(dota_[a-zA-Z_]+\\)" . font-lock-constant-face)
   ("\\(^\s*[a-zA-Z_]+\\)" . 'font-lock-keyword-face)
   )
 '(".*/dota2.*\\.\\(erb\\|cfg\\)")
      nil
      "Generic mode for Dota2 files.")
(provide 'dota2-mode)
