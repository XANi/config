;;; xani-org-mode-home.el ---
;;

(setq
  org-todo-keywords '((type "TODO(t!)" "NEXT(n!)" "WAIT(w!)" "|" "DONE(d!)" "CANCELLED(c@)"))
  org-directory "~/emacs/org/share"
  org-agenda-files '("~/emacs/org/share")
  org-mobile-files '("~/emacs/org/share")
  org-mobile-directory "~/emacs/org/mobile.org/share"
  org-mobile-inbox-for-pull "~/emacs/org/share/mobile.org"
  org-combined-agenda-icalendar-file "~/emacs/org/share.ics"

)

(provide 'xani-org-mode-home)